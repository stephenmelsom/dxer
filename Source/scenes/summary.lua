-- Session summary scene: shown at end of each operating day.
-- Shows contacts logged, points earned, cash converted, new awards.
-- A = go to shop; B = skip shop, go to next day.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

SummaryScene = {}

local _sceneManager  = nil
local _save          = nil
local _tournament    = nil

-- Data captured when the summary scene is entered
local _sessionContacts = 0
local _sessionPoints   = 0
local _cashEarned      = 0
local _newAwards       = {}
local _dxccCount       = 0

local function countDxcc(data)
    local n = 0
    for _ in pairs(data.story.dxccWorked or {}) do n = n + 1 end
    return n
end

function SummaryScene:enter()
    local data = _save.get()

    -- Per-session deltas relative to the last-session baseline
    local totalPoints  = data.story.totalPoints or 0
    local logbookCount = #data.story.logbook

    _sessionPoints   = math.max(0, totalPoints  - (data.story.lastTotalPoints or 0))
    _sessionContacts = math.max(0, logbookCount - (data.story.lastLogbookCount or 0))

    -- Convert session points → cash
    _cashEarned = math.floor(_sessionPoints * config.currencyPerPoint)
    data.story.cash = (data.story.cash or 0) + _cashEarned

    -- Update baseline for next session
    data.story.lastTotalPoints  = totalPoints
    data.story.lastLogbookCount = logbookCount

    -- Check awards
    _newAwards = Awards.check(data)
    _dxccCount = countDxcc(data)

    -- Advance the day
    data.story.day = (data.story.day or 1) + 1

    _save.write()
end

function SummaryScene:leave() end

function SummaryScene:update()
    gfx.clear(gfx.kColorWhite)

    gfx.drawText("*Session Complete!*", 130, 4)
    gfx.drawLine(0, 24, 400, 24)

    local data = _save.get()

    gfx.drawText(string.format("Contacts:  %d", _sessionContacts),   20, 28)
    gfx.drawText(string.format("Points:    %d", _sessionPoints),      20, 44)
    gfx.drawText(string.format("Cash:     +$%d", _cashEarned),        20, 60)
    gfx.drawText(string.format("DXCC:      %d entities", _dxccCount), 20, 76)
    gfx.drawText(string.format("Bank:      $%d", data.story.cash),    20, 92)
    gfx.drawText(string.format("Day:       %d", data.story.day - 1),  20, 108)

    gfx.drawLine(0, 128, 400, 128)

    -- New awards
    if #_newAwards > 0 then
        gfx.drawText("*New Awards!*", 150, 128)
        for i, aw in ipairs(_newAwards) do
            gfx.drawText(string.format("[%s] %s", aw.name, aw.desc), 20, 140 + (i - 1) * 18)
        end
    else
        gfx.drawText("No new awards this session.", 20, 130)
        -- Show progress toward next award (simple placeholder)
        local nextStr = string.format("Next DXCC milestone: %d/10 entities",
            math.min(_dxccCount, 10))
        if _dxccCount >= 200 then nextStr = "All DXCC milestones unlocked!"
        elseif _dxccCount >= 100 then nextStr = "DXCC count: " .. _dxccCount .. " — target 200"
        elseif _dxccCount >= 50  then nextStr = "DXCC count: " .. _dxccCount .. " — target 100"
        elseif _dxccCount >= 10  then nextStr = "DXCC count: " .. _dxccCount .. " — target 50"
        end
        gfx.drawText(nextStr, 20, 148)
    end

    gfx.drawLine(0, 192, 400, 192)
    gfx.drawText("\u{24B6}=Shop   \u{24B7}=Next Day", 110, 196)
    gfx.drawLine(0, 216, 400, 216)
    gfx.drawText(string.format("Day %d begins →", data.story.day), 140, 220)

    if playdate.buttonJustPressed(playdate.kButtonA) then
        _sceneManager.switch(ShopScene)
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        -- In tournament mode: end-of-round resolution
        if _tournament and _tournament.isActive() then
            local passed = _tournament.endRound()
            if not passed then
                _sceneManager.switch(GameOverScene)
            elseif _tournament.hasWon() then
                _sceneManager.switch(VictoryScene)
            else
                _sceneManager.switch(TournamentHubScene)
            end
        else
            _sceneManager.switch(SolarReportScene)
        end
    end
end

function SummaryScene.init(sm, sv, tourn)
    _sceneManager = sm
    _save         = sv
    _tournament   = tourn
end

return SummaryScene
