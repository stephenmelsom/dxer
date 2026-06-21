-- Solar Report scene: displayed at the start of each Story day.
-- Shows solar flux, geomagnetic index, and which bands are open.
-- A button or any key to proceed to the operate scene.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

SolarReportScene = {}

local _sceneManager = nil
local _save         = nil
local _propagation  = nil
local _clock        = nil

local _conditions    = {}
local _flux          = 0
local _aIdx          = 0
local _dayNum        = 1
local _contestToday  = false   -- true if a contest fires this day

local BAND_ORDER = { "160m","80m","40m","20m","15m","10m","2m" }

-- Time-of-day snapshot columns shown in the band table.
local SNAP_HOURS  = { 7, 13, 19, 23 }
local SNAP_LABELS = { "Dawn", "Noon", "Dusk", "Night" }
local COL_X       = { 70, 155, 240, 325 }   -- left edge of each condition cell

local SWATCH    = 9                          -- condition swatch size (px)
local DITHER    = playdate.graphics.image.kDitherTypeBayer8x8

local function buildReport()
    _conditions = _propagation.getAllConditions()
    _flux       = _propagation.getSolarFlux()
    _aIdx       = _propagation.getAIndex()
end

-- A simple bordered fill bar (fraction 0..1). Adapted from tournament_hub.progressBar.
local function fillBar(x, y, w, h, frac)
    frac = math.max(0, math.min(1, frac))
    gfx.drawRect(x, y, w, h)
    local innerW = math.floor((w - 2) * frac)
    if innerW >= 1 then
        gfx.fillRect(x + 1, y + 1, innerW, h - 2)
    end
end

-- Draw a condition swatch: solid (open) -> dithered (good/poor) -> empty (closed).
local function conditionSwatch(c, x, y)
    if c == "open" then
        gfx.fillRect(x, y, SWATCH, SWATCH)
    elseif c == "good" then
        gfx.setDitherPattern(0.45, DITHER)   -- ~55% black
        gfx.fillRect(x, y, SWATCH, SWATCH)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(x, y, SWATCH, SWATCH)
    elseif c == "poor" then
        gfx.setDitherPattern(0.75, DITHER)   -- ~25% black
        gfx.fillRect(x, y, SWATCH, SWATCH)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(x, y, SWATCH, SWATCH)
    else
        gfx.drawRect(x, y, SWATCH, SWATCH)   -- closed: empty outline
    end
end

-- Tiny 1-bit time-of-day glyphs drawn around (cx, cy).
local function drawSunHorizon(cx, cy)        -- dawn / dusk: sun resting on a line
    gfx.drawCircleAtPoint(cx, cy - 1, 3)
    gfx.drawLine(cx - 6, cy + 3, cx + 6, cy + 3)
end

local function drawNoonSun(cx, cy)           -- noon: filled sun with rays
    gfx.fillCircleAtPoint(cx, cy, 3)
    gfx.drawLine(cx, cy - 6, cx, cy - 4)
    gfx.drawLine(cx, cy + 4, cx, cy + 6)
    gfx.drawLine(cx - 6, cy, cx - 4, cy)
    gfx.drawLine(cx + 4, cy, cx + 6, cy)
end

local function drawMoon(cx, cy)              -- night: crescent
    gfx.fillCircleAtPoint(cx, cy, 4)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(cx + 2, cy - 1, 4)
    gfx.setColor(gfx.kColorBlack)
end

local function drawColGlyph(col, cx, cy)
    if     col == 1 then drawSunHorizon(cx, cy)
    elseif col == 2 then drawNoonSun(cx, cy)
    elseif col == 3 then drawSunHorizon(cx, cy)
    else                 drawMoon(cx, cy) end
end

function SolarReportScene:enter()
    local data = _save.get()
    _dayNum = data.story.day or 1
    _propagation.init(_dayNum)
    _clock.init(6)
    buildReport()
    -- 30% chance of a contest today (after day 2)
    _contestToday = _dayNum > 2 and (math.random() < 0.30)
    if _contestToday then Contest.start() end
