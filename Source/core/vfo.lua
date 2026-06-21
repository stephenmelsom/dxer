-- VFO (Variable Frequency Oscillator) state and tuning logic.
-- Owns: current band, current frequency, fine-tune mode flag.

VFO = {}

local _bandId  = "2m"   -- active band id (starts on 2m HT)
local _freq    = 0       -- current frequency in Hz
local _fine    = false   -- true while holding B (fine-tune mode)

-- Per-band VFO memory (restored when switching back)
local _memory = {}

local function clampToBand(hz)
    local b = Band.get(_bandId)
    return math.max(b.hzLow, math.min(b.hzHigh, hz))
end

function VFO.init(bandId)
    _bandId = bandId or "2m"
    local b = Band.get(_bandId)
    _freq = b.hzDefault
end

function VFO.setBand(bandId)
    -- Save current freq to memory
    _memory[_bandId] = _freq
    _bandId = bandId
    local b = Band.get(bandId)
    _freq = _memory[bandId] or b.hzDefault
end

function VFO.getBand()    return Band.get(_bandId) end
function VFO.getBandId()  return _bandId end
function VFO.getFreq()    return _freq end
function VFO.isFine()     return _fine end

function VFO.setFine(v)   _fine = v end

-- Apply crank delta (degrees) to VFO
function VFO.applyCrank(degrees)
    local b = Band.get(_bandId)
    local hzPerDeg = config.hzPerDegree
    if _fine then
        hzPerDeg = hzPerDeg / config.fineTuneDivisor
    end
    -- Apply sensitivity scalar
    local delta = degrees * hzPerDeg * config.crankSensitivity
    _freq = clampToBand(math.floor(_freq + delta + 0.5))
end

-- D-pad step (when crank is docked)
function VFO.stepUp()
    local b = Band.get(_bandId)
    local step = _fine and 100 or 1000
    _freq = clampToBand(_freq + step)
end

function VFO.stepDown()
    local b = Band.get(_bandId)
    local step = _fine and 100 or 1000
    _freq = clampToBand(_freq - step)
end

-- Format frequency for display: "7.125.00" style or "146.520"
function VFO.formatFreq()
    local hz = _freq
    if hz >= 1000000 then
        local mhz  = math.floor(hz / 1000000)
        local khz  = math.floor((hz % 1000000) / 1000)
        local hz100 = math.floor((hz % 1000) / 100)
        return string.format("%d.%03d.%d", mhz, khz, hz100)
    else
        local khz = math.floor(hz / 1000)
        local hz10 = math.floor((hz % 1000) / 10)
        return string.format("%d.%02d", khz, hz10)
    end
end

return VFO
