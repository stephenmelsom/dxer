-- Panadapter (spectrum display) widget.
-- Draws a 1-bit scrolling band view: signal blips at their frequencies,
-- a fixed VFO cursor at the center column, and a frequency scale.
--
-- Layout within the 400×240 screen:
--   y 0..119   — panadapter (120px tall)
--   y 120..239 — controls / meters (handled by operate scene)

local gfx <const> = playdate.graphics

Panadapter = {}

-- Constants
local PAN_W  = 400
local PAN_H  = 100          -- panadapter height in pixels (leaves room for HUD rows below)
local PAN_Y  = 20           -- top of panadapter area (below freq readout)
local CENTER = 200           -- VFO cursor column (fixed)
local BLIP_H = 16            -- max signal blip height in pixels

-- Draw the panadapter given:
--   vfoFreq  (Hz)
--   hzPerPx  (Hz each pixel represents)
--   contacts (array of {freq, strength, rarity, callsign})
--   qrmBlobs (optional array of {freq, widthHz, strength} QRM blobs)
function Panadapter.draw(vfoFreq, hzPerPx, contacts, qrmBlobs)
    -- Background
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, PAN_Y, PAN_W, PAN_H)

    -- Subtle grid lines every ~50 kHz
    local gridHz = 50000
    -- Round grid start to nearest gridHz below left edge
    local leftHz  = vfoFreq - CENTER * hzPerPx
    local gridStart = math.floor(leftHz / gridHz) * gridHz
    gfx.setColor(gfx.kColorBlack)
    local x = gridStart
    while x <= leftHz + PAN_W * hzPerPx do
        local px = math.floor((x - vfoFreq) / hzPerPx) + CENTER
        if px >= 0 and px < PAN_W then
            -- Dotted vertical line
            for py = PAN_Y, PAN_Y + PAN_H - 1, 4 do
                gfx.drawPixel(px, py)
            end
        end
        x = x + gridHz
    end

    -- Noise floor baseline
    local baseY = PAN_Y + PAN_H - 4
    gfx.drawLine(0, baseY, PAN_W, baseY)

    -- QRM blobs (drawn before signal blips, lighter)
    if qrmBlobs then
        for _, blob in ipairs(qrmBlobs) do
            local blobCenterPx = math.floor((blob.freq - vfoFreq) / hzPerPx) + CENTER
            local blobHalfW    = math.floor(blob.widthHz / hzPerPx / 2)
            local blobH        = math.floor(BLIP_H * blob.strength * 0.6)
            -- Draw as a wide fuzzy block with dither pattern
            local bx = math.max(0, blobCenterPx - blobHalfW)
            local bw = math.min(PAN_W - bx, blobHalfW * 2)
            if bw > 0 then
                gfx.setDitherPattern(0.3, gfx.image.kDitherTypeBayer8x8)
                gfx.fillRect(bx, baseY - blobH, bw, blobH)
                gfx.setColor(gfx.kColorBlack)
            end
        end
    end

    -- Find the contact nearest the VFO center column. Only that one gets a
    -- callsign label, so stacked nearby contacts don't overprint each other.
    local labelIdx     = nil
    local labelBestDx  = math.huge
    for i, contact in ipairs(contacts) do
        local px = math.floor((contact.freq - vfoFreq) / hzPerPx) + CENTER
        local dx = math.abs(px - CENTER)
        if dx < labelBestDx and dx < 80 then
            labelBestDx = dx
            labelIdx    = i
        end
    end

    -- Signal blips
    for i, contact in ipairs(contacts) do
        local px = math.floor((contact.freq - vfoFreq) / hzPerPx) + CENTER
        if px >= 2 and px < PAN_W - 2 then
            local h = math.floor(BLIP_H * (contact.strength or 0.5))
            h = math.max(4, h)
            local blipY = baseY - h
            -- Draw filled blip spike
            gfx.fillRect(px - 1, blipY, 3, h)
            -- Callsign label only for the contact nearest the VFO center.
            if i == labelIdx then
                local label = contact.callsign or "?"
                local lw = gfx.getTextSize(label)
                local labelX = math.max(1, math.min(PAN_W - lw - 1, px - lw // 2))
                gfx.drawText(label, labelX, blipY - 12)
            end
        end
    end

    -- VFO cursor — triangle pointing down + vertical line
    gfx.drawLine(CENTER, PAN_Y, CENTER, baseY - 1)
    -- Small triangle at top to mark VFO
    gfx.fillTriangle(CENTER - 4, PAN_Y, CENTER + 4, PAN_Y, CENTER, PAN_Y + 7)

    -- Frequency scale ticks at bottom
    local tickHz = 10000  -- every 10 kHz
    local tickStart = math.floor(leftHz / tickHz) * tickHz
    local tx = tickStart
    -- Track the right edge of the last drawn label so labels never overprint.
    local lastLabelRight = -math.huge
    local LABEL_GAP = 6   -- minimum px gap between adjacent labels
    while tx <= leftHz + PAN_W * hzPerPx do
        local px2 = math.floor((tx - vfoFreq) / hzPerPx) + CENTER
        if px2 >= 0 and px2 < PAN_W then
            gfx.drawLine(px2, baseY, px2, baseY + 4)
            -- Label every 50 kHz, but only if it clears the previous one.
            if tx % 50000 == 0 then
                local khz = math.floor(tx / 1000)
                local lbl = tostring(khz)
                local lw2 = gfx.getTextSize(lbl)
                local labelX = px2 - lw2 // 2
                if labelX >= lastLabelRight + LABEL_GAP then
                    gfx.drawText(lbl, labelX, baseY + 5)
                    lastLabelRight = labelX + lw2
                end
            end
        end
        tx = tx + tickHz
    end

    -- Top border
    gfx.drawLine(0, PAN_Y - 1, PAN_W, PAN_Y - 1)
    -- Bottom border
    gfx.drawLine(0, PAN_Y + PAN_H, PAN_W, PAN_Y + PAN_H)
end

return Panadapter
