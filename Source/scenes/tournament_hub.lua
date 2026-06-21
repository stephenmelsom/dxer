-- Tournament Hub: shown between rounds. Displays score, threshold, round info.
-- A = start next round; B = quit to title.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

TournamentHubScene = {}

local _sceneManager = nil
local _save         = nil

local function progressBar(x, y, w, h, value, maxValue)
    local fill = math.floor(w * math.min(1, value / maxValue))
    gfx.drawRect(x, y, w, h)
    local innerW = fill - 2
    if innerW >= 1 and h - 2 >= 1 then
        gfx.fillRect(x + 1, y + 1, innerW, h - 2)
    end
end

function TournamentHubScene:enter() end
function TournamentHubScene:leave() end

function TournamentHubScene:update()
    gfx.clear(gfx.kColorWhite)

    local round     = Tournament.getRound()
    local total     = Tournament.getTotalRounds()
    local threshold = Tournament.getThreshold()
    local score     = Tournament.getScore()
    local data      = _save.get()
    local cash      = data.story.cash or 0

    gfx.drawText(string.format("*Tournament — Round %d / %d*", round, total), 80, 4)
    gfx.drawLine(0, 20, 400, 20)

    gfx.drawText(string.format("Score this round:  %d", score),     20, 28)
    gfx.drawText(string.format("Target score:      %d", threshold),  20, 44)

    -- Progress bar toward threshold
    progressBar(20, 62, 360, 18, score, threshold)
    gfx.drawText(string.format("%d / %d", score, threshold), 160, 65)

    gfx.drawLine(0, 88, 400, 88)
    gfx.drawText(string.format("Cash: $%d", cash), 20, 94)

    -- Round history (placeholder — just show round badges)
    gfx.drawText("Rounds:", 20, 114)
    for r = 1, total do
        local rx = 90 + (r - 1) * 36
        if r < round then
            -- passed
            gfx.fillRect(rx, 112, 30, 18)
            gfx.setImageDrawMode(gfx.kDrawModeInverted)
            gfx.drawText(tostring(r), rx + 10, 114)
            gfx.setImageDrawMode(gfx.kDrawModeCopy)
        elseif r == round then
            gfx.drawRect(rx, 112, 30, 18)
            gfx.drawText(tostring(r), rx + 10, 114)
        else
            gfx.drawRect(rx, 112, 30, 18)
            gfx.setColor(gfx.kColorWhite)
            -- future: outline only
            gfx.setColor(gfx.kColorBlack)
        end
    end

    gfx.drawLine(0, 140, 400, 140)
    gfx.drawText("Tip: Rare DX contacts score more — stay tuned!", 20, 145)
    gfx.drawText(string.format("Contact odds boosted x%.1f this round.", Tournament.rareBoostMult()), 20, 163)

    gfx.drawLine(0, 190, 400, 190)
    -- High score
    local hs = data.tournament and data.tournament.highScore or 0
    gfx.drawText(string.format("Best run:  Round %d  High score: %d",
        data.tournament and data.tournament.bestRound or 0, hs), 20, 194)

    gfx.drawLine(0, 212, 400, 212)
    gfx.drawText("\u{24B6}=Start Round  Shop from pause menu  \u{24B7}=Quit", 20, 216)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        _sceneManager.switch(SolarReportScene)
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function TournamentHubScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return TournamentHubScene
