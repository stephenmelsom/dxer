-- Logbook scene: displays contacts worked this session.
-- Navigation: D-pad up/down to scroll; B to return.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

LogbookScene = {}

local _sceneManager = nil
local _save         = nil

local _scroll     = 0
local ROWS_VIS    = 8
local ROW_H       = 22

local COL_CALL    = 4
local COL_ENTITY  = 75
local COL_BAND    = 245
local COL_PTS     = 285
local COL_TIME    = 325

local function getEntries()
    local data = _save.get()
    return data and data.story.logbook or {}
end

local function drawHeader()
    gfx.drawText("*Logbook*", 160, 2)
    gfx.drawLine(0, 18, 400, 18)
    gfx.drawText("Call",   COL_CALL,   20)
    gfx.drawText("Entity", COL_ENTITY, 20)
    gfx.drawText("Band",   COL_BAND,   20)
    gfx.drawText("Pts",    COL_PTS,    20)
    gfx.drawText("Time",   COL_TIME,   20)
    gfx.drawLine(0, 38, 400, 38)
end

function LogbookScene:enter()
    local entries = getEntries()
    -- Start scrolled to bottom so newest contacts are visible
    _scroll = math.max(0, #entries - ROWS_VIS)
end

function LogbookScene:leave() end

function LogbookScene:update()
    gfx.clear(gfx.kColorWhite)
    drawHeader()

    local entries = getEntries()
    local total   = #entries

    if total == 0 then
        gfx.drawText("No contacts yet. Get on the air!", 80, 120)
    else
        -- D-pad scrolling
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            _scroll = math.max(0, _scroll - 1)
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            _scroll = math.min(math.max(0, total - ROWS_VIS), _scroll + 1)
        end

        for i = 1, ROWS_VIS do
            local idx = i + _scroll
            if idx > total then break end
            local e   = entries[idx]
            local y   = 40 + (i - 1) * ROW_H
            -- Alternate row shading
            if i % 2 == 0 then
                gfx.setColor(gfx.kColorBlack)
                -- Draw subtle row background (XOR for 1-bit feel)
                gfx.setDitherPattern(0.12, gfx.image.kDitherTypeBayer8x8)
                gfx.fillRect(0, y, 400, ROW_H - 1)
                gfx.setColor(gfx.kColorBlack)
            end
            gfx.drawText(e.call or "?",   COL_CALL,   y + 3)
            gfx.drawText(e.entity or "?", COL_ENTITY, y + 3)
            gfx.drawText(e.band  or "?",  COL_BAND,   y + 3)
            gfx.drawText(tostring(e.points or 0), COL_PTS, y + 3)
            gfx.drawText(tostring(e.time or "?"), COL_TIME, y + 3)
        end

        -- Scrollbar
        if total > ROWS_VIS then
            local sbH   = 180
            local sbY   = 40
            local tbH   = math.floor(sbH * ROWS_VIS / total)
            local tbY   = sbY + math.floor(sbH * _scroll / total)
            gfx.drawRect(395, sbY, 4, sbH)
            gfx.fillRect(396, tbY, 2, tbH)
        end
    end

    -- Running total
    local data  = _save.get()
    local total_pts = data and data.story.totalPoints or 0
    gfx.drawLine(0, 222, 400, 222)
    gfx.drawText(string.format("Total: %d contacts  %d pts", total, total_pts), 4, 224)

    -- Back hint
    gfx.drawText("\u{24B7} Back", 340, 224)

    if playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function LogbookScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return LogbookScene
