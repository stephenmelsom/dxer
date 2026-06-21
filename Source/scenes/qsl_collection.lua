-- QSL Collection scene: browse earned QSL cards.
-- B = back.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

QSLScene = {}

local _sceneManager = nil
local _save         = nil
local _scroll       = 0
local ROWS_VIS      = 8
local ROW_H         = 22

function QSLScene:enter()
    local data   = _save.get()
    local cards  = QSL.getCards(data)
    _scroll = math.max(0, #cards - ROWS_VIS)
end

function QSLScene:leave() end

function QSLScene:update()
    gfx.clear(gfx.kColorWhite)

    local data   = _save.get()
    local cards  = QSL.getCards(data)
    local total  = #cards

    gfx.drawText("*QSL Cards*", 160, 2)
    gfx.drawLine(0, 18, 400, 18)

    -- Column headers
    gfx.drawText("Call",   4,   20)
    gfx.drawText("Entity", 75,  20)
    gfx.drawText("Band",   245, 20)
    gfx.drawText("Mode",   285, 20)
    gfx.drawLine(0, 36, 400, 36)

    if total == 0 then
        gfx.drawText("No QSL cards yet. Work rare DX to earn cards!", 40, 120)
    else
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            _scroll = math.max(0, _scroll - 1)
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            _scroll = math.min(math.max(0, total - ROWS_VIS), _scroll + 1)
        end

        for i = 1, ROWS_VIS do
            local idx = i + _scroll
            if idx > total then break end
            local c = cards[idx]
            local y = 38 + (i - 1) * ROW_H

            -- Highlight rare cards
            if c.rarity == "dxpedition" or c.rarity == "rare" then
                gfx.setDitherPattern(0.1, gfx.image.kDitherTypeBayer8x8)
                gfx.fillRect(0, y, 400, ROW_H - 1)
                gfx.setColor(gfx.kColorBlack)
            end

            gfx.drawText(c.call   or "?", 4,   y + 3)
            gfx.drawText(c.entity or "?", 75,  y + 3)
            gfx.drawText(c.band   or "?", 245, y + 3)
            gfx.drawText(c.mode   or "?", 285, y + 3)
        end

        -- Scrollbar
        if total > ROWS_VIS then
            local sbH = 160
            local sbY = 38
            local tbH = math.floor(sbH * ROWS_VIS / total)
            local tbY = sbY + math.floor(sbH * _scroll / total)
            gfx.drawRect(395, sbY, 4, sbH)
            gfx.fillRect(396, tbY, 2, tbH)
        end
    end

    gfx.drawLine(0, 222, 400, 222)
    gfx.drawText(string.format("Cards collected: %d", total), 4, 224)
    gfx.drawText("\u{24B7} Back", 340, 224)

    if playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function QSLScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return QSLScene
