-- Zero-beat audio engine.
-- Plays a tone whose pitch = offset from nearest on-screen signal.
-- Also manages a band-noise "hiss" floor.

ZeroBeat = {}

local _synth     = nil   -- beat-note synth
local _noise     = nil   -- noise-floor synth
local _beatHz    = 0
local _enabled   = true
local MAX_BEAT   = 1500  -- Hz; clamped display/audio ceiling

function ZeroBeat.init(soundEnabled)
    _enabled = soundEnabled

    -- Beat note: sine wave, legato so pitch updates don't retrigger envelope
    _synth = playdate.sound.synth.new(playdate.sound.kWaveSine)
    _synth:setLegato(true)
    _synth:setAttack(0.01)
    _synth:setRelease(0.05)
    if _enabled then
        _synth:playNote(440, 0, -1)  -- play indefinitely at 0 vol until needed
    end

    -- Band noise floor: white noise at very low volume
    _noise = playdate.sound.synth.new(playdate.sound.kWaveNoise)
    _noise:setVolume(_enabled and 0.06 or 0)
    _noise:playNote(1000, _enabled and 0.06 or 0, -1)
end

-- Call each frame with the Hz offset to the nearest audible signal.
-- Pass nil when no signal is within range.
function ZeroBeat.update(offsetHz, signalStrength)
    if not _enabled then return end

    if offsetHz == nil then
        _synth:setVolume(0)
        return
    end

    local absOff = math.abs(offsetHz)
    _beatHz = math.min(absOff, MAX_BEAT)

    -- Volume ramps up as we approach the signal from far away,
    -- then drops to near-zero at perfect zero-beat (< perfectHzThreshold).
    local vol
    if absOff <= config.perfectHzThreshold then
        vol = 0.05  -- nearly silent at exact zero-beat
    elseif absOff <= config.zeroHzThreshold then
        -- Ramp 0.05 → 0.6 as offset goes from perfect → zero threshold
        local t = (absOff - config.perfectHzThreshold) /
                  (config.zeroHzThreshold - config.perfectHzThreshold)
        vol = 0.05 + t * 0.55
    else
        -- Audible beat note fading in from 0 as signal enters ±2×threshold
        local fadeRange = config.zeroHzThreshold * 3
        if absOff < fadeRange then
            local t = 1 - (absOff - config.zeroHzThreshold) / (fadeRange - config.zeroHzThreshold)
            vol = t * 0.4
        else
            vol = 0
        end
    end

    vol = vol * (signalStrength or 0.8)
    if _beatHz < 20 then _beatHz = 20 end
    _synth:playNote(_beatHz, vol, -1)
end

-- Returns the current beat offset in Hz (for the visual meter)
function ZeroBeat.getBeatHz() return _beatHz end

function ZeroBeat.setEnabled(v)
    _enabled = v
    if not v then
        if _synth  then _synth:setVolume(0)  end
        if _noise  then _noise:setVolume(0)   end
    else
        if _noise  then _noise:setVolume(0.06) end
    end
end

-- Short "QSO confirmed" chime
function ZeroBeat.playQsoChime()
    if not _enabled then return end
    local chime = playdate.sound.synth.new(playdate.sound.kWaveSine)
    chime:setAttack(0.01)
    chime:setDecay(0.1)
    chime:setSustain(0.3)
    chime:setRelease(0.3)
    chime:playNote("C5", 0.5, 0.05)
    playdate.timer.performAfterDelay(80, function()
        chime:playNote("E5", 0.5, 0.05)
    end)
    playdate.timer.performAfterDelay(160, function()
        chime:playNote("G5", 0.5, 0.3)
    end)
end

return ZeroBeat
