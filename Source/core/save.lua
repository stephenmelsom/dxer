-- Persistent save/load via playdate.datastore.
-- Call save.load() on boot; save.write() any time state changes.

save = {}

local DEFAULTS = {
    -- Meta
    version = 1,
    -- Settings
    soundEnabled = true,
    musicEnabled = true,
    crankSensitivity = 1.0,
    -- Story mode
    story = {
        day         = 1,
        cash        = 0,
        sessionPts  = 0,     -- points scored this session (not yet converted)
        totalPoints = 0,
        lastTotalPoints = 0, -- baseline for per-session point delta
        lastLogbookCount = 0,-- baseline for per-session contact delta
        logbook     = {},    -- array of {call, entity, band, mode, points, time}
        equipment   = {
            radio    = "ht_2m",
            antenna  = "rubber_duck",
            amp      = nil,
            location = "apartment",
            mode     = "fm",
        },
        owned = {            -- sets of owned item ids by category
            radios    = { ht_2m = true },
            antennas  = { rubber_duck = true },
            amplifiers = {},
            locations = { apartment = true },
        },
        dxccWorked  = {},    -- set: entity → true
    },
    -- Tournament mode
    tournament = {
        highScore = 0,
        bestRound = 0,
    },
    -- Last selected mode ("story" | "tournament")
    lastMode = "story",
}

local _data = nil

local function deepcopy(orig)
    local copy
    if type(orig) == "table" then
        copy = {}
        for k, v in pairs(orig) do
            copy[k] = deepcopy(v)
        end
    else
        copy = orig
    end
    return copy
end

function save.load()
    local stored = playdate.datastore.read()
    if stored then
        -- Merge stored data over defaults so new keys appear on upgrade
        _data = deepcopy(DEFAULTS)
        for k, v in pairs(stored) do
            if type(v) == "table" and type(_data[k]) == "table" then
                for k2, v2 in pairs(v) do
                    _data[k][k2] = v2
                end
            else
                _data[k] = v
            end
        end
    else
        _data = deepcopy(DEFAULTS)
    end
    return _data
end

function save.write()
    if _data then
        playdate.datastore.write(_data)
    end
end

function save.delete()
    _data = deepcopy(DEFAULTS)
    playdate.datastore.delete()
end

function save.get()
    return _data
end

-- Returns true if the current story save has real progress worth continuing.
function save.hasStoryProgress()
    if not _data or not _data.story then return false end
    local s = _data.story
    return (#(s.logbook or {}) > 0)
        or ((s.day or 1) > 1)
        or ((s.totalPoints or 0) > 0)
end

-- Reset story progress to a fresh default story WITHOUT touching global
-- settings (sound/music/crank), tutorialSeen, lastMode, or tournament record.
function save.newStory()
    if not _data then
        _data = deepcopy(DEFAULTS)
    end
    _data.story = deepcopy(DEFAULTS.story)
    save.write()
end

return save
