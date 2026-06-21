-- Propagation model: per-band conditions based on time-of-day and solar flux.
-- Condition values: "closed" | "poor" | "good" | "open"
-- Contact spawn rates and signal strengths are scaled by condition.

Propagation = {}

-- Solar flux index (pseudo-random per day, 60-250)
local _solarFlux    = 100
local _aIndex       = 5    -- geomagnetic A-index (low = quiet, high = disturbed)

-- Condition → spawn multiplier
local CONDITION_SPAWN = {
    closed = 0,
    poor   = 0.25,
    good   = 0.65,
    open   = 1.0,
}

-- Condition → strength multiplier
local CONDITION_STRENGTH = {
    closed = 0,
    poor   = 0.4,
    good   = 0.7,
    open   = 1.0,
}

-- Per-band propagation rules: returns "closed"|"poor"|"good"|"open"
-- based on hour (0-23) and solar flux.
local function bandCondition(bandId, hour, flux)
    local isDay   = hour >= 6 and hour < 20
    local isDawn  = hour >= 5 and hour < 8
    local isDusk  = hour >= 18 and hour < 22
    local isNight = not isDay

    -- High A-index degrades HF propagation
    local geoDisturbed = _aIndex > 20

    if bandId == "2m" then
        -- VHF: always local-only regardless of conditions
        return "good"
    elseif bandId == "6m" then
        -- Sporadic-E: unpredictable; simplified as occasional opens
        if flux > 150 and isDay then return "open"
        elseif flux > 100 and isDay then return "good"
        else return "poor" end
    elseif bandId == "10m" then
        if geoDisturbed then return "closed" end
        if flux > 150 and isDay then return "open"
        elseif flux > 100 and isDay then return "good"
        elseif isDay then return "poor"
        else return "closed" end
    elseif bandId == "15m" then
        if geoDisturbed then return "poor" end
        if flux > 130 and isDay then return "open"
        elseif isDay then return "good"
        else return "closed" end
    elseif bandId == "20m" then
        if isDay then
            return (flux > 100) and "open" or "good"
        elseif isDusk or isDawn then
            return "good"
        else
            return "poor"
        end
    elseif bandId == "40m" then
        if isNight then
            return geoDisturbed and "poor" or "good"
        elseif isDawn or isDusk then
            return "good"
        else
            return "poor"
        end
    elseif bandId == "80m" then
        if isNight then
            return geoDisturbed and "poor" or "open"
        elseif isDawn or isDusk then
            return "good"
        else
            return "closed"
        end
    elseif bandId == "160m" then
        if isNight then
            return geoDisturbed and "closed" or "good"
        else
            return "closed"
        end
    end
    return "poor"
end

function Propagation.init(dayNumber)
    -- Seed solar flux pseudo-randomly from day number
    math.randomseed(dayNumber or 1)
    _solarFlux = 60 + math.random(190)
    _aIndex    = math.random(0, 30)
    -- Re-seed so in-game spawns are independently random
    math.randomseed(playdate.getSecondsSinceEpoch())
end

function Propagation.getCondition(bandId)
    return bandCondition(bandId, Clock.hour(), _solarFlux)
end

-- Returns the condition for a band at an arbitrary hour (0-23), using the
-- current day's solar flux. Used by the Solar Report to preview time-of-day.
function Propagation.conditionAt(bandId, hour)
    return bandCondition(bandId, hour, _solarFlux)
end

-- Returns all band conditions as a table {bandId → condition}
function Propagation.getAllConditions()
    local result = {}
    for _, b in ipairs(Band.all()) do
        result[b.id] = bandCondition(b.id, Clock.hour(), _solarFlux)
    end
    return result
end

function Propagation.spawnMultiplier(bandId)
    return CONDITION_SPAWN[Propagation.getCondition(bandId)] or 0
end

function Propagation.strengthMultiplier(bandId)
    return CONDITION_STRENGTH[Propagation.getCondition(bandId)] or 0
end

function Propagation.getSolarFlux() return _solarFlux end
function Propagation.getAIndex()    return _aIndex    end

-- Human-readable condition label
function Propagation.conditionLabel(c)
    if c == "open"   then return "OPEN"   end
    if c == "good"   then return "Good"   end
    if c == "poor"   then return "Poor"   end
    return "Closed"
end

return Propagation
