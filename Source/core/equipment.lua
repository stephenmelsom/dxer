-- Equipment catalog and player inventory.
-- Each item has id, type, stats, and unlock cost (for M5 shop).

Equipment = {}

-- ── Catalog ─────────────────────────────────────────────────────────────────

local CATALOG = {
    -- ── Radios ──────────────────────────────────────────────────────────────
    radios = {
        {
            id = "ht_2m", name = "2m Handheld",
            bands  = { "2m" },
            modes  = { "fm" },
            txPower = 5,         -- watts
            rxSens  = 0.6,       -- 0-1 receive sensitivity multiplier
            cost    = 0,         -- starter gear (free)
            tier    = 1,
        },
        {
            id = "mobile_2m70", name = "2m/70cm Mobile",
            bands  = { "2m", "70cm" },
            modes  = { "fm", "ssb" },
            txPower = 50,
            rxSens  = 0.75,
            cost    = 200,
            tier    = 2,
        },
        {
            id = "mobile_hf", name = "HF Mobile",
            bands  = { "10m","15m","20m","40m","80m","2m" },
            modes  = { "ssb","cw","fm" },
            txPower = 100,
            rxSens  = 0.80,
            cost    = 800,
            tier    = 3,
        },
        {
            id = "base_hf", name = "HF Base Station",
            bands  = { "160m","80m","40m","20m","15m","10m","6m","2m" },
            modes  = { "ssb","cw","fm" },
            txPower = 100,
            rxSens  = 0.90,
            cost    = 2500,
            tier    = 4,
        },
        {
            id = "flagship", name = "Flagship 1500W Station",
            bands  = { "160m","80m","40m","20m","15m","10m","6m","2m" },
            modes  = { "ssb","cw","fm" },
            txPower = 1500,
            rxSens  = 1.0,
            cost    = 15000,
            tier    = 5,
        },
    },
    -- ── Antennas ────────────────────────────────────────────────────────────
    antennas = {
        {
            id = "rubber_duck", name = "Rubber Duck",
            bands = { "2m" },
            gain  = -3,      -- dBd
            cost  = 0,
            tier  = 1,
        },
        {
            id = "jpole_2m", name = "J-Pole (2m)",
            bands = { "2m" },
            gain  = 2,
            cost  = 50,
            tier  = 2,
        },
        {
            id = "wire_dipole", name = "Wire Dipole (HF)",
            bands = { "40m","80m","160m","20m","15m","10m" },
            gain  = 0,
            cost  = 150,
            tier  = 2,
        },
        {
            id = "vertical_hf", name = "HF Vertical",
            bands = { "160m","80m","40m","20m","15m","10m","6m" },
            gain  = 1,
            cost  = 400,
            tier  = 3,
        },
        {
            id = "yagi_hf", name = "3-El Yagi (HF)",
            bands = { "20m","15m","10m" },
            gain  = 8,
            cost  = 1200,
            tier  = 4,
            directional = true,
        },
        {
            id = "tribander", name = "Tribander Beam",
            bands = { "20m","15m","10m","6m" },
            gain  = 9,
            cost  = 3000,
            tier  = 5,
            directional = true,
        },
    },
    -- ── Amplifiers ──────────────────────────────────────────────────────────
    amplifiers = {
        {
            id = "amp_100",  name = "100W Amp",   mult = 1.0, cost = 500,  tier = 2 },
        {
            id = "amp_500",  name = "500W Amp",   mult = 5.0, cost = 2000, tier = 3 },
        {
            id = "amp_1500", name = "1500W Amp",  mult = 15.0,cost = 8000, tier = 5 },
    },
    -- ── Locations ───────────────────────────────────────────────────────────
    locations = {
        {
            id = "apartment", name = "Apartment",
            noiseMod = -2,   -- dB noise floor increase (bad)
            heightM  = 10,
            cost     = 0,
            tier     = 1,
        },
        {
            id = "house", name = "House",
            noiseMod = 0,
            heightM  = 15,
            cost     = 2000,
            tier     = 2,
        },
        {
            id = "hilltop", name = "Hilltop QTH",
            noiseMod = 2,
            heightM  = 200,
            cost     = 8000,
            tier     = 3,
        },
        {
            id = "mountain", name = "Mountain + Mast",
            noiseMod = 5,
            heightM  = 1200,
            cost     = 25000,
            tier     = 5,
        },
    },
}

