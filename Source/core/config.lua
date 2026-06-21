-- Global tunables for DXer. Change here; never hardcode elsewhere.

config = {
    -- Display
    targetFPS = 30,

    -- Audio
    soundEnabled = true,
    musicEnabled = true,
    masterVolume = 0.8,

    -- Crank
    crankSensitivity = 1.0,     -- multiplier applied to crank delta
    fineTuneDivisor  = 5,        -- crank sensitivity divisor when holding B

    -- Tuning (Hz per degree of crank)
    hzPerDegree = 500,           -- coarse: ~180kHz sweep per full revolution

    -- Zero-beat detection
    zeroHzThreshold = 150,       -- Hz; within this range = "on frequency"
    perfectHzThreshold = 30,     -- Hz; within this range = perfect zero-beat

    -- Contact system
    maxContactsPerBand = 8,
    contactLifetimeMin = 15,     -- seconds
    contactLifetimeMax = 90,

    -- Scoring
    currencyPerPoint = 0.1,      -- story mode: every 10 pts → $1

    -- Story mode
    roundDurationMinutes = 20,   -- in-game minutes per operating session

    -- Tournament mode
    tournamentRounds = 7,
    tournamentThresholdBase = 500,
    tournamentThresholdScale = 1.4,
}

return config
