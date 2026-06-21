-- Game Over scene: shown when eliminated from tournament.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

GameOverScene = {}

local _sceneManager = nil
local _save         = nil

function GameOverScene:enter()
    -- Update high score record
    local data   = _save.get()
    local score  = Tournament.getScore()
    local round  = Tournament.getRound()
    data.tournament = data.tournament or { highScore = 0, bestRound = 0 }
    if score > (data.tournament.highScore or 0) then
        data.tournament.highScore = score
    end
    if round > (data.tournament.bestRound or 0) then
        data.tournament.bestRound = round
    end
    _save.write()
end

function GameOverScene:leave() end

function GameOverScene:update()
    gfx.clear(gfx.kColorWhite)

    local data  = _save.get()
    local score = Tournament.getScore()
    local round = Tournament.getRound()
    local needed = Tournament.getThreshold()

    -- Big ELIMINATED header (inverted)
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.fillRect(0, 0, 400, 30)
    local lw = gfx.getTextSize("ELIMINATED")
    gfx.drawText("ELIMINATED", (400 - lw) // 2, 8)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)

    gfx.drawLine(0, 32, 400, 32)
    gfx.drawText(string.format("You fell short in Round %d.", round), 60, 40)
    gfx.drawText(string.format("Score:  %d  (needed %d)", score, needed), 60, 60)

    gfx.drawLine(0, 84, 400, 84)
    local hs = data.tournament and data.tournament.highScore or 0
    local br = data.tournament and data.tournament.bestRound or 0
    gfx.drawText(string.format("Personal best:  Round %d  /  %d pts", br, hs), 60, 90)

    gfx.drawLine(0, 108, 400, 108)
    gfx.drawText("Better luck next time, operator.", 90, 118)
    gfx.drawText("Keep upgrading your station and", 90, 136)
    gfx.drawText("hunting those rare DX contacts!", 90, 152)

    gfx.drawLine(0, 200, 400, 200)
    gfx.drawText("\u{24B6}=Try Again   \u{24B7}=Main Menu", 100, 206)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        Tournament.start()
        _sceneManager.switch(TournamentHubScene)
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function GameOverScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return GameOverScene
