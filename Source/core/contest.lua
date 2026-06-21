-- Contest state: tracks active contest session.
-- Contests are timed bursts of rapid QSO scoring.

Contest = {}

local DURATION_SECS   = 180   -- 3 real minutes per contest session
local BONUS_RATE      = 0.5   -- extra cash per contest point

local _active      = false
local _elapsed     = 0
local _score       = 0
local _qsoCount    = 0
local _serial      = 1        -- exchange serial number
local _name        = ""
local _exchange    = "RST+Serial"

-- Contest types (picked randomly)
local TYPES = {
    { name = "QSO Party",         pts = 1,  desc = "Work as many stations as possible!" },
    { name = "DX Contest",        pts = 3,  desc = "Focus on rare DX for big points!" },
    { name = "CW Sprint",         pts = 2,  desc = "CW contacts score double!" },
    { name = "Grid Chase",        pts = 2,  desc = "Collect unique grid squares!" },
}

local _contestType = nil

function Contest.start()
    _active      = true
    _elapsed     = 0
    _score       = 0
    _qsoCount    = 0
    _serial      = 1
    _contestType = TYPES[math.random(#TYPES)]
    _name        = _contestType.name
end

function Contest.stop()
    _active = false
end

function Contest.update(dt)
    if not _active then return end
    _elapsed = _elapsed + dt
    if _elapsed >= DURATION_SECS then
        _active = false
    end
end

function Contest.logQso(pts)
    if not _active then return 0 end
    local scaled = pts * _contestType.pts
    _score    = _score + scaled
    _qsoCount = _qsoCount + 1
    _serial   = _serial + 1
    return scaled
end

function Contest.cashBonus()
    return math.floor(_score * BONUS_RATE)
end

function Contest.isActive()       return _active       end
function Contest.getScore()       return _score        end
function Contest.getQsoCount()    return _qsoCount     end
function Contest.getSerial()      return _serial       end
function Contest.getName()        return _name         end
function Contest.getDesc()        return _contestType and _contestType.desc or "" end
function Contest.getTimeLeft()    return math.max(0, DURATION_SECS - _elapsed)    end
function Contest.getDuration()    return DURATION_SECS end

-- Spawn multiplier during contest (more contacts available)
function Contest.spawnMult()
    return _active and 3.0 or 1.0
end

-- Points multiplier for contacts during contest
function Contest.pointsMult()
    return _active and (_contestType and _contestType.pts or 1) or 1
end

return Contest