-- ── Active loadout ───────────────────────────────────────────────────────────

local _radio    = nil
local _antenna  = nil
local _amp      = nil
local _location = nil
local _mode     = "fm"    -- current operating mode

local function findById(list, id)
    for _, item in ipairs(list) do
        if item.id == id then return item end
    end
    return nil
end

function Equipment.init(loadout)
    local l = loadout or {}
    _radio    = findById(CATALOG.radios,    l.radio    or "ht_2m")
    _antenna  = findById(CATALOG.antennas,  l.antenna  or "rubber_duck")
    _amp      = l.amp and findById(CATALOG.amplifiers, l.amp) or nil
    _location = findById(CATALOG.locations, l.location or "apartment")
    _mode     = l.mode or "fm"
end

-- ── Capability queries ───────────────────────────────────────────────────────

-- Returns set of bands available with current radio + antenna
function Equipment.availableBands()
    local set = {}
    if not _radio or not _antenna then return set end
    for _, rb in ipairs(_radio.bands) do
        for _, ab in ipairs(_antenna.bands) do
            if rb == ab then set[rb] = true end
        end
    end
    return set
end

function Equipment.canUseBand(bandId)
    return Equipment.availableBands()[bandId] == true
end

function Equipment.availableModes()
    return _radio and _radio.modes or {}
end

function Equipment.canUseMode(mode)
    if not _radio then return false end
    for _, m in ipairs(_radio.modes) do
        if m == mode then return true end
    end
    return false
end

function Equipment.getTxPower()
    local base = _radio and _radio.txPower or 5
    local mult = _amp and _amp.mult or 1.0
    return base * mult
end

function Equipment.getRxSens()
    local base = _radio and _radio.rxSens or 0.5
    local locBonus = _location and (_location.noiseMod * 0.02) or 0
    return math.min(1.0, base + locBonus)
end

function Equipment.getMode()  return _mode  end

function Equipment.setMode(mode)
    if Equipment.canUseMode(mode) then
        _mode = mode
        return true
    end
    return false
end

function Equipment.cycleMode()
    local modes = Equipment.availableModes()
    if #modes == 0 then return end
    local current = _mode
    for i, m in ipairs(modes) do
        if m == current then
            _mode = modes[(i % #modes) + 1]
            return
        end
    end
    _mode = modes[1]
end

-- Zero-beat threshold modifier per mode
function Equipment.zeroHzModifier()
    if _mode == "cw"  then return 0.3   end  -- CW: much tighter tolerance
    if _mode == "fm"  then return 999   end  -- FM: no zero-beat (on-channel)
    return 1.0                                -- SSB: normal
end

-- Points multiplier per mode
function Equipment.pointsMultiplier()
    if _mode == "cw"  then return 2.0  end
    if _mode == "fm"  then return 0.8  end
    return 1.0
end

function Equipment.getRadio()    return _radio    end
function Equipment.getAntenna()  return _antenna  end
function Equipment.getAmp()      return _amp      end
function Equipment.getLocation() return _location end

function Equipment.catalog()     return CATALOG   end

-- Serialize for save
function Equipment.toSaveTable()
    return {
        radio    = _radio    and _radio.id    or "ht_2m",
        antenna  = _antenna  and _antenna.id  or "rubber_duck",
        amp      = _amp      and _amp.id      or nil,
        location = _location and _location.id or "apartment",
        mode     = _mode,
    }
end

return Equipment
