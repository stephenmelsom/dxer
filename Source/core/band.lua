-- Band definitions. Each band has a frequency range (Hz), display name,
-- and default propagation slots for M3 expansion.

local bands = {
    -- VHF/UHF (start gear)
    {
        id = "2m", name = "2m", hzLow = 144000000, hzHigh = 148000000,
        hzDefault = 146520000,  -- NA simplex calling
        hzPerPx = 2500,         -- 400px covers ±500 kHz
        type = "vhf",
    },
    -- HF bands (unlocked with HF radio)
    {
        id = "10m", name = "10m", hzLow = 28000000, hzHigh = 29700000,
        hzDefault = 28500000, hzPerPx = 500, type = "hf",
    },
    {
        id = "15m", name = "15m", hzLow = 21000000, hzHigh = 21450000,
        hzDefault = 21300000, hzPerPx = 200, type = "hf",
    },
    {
        id = "20m", name = "20m", hzLow = 14000000, hzHigh = 14350000,
        hzDefault = 14200000, hzPerPx = 200, type = "hf",
    },
    {
        id = "40m", name = "40m", hzLow = 7000000, hzHigh = 7300000,
        hzDefault = 7150000, hzPerPx = 200, type = "hf",
    },
    {
        id = "80m", name = "80m", hzLow = 3500000, hzHigh = 4000000,
        hzDefault = 3750000, hzPerPx = 500, type = "hf",
    },
    {
        id = "160m", name = "160m", hzLow = 1800000, hzHigh = 2000000,
        hzDefault = 1900000, hzPerPx = 300, type = "hf",
    },
}

-- Index by id for fast lookup
local byId = {}
for _, b in ipairs(bands) do byId[b.id] = b end

Band = {}

function Band.all() return bands end
function Band.get(id) return byId[id] end

-- Return index of band in sorted list
function Band.indexOf(id)
    for i, b in ipairs(bands) do
        if b.id == id then return i end
    end
    return 1
end

return Band
