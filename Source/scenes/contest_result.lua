-- Contest Result scene: shown at end of a contest session.
-- Displays QSOs, score, and cash bonus earned.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

ContestResultScene = {}

local _sceneManager = nil
local _save         = nil

function ContestResultScene:enter()
    local data  = _save.get()
    local bonus = Contest.cashBonus()
    data.story.cash = (data.story.cash or 0) + bonus
    _save.write()
    Contest.stop()
end

function ContestResultScene:leave() end

function ContestResultScene:update()
    gfx.clear(gfx.kColorWhite)

    gfx.drawText("*Contest Over!*", 150, 4)
    gfx.drawLine(0, 20, 400, 20)

    local data  = _save.get()
    local bonus = Contest.cashBonus()

    gfx.drawText("Contest: " .. Contest.getName(), 40, 28)
    gfx.drawText(string.format("QSOs logged:   %d", Contest.getQsoCount()), 40, 48)
    gfx.drawText(string.format("Contest score: %d",  Contest.getScore()),    40, 68)
    gfx.drawText(string.format("Cash bonus:   +$%d", bonus),                 40, 88)

    -- Run rate
    local dur   = Contest.getDuration()
    local rate  = Contest.getQsoCount() / (dur / 60)
    gfx.drawText(string.format("Rate:  %.1f QSOs/min", rate), 40, 108)

    gfx.drawLine(0, 130, 400, 130)
    gfx.drawText(string.format("Bank: $%d", data.story.cash), 40, 136)

    gfx.drawLine(0, 160, 400, 160)
    gfx.drawText("Great work! Back to regular operating.", 60, 168)

    gfx.drawLine(0, 210, 400, 210)
    gfx.drawText("\u{24B6} Continue", 160, 214)

    if playdate.buttonJustPressed(playdate.kButtonA)
    or playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(OperateScene)
    end
end

function ContestResultScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return ContestResultScene
