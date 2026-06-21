-- Victory scene: shown when all tournament rounds are completed.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

VictoryScene = {}

local _sceneManager = nil
local _save         = nil

function VictoryScene:enter()
    local data  = _save.get()
    local score = Tournament.getScore()
    data.tournament = data.tournament or { highScore = 0, bestRound = 0 }
    if score > (data.tournament.highScore or 0) then
        data.tournament.highScore = score
    end
    data.tournament.bestRound = config.tournamentRounds
    _save.write()
end

function VictoryScene:leave() end

function VictoryScene:update()
    gfx.clear(gfx.kColorWhite)

    -- Victory banner (inverted)
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.fillRect(0, 0, 400, 30)
    local lw = gfx.getTextSize("TOURNAMENT CHAMPION!")
    gfx.drawText("TOURNAMENT CHAMPION!", (400 - lw) // 2, 8)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)

    gfx.drawLine(0, 32, 400, 32)

    local data  = _save.get()
    local score = Tournament.getScore()
    local total = config.tournamentRounds

    gfx.drawText(string.format("You survived all %d rounds!", total),   70, 40)
    gfx.drawText(string.format("Final score:  %d points", score),        70, 60)
    gfx.drawText(string.format("High score:   %d pts", data.tournament.highScore or 0), 70, 78)

    gfx.drawLine(0, 100, 400, 100)
    gfx.drawText("73 de the DXer crew.", 130, 110)
    gfx.drawText("You are a true DX hunter!", 110, 128)
    gfx.drawText("Your flagship station is the envy", 90, 150)
    gfx.drawText("of every ham on the planet.", 110, 168)

    gfx.drawLine(0, 200, 400, 200)
    gfx.drawText("\u{24B6}=Play Again   \u{24B7}=Main Menu", 90, 208)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        Tournament.start()
        _sceneManager.switch(TournamentHubScene)
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function VictoryScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return VictoryScene
