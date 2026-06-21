-- In-game clock for one operating session ("round").
-- Real-time advances the in-game clock at a configurable rate.
-- Clock wraps at 24 hours; callers can detect dawn/dusk transitions.

Clock = {}

-- 1 real second = minutesPerSecond in-game minutes
local MINUTES_PER_SECOND = 2   -- 1 real minute ≈ 2 in-game hours

local _hourF    = 8.0   -- in-game hour (float, 0..24)
local _prevHour = 8

function Clock.init(startHour)
    _hourF    = startHour or 8.0
    _prevHour = math.floor(_hourF)
end

function Clock.update(dt)
    local minutesDelta = dt * MINUTES_PER_SECOND
    _hourF = (_hourF + minutesDelta / 60) % 24
end

-- Returns integer hour 0-23
function Clock.hour()
    return math.floor(_hourF) % 24
end

-- Returns float hour 0-24
function Clock.hourF()
    return _hourF
end

-- True if hour just crossed an integer boundary this frame
function Clock.hourChanged()
    local h = math.floor(_hourF) % 24
    if h ~= _prevHour then
        _prevHour = h
        return true
    end
    return false
end

-- Daylight fraction 0-1 (simple cosine model)
-- Full day = 1, midnight = 0
function Clock.daylightFraction()
    local rad = (_hourF / 24) * math.pi * 2 - math.pi
    return math.max(0, math.cos(rad))
end

-- Is it currently daytime? (rough: 6am-8pm)
function Clock.isDay()
    local h = Clock.hour()
    return h >= 6 and h < 20
end

function Clock.formatTime()
    local h = math.floor(_hourF) % 24
    local m = math.floor((_hourF - math.floor(_hourF)) * 60)
    return string.format("%02d:%02dZ", h, m)
end

return Clock
