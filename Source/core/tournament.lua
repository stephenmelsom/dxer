-- Tournament state: tracks active run, round number, score, thresholds.

Tournament = {}

local _active     = false
local _round      = 1
local _score      = 0       -- points scored this round
local _eliminated = false
local _won        = false

-- Score threshold for round R (1-indexed)
local function threshold(round)
    return math.floor(config.tournamentThresholdBase
                    * config.tournamentThresholdScale ^ (round - 1))
end

function Tournament.start()
    _active     = true
    _round      = 1
    _score      = 0
    _eliminated = false
    _won        = false
end

function Tournament.addPoints(pts)
    _score = _score + pts
end

-- Returns true if the player passed this round, false if eliminated
function Tournament.endRound()
    local needed = threshold(_round)
    if _score < needed then
        _eliminated = true
        _active     = false
        return false
    end
    -- Advance
    if _round >= config.tournamentRounds then
        _won    = true
        _active = false
        return true
    end
    _round = _round + 1
    _score = 0     -- reset score for next round
    return true
end

function Tournament.isActive()     return _active      end
function Tournament.isEliminated() return _eliminated  end
function Tournament.hasWon()       return _won         end
function Tournament.getRound()     return _round       end
function Tournament.getScore()     return _score       end
function Tournament.getThreshold() return threshold(_round) end
function Tournament.getTotalRounds() return config.tournamentRounds end

-- Multiplier for rare-contact spawn probability during tournament
function Tournament.rareBoostMult()
    return 2.5 + (_round - 1) * 0.3  -- rounds get progressively harder/richer
end

return Tournament
