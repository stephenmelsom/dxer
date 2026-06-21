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

local BAND_ORDER = { "160m","80m","40m","20m","15m","10m","6m","2m" }

local function buildReport()
    _conditions = _propagation.getAllConditions()
    _flux       = _propagation.getSolarFlux()
    _aIdx       = _propagation.getAIndex()
end

local function conditionSymbol(c)
    if c == "open"   then return "[OPEN]  " end
    if c == "good"   then return "[Good]  " end
    if c == "poor"   then return "[Poor]  " end
    return "[Closed]"
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

    -- Header
    gfx.drawText(string.format("*Day %d — Solar Report*", _dayNum), 110, 4)
    gfx.drawLine(0, 20, 400, 20)

    -- Solar indices
    gfx.drawText(string.format("Solar Flux: %d      A-Index: %d", _flux, _aIdx), 20, 26)

    local geoLabel = _aIdx <= 10 and "Quiet" or (_aIdx <= 20 and "Unsettled" or "Disturbed")
    gfx.drawText("Geomagnetic: " .. geoLabel, 20, 40)

    gfx.drawLine(0, 56, 400, 56)

    -- Band conditions table (two columns)
    gfx.drawText("Band    Dawn         Noon         Dusk         Night", 10, 60)
    gfx.drawLine(0, 74, 400, 74)

    -- Show current conditions for a snapshot of 4 time-of-day slots
    local snapHours = { 7, 13, 19, 23 }
    local snapLabels = { "Dawn", "Noon", "Dusk", "Night" }
    for row, bandId in ipairs(BAND_ORDER) do
        local b = Band.get(bandId)
        if b then
            local y = 76 + (row - 1) * 16
            gfx.drawText(string.format("%-5s", bandId), 10, y)
            for col, hour in ipairs(snapHours) do
                -- Evaluate the genuine condition for this band at this time of day.
                local c = _propagation.conditionAt(bandId, hour) or "closed"
                local sym = conditionSymbol(c)
                gfx.drawText(sym, 55 + (col - 1) * 85, y)
            end
        end
    end

    gfx.drawLine(0, 196, 400, 196)
    gfx.drawText("Get on the air! Conditions change throughout the day.", 10, 200)

    if _contestToday then
        -- Contest banner occupies the lower band; start hint sits at the bottom.
        gfx.drawText("*  CONTEST TODAY: " .. Contest.getName() .. "  *", 60, 213)
        gfx.drawText(Contest.getDesc(), 60, 224)
        gfx.drawText("\u{24B6} Start operating", 280, 224)
    else
        gfx.drawLine(0, 222, 400, 222)
        gfx.drawText("\u{24B6} Start operating", 140, 226)
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
