-- Contact Manager: spawns, maintains, and expires contacts on a band.
-- Each contact lives for a random lifetime and occupies a unique frequency slot.
-- QSB (signal fading) is applied to rare/dxpedition contacts.

ContactManager = {}

-- Rarity → signal strength base
local STRENGTH_BASE = {
    common      = 0.75,
    uncommon    = 0.55,
    rare        = 0.35,
    dxpedition  = 0.20,
}

-- Rarity → lifetime multiplier (rare dx stays shorter)
local LIFETIME_MULT = {
    common      = 2.0,
    uncommon    = 1.5,
    rare        = 1.0,
    dxpedition  = 0.6,
}

local _contacts    = {}   -- active contact array
local _bandId      = nil
local _hzLow       = 0
local _hzHigh      = 0
local _elapsed     = 0    -- seconds since last update
local _spawnTimer  = 0    -- countdown to next spawn attempt (seconds)
local _maxContacts = config.maxContactsPerBand

-- QSB parameters for rare contacts
local QSB_PERIOD_MIN = 8   -- seconds for one fade cycle
local QSB_PERIOD_MAX = 20

local function randomFreq()
    -- Avoid band edges (±5 kHz)
    local margin = 5000
    return math.random(_hzLow + margin, _hzHigh - margin)
end

local function freqOccupied(freq)
    local minSep = 3000  -- minimum 3 kHz spacing
    for _, c in ipairs(_contacts) do
        if math.abs(c.freq - freq) < minSep then return true end
    end
    return false
end

-- Effective max contacts for this band, scaled by propagation.
-- A closed band (spawnMultiplier 0) yields 0 → no contacts.
local function effectiveMax()
    local mult = Propagation.spawnMultiplier(_bandId)
    if mult <= 0 then return 0 end
    -- Scale, but always allow at least 1 contact on any open-ish band.
    return math.max(1, math.floor(config.maxContactsPerBand * mult + 0.5))
end

local function spawnContact()
    -- Propagation gate: closed bands spawn nothing.
    if Propagation.spawnMultiplier(_bandId) <= 0 then return end
    if #_contacts >= effectiveMax() then return end

    local entity   = DXCC.random(_bandId)
    local callsign = Callsign.generate(entity.prefix)
    local freq     = randomFreq()

    -- Retry up to 5 times to find clear freq
    local tries = 0
    while freqOccupied(freq) and tries < 5 do
        freq  = randomFreq()
        tries = tries + 1
    end
    if freqOccupied(freq) then return end  -- band full

    local lifetime = config.contactLifetimeMin
                   + math.random() * (config.contactLifetimeMax - config.contactLifetimeMin)
    lifetime = lifetime * (LIFETIME_MULT[entity.rarity] or 1.0)

    local strengthBase = STRENGTH_BASE[entity.rarity] or 0.5
    -- Scale base signal strength by propagation conditions for this band.
    strengthBase = strengthBase * Propagation.strengthMultiplier(_bandId)
    -- Small random variation ±0.1
    local strength = math.max(0.05, math.min(1.0, strengthBase + (math.random() - 0.5) * 0.2))

    local contact = {
        callsign  = callsign,
        entity    = entity.entity,
        prefix    = entity.prefix,
        rarity    = entity.rarity,
        points    = entity.pts,
        freq      = freq,
        strength  = strength,
        lifetime  = lifetime,
        age       = 0,
        -- QSB
        hasQSB    = entity.rarity == "rare" or entity.rarity == "dxpedition",
        qsbPhase  = math.random() * math.pi * 2,
        qsbPeriod = QSB_PERIOD_MIN + math.random() * (QSB_PERIOD_MAX - QSB_PERIOD_MIN),
        -- Current display strength (after QSB applied)
        displayStrength = strength,
    }

    _contacts[#_contacts + 1] = contact
end

local function pickSpawnDelay()
    -- Spawn a new contact every 5-15 seconds (scaled by how full the band is)
    local maxC = math.max(1, effectiveMax())
    local fill = #_contacts / maxC
    return 5 + math.random() * 10 + fill * 15
end

-- ── Public API ───────────────────────────────────────────────────────────────

function ContactManager.init(bandId, hzLow, hzHigh)
    _bandId    = bandId
    _hzLow     = hzLow
    _hzHigh    = hzHigh
    _contacts  = {}
    _elapsed   = 0
    _spawnTimer = 0

    -- Seed some initial contacts, gated by propagation (closed band = none).
    -- Cap the seed count by the band's effective max so closed/poor bands
    -- start sparse or empty.
    local seedCount = math.min(math.random(2, 4), effectiveMax())
    for _ = 1, seedCount do spawnContact() end
    _spawnTimer = pickSpawnDelay()
end

-- dt: seconds since last frame
function ContactManager.update(dt)
    _elapsed    = _elapsed + dt
    _spawnTimer = _spawnTimer - dt

    -- Apply QSB and age contacts
    local toRemove = {}
    for i, c in ipairs(_contacts) do
        c.age = c.age + dt

        -- QSB: sinusoidal fading for rare contacts
        if c.hasQSB then
            local phase = c.qsbPhase + (c.age / c.qsbPeriod) * math.pi * 2
            -- Modulate strength 0.3–1.0
            c.displayStrength = c.strength * (0.65 + 0.35 * math.sin(phase))
            c.displayStrength = math.max(0.05, c.displayStrength)
        else
            c.displayStrength = c.strength
        end

        if c.age >= c.lifetime then
            toRemove[#toRemove + 1] = i
        end
    end

    -- Remove expired (iterate backwards)
    for i = #toRemove, 1, -1 do
        table.remove(_contacts, toRemove[i])
    end

    -- Spawn new contact when timer fires
    if _spawnTimer <= 0 then
        spawnContact()
        _spawnTimer = pickSpawnDelay()
    end
end

function ContactManager.getContacts()
    return _contacts
end

-- Return contacts suitable for panadapter rendering (uses displayStrength)
function ContactManager.getPanadapterBlips()
    local blips = {}
    for _, c in ipairs(_contacts) do
        blips[#blips + 1] = {
            freq      = c.freq,
            strength  = c.displayStrength,
            rarity    = c.rarity,
            callsign  = c.callsign,
        }
    end
    return blips
end

-- Find the nearest contact to a given frequency.
-- Returns contact, offsetHz (signed: positive = VFO above signal)
function ContactManager.findNearest(vfoFreq)
    local best     = nil
    local bestDist = math.huge
    for _, c in ipairs(_contacts) do
        local d = math.abs(c.freq - vfoFreq)
        if d < bestDist then
            bestDist = d
            best     = c
        end
    end
    if best == nil then return nil, 0 end
    return best, vfoFreq - best.freq
end

function ContactManager.removeWorked(callsign)
    -- Don't actually remove — let it expire naturally.
    -- We mark it as worked in the operate scene.
end

return ContactManager
