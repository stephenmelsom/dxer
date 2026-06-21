-- Visual zero-beat / tuning meter.
-- A horizontal bar with a center zone; the indicator slides left/right
-- based on frequency offset from nearest signal.
-- Green zone = within zeroHzThreshold; bright center = perfect zero-beat.

local gfx    <const> = playdate.graphics

ZeroBeatMeter = {}

-- Meter geometry (drawn in absolute screen coordinates)
local MX     = 80     -- left edge
local MW     = 240    -- width
local MY     = 177    -- y center of bar (own row below the S-meter)
local MH     = 14     -- bar height
local HALF   = MW // 2

function ZeroBeatMeter.draw(offsetHz, hasSignal)
    local cx = MX + HALF  -- center pixel

    -- Outer border
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(MX, MY - MH // 2, MW, MH)

    -- Center "perfect" zone (white fill = always visible)
    local perfectW = math.floor(HALF * config.perfectHzThreshold / config.zeroHzThreshold)
    perfectW = math.max(2, perfectW)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(cx - perfectW, MY - MH // 2 + 1, perfectW * 2, MH - 2)

    -- Zero-beat zone outline (slightly wider)
    local zeroW = math.floor(HALF * 0.4)  -- about 40% of half-width
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(cx - zeroW, MY - MH // 2, zeroW * 2, MH)

    if not hasSignal then
        -- "TUNE" label when no signal in range
        local lbl = "-- TUNE --"
        local lw = gfx.getTextSize(lbl)
        gfx.drawText(lbl, cx - lw // 2, MY - 5)
        return
    end

    -- Needle position: clamp offsetHz to ±maxOffset, map to pixels
    local maxOffset = config.zeroHzThreshold * 4
    local clampedOff = math.max(-maxOffset, math.min(maxOffset, offsetHz))
    local needleX = cx + math.floor(clampedOff / maxOffset * HALF)

    -- Draw filled needle triangle
    gfx.setColor(gfx.kColorBlack)
    local nHalf = 4
    gfx.fillTriangle(
        needleX, MY - MH // 2 + 1,
        needleX - nHalf, MY + MH // 2 - 1,
        needleX + nHalf, MY + MH // 2 - 1
    )

    -- Labels
    gfx.drawText("QRM", MX - 35, MY - 5)
    gfx.drawText("QRM", MX + MW + 3, MY - 5)
end

return ZeroBeatMeter