end

function SolarReportScene:leave() end

function SolarReportScene:update()
    gfx.clear(gfx.kColorWhite)

    -- Masthead: day on the left, in-game (Zulu) time on the right.
    gfx.drawText(string.format("*DAY %d SOLAR REPORT*", _dayNum), 8, 4)
    local timeStr = _clock.formatTime()
    local tw = gfx.getTextSize(timeStr)
    gfx.drawText(timeStr, 392 - tw, 4)
    gfx.drawLine(0, 21, 400, 21)

    -- Solar indices: two inline gauges so "good/bad" reads at a glance.
    local fluxLabel = _flux > 150 and "HIGH" or (_flux > 100 and "MOD" or "LOW")
    gfx.drawText(string.format("SFI *%d*", _flux), 8, 26)
    fillBar(78, 28, 62, 10, (_flux - 60) / 190)
    gfx.drawText(fluxLabel, 148, 26)

    local geoLabel = _aIdx <= 10 and "Quiet" or (_aIdx <= 20 and "Unsettled" or "Disturbed")
    gfx.drawText(string.format("A-IDX *%d*", _aIdx), 210, 26)
    fillBar(286, 28, 52, 10, _aIdx / 30)
    gfx.drawText(geoLabel, 346, 25)

    gfx.drawLine(0, 44, 400, 44)

    -- Column header with time-of-day glyphs.
    gfx.drawText("*BAND*", 8, 47)
    for col, label in ipairs(SNAP_LABELS) do
        local x = COL_X[col]
	local glyphY = 55
	if label == "Dawn" or label == "Dusk" then
	    glyphY += 2
	end
        drawColGlyph(col, x + 5, glyphY)
        gfx.drawText(label, x + 16, 47)
    end
    gfx.drawLine(0, 66, 400, 66)

    -- Band conditions table: swatch + word per cell, alternating row stripes.
    local rowHeight = 20
    for row, bandId in ipairs(BAND_ORDER) do
        local b = Band.get(bandId)
        if b then
            local y = 67 + (row - 1) * rowHeight + 2
            if row % 2 == 0 then
                gfx.setDitherPattern(0.88, DITHER)   -- ~12% black stripe
                gfx.fillRect(0, y - 1, 400, rowHeight)
                gfx.setColor(gfx.kColorBlack)
            end
            gfx.drawText("*" .. bandId .. "*", 8, y)
            for col, hour in ipairs(SNAP_HOURS) do
                local c  = _propagation.conditionAt(bandId, hour) or "closed"
                local cx = COL_X[col]
                conditionSwatch(c, cx, y + 4)
                local word = (c == "closed") and "-"
                                              or _propagation.conditionLabel(c)
                gfx.drawText(word, cx + SWATCH + 4, y)
            end
        end
    end

    -- Footer: contest banner when active, otherwise an inverted start pill.
    if _contestToday then
        gfx.fillRect(0, 206, 400, 34)
        gfx.setImageDrawMode(gfx.kDrawModeInverted)
        gfx.drawText("*CONTEST TODAY: " .. Contest.getName() .. "*", 8, 210)
        gfx.drawText(Contest.getDesc(), 8, 224)
        gfx.drawText("*\u{24B6} Start*", 330, 224)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    else
        gfx.drawLine(0, 207, 400, 207)
        local hint = "\u{24B6} Start operating"
        local hw   = gfx.getTextSize(hint)
        local px   = (400 - hw) // 2
        gfx.fillRoundRect(px - 12, 211, hw + 24, 26, 4)
        gfx.setImageDrawMode(gfx.kDrawModeInverted)
        gfx.drawText(hint, px, 215)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end

    if playdate.buttonJustPressed(playdate.kButtonA)
    or playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(OperateScene)
    end
end

function SolarReportScene.init(sm, sv, prop, clk)
    _sceneManager = sm
    _save         = sv
    _propagation  = prop
    _clock        = clk
end

return SolarReportScene
