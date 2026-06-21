-- Title screen: New Game / Continue / Mode Select
-- Navigation: D-pad up/down; A to confirm.

import "CoreLibs/graphics"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

TitleScene = {}

-- Forward declarations set during enter()
local _sceneManager = nil
local _save         = nil

local ITEMS = { "New Game", "Continue", "Logbook", "Mode Select", "Settings", "QSL Cards" }
local _cursor   = 1
local _mode     = "story"   -- "story" | "tournament"
local _showMode = false      -- true while mode-select sub-menu is visible

local MODE_ITEMS = { "Story", "Tournament" }
local _modeCursor = 1

-- Overwrite-save confirmation sub-menu
local _showConfirm = false
local _confirmCursor = 2     -- default to "No"
local CONFIRM_ITEMS = { "Yes", "No" }

-- Transient on-screen notice (e.g. "No saved game")
local _notice = nil
local _noticeTimer = nil

local function showNotice(text)
    _notice = text
    if _noticeTimer then _noticeTimer:remove() end
    _noticeTimer = playdate.timer.new(1500)
    _noticeTimer.timerEndedCallback = function()
        _notice = nil
        _noticeTimer = nil
    end
end

-- Simple blink timer
local _blinkOn  = true
local _blinkTimer = nil

local function drawTitle()
    gfx.clear(gfx.kColorWhite)

    -- Title text
    local titleStr = "DXer"
    local tw, _ = gfx.getTextSize("*" .. titleStr .. "*")
    gfx.drawText("*" .. titleStr .. "*", (400 - tw) // 2, 30)

    -- Sub-title
    local sub = "Ham Radio DX"
    local sw = gfx.getTextSize(sub)
    gfx.drawText(sub, (400 - sw) // 2, 62)

    -- Horizontal divider
    gfx.drawLine(60, 80, 340, 80)

    if _showConfirm then
        -- Overwrite-save confirmation
        gfx.drawText("Overwrite save?", 140, 100)
        for i, item in ipairs(CONFIRM_ITEMS) do
            local prefix = (i == _confirmCursor and _blinkOn) and "> " or "  "
            gfx.drawText(prefix .. item, 170, 122 + (i - 1) * 20)
        end
    elseif _showMode then
        -- Mode select sub-menu
        gfx.drawText("Select Mode:", 140, 100)
        for i, item in ipairs(MODE_ITEMS) do
            local prefix = (i == _modeCursor and _blinkOn) and "> " or "  "
            gfx.drawText(prefix .. item, 150, 122 + (i - 1) * 20)
        end
    else
        -- Main menu (6 items, 18px apart, starting at y=86)
        for i, item in ipairs(ITEMS) do
            local prefix = (i == _cursor and _blinkOn) and "> " or "  "
            gfx.drawText(prefix .. item, 140, 86 + (i - 1) * 18)
        end

        -- Mode badge (below the last menu item at y=194)
        local badge = "Mode: " .. (_mode == "story" and "Story" or "Tournament")
        gfx.drawText(badge, 140, 196)
    end

    -- Transient notice (e.g. "No saved game")
    if _notice then
        local nw = gfx.getTextSize(_notice)
        gfx.drawText(_notice, (400 - nw) // 2, 212)
    else
        -- Bottom hint
        gfx.drawText("\u{24B6} Confirm  \u{24B7} Back", 110, 222)
    end
end

function TitleScene:enter()
    -- Restore last-used mode from save
    local data = _save.get()
    if data then
        _mode = data.lastMode or "story"
        _modeCursor = (_mode == "tournament") and 2 or 1
    end

    _cursor      = 1
    _showMode    = false
    _showConfirm = false
    _notice      = nil

    _blinkOn = true
    _blinkTimer = playdate.timer.new(400)
    _blinkTimer.repeats = true
    _blinkTimer.timerEndedCallback = function()
        _blinkOn = not _blinkOn
    end
end

function TitleScene:leave()
    if _blinkTimer then
        _blinkTimer:remove()
        _blinkTimer = nil
    end
    if _noticeTimer then
        _noticeTimer:remove()
        _noticeTimer = nil
    end
    _notice = nil
end

-- Actually begin a brand-new game for the current mode.
local function startNewGame()
    if _mode == "tournament" then
        Tournament.start()
        _sceneManager.switch(TournamentHubScene)
    else
        _save.newStory()
        _sceneManager.switch(SolarReportScene)
    end
end

local function confirmMain()
    if _cursor == 1 then
        -- New Game: confirm overwrite if real progress exists (story mode).
        if _mode == "story" and _save.hasStoryProgress() then
            _showConfirm = true
            _confirmCursor = 2   -- default to "No"
        else
            startNewGame()
        end
    elseif _cursor == 2 then
        -- Continue: only if there is actual saved progress.
        if _mode == "tournament" then
            _sceneManager.switch(TournamentHubScene)
        elseif _save.hasStoryProgress() then
            _sceneManager.switch(SolarReportScene)
        else
            showNotice("No saved game")
        end
    elseif _cursor == 3 then
        _sceneManager.switch(LogbookScene)
    elseif _cursor == 4 then
        _showMode = true
        _modeCursor = (_mode == "tournament") and 2 or 1
    elseif _cursor == 5 then
        _sceneManager.switch(SettingsScene)
    elseif _cursor == 6 then
        _sceneManager.switch(QSLScene)
    end
end

local function confirmMode()
    if _modeCursor == 1 then
        _mode = "story"
    else
        _mode = "tournament"
    end
    local data = _save.get()
    if data then
        data.lastMode = _mode
        _save.write()
    end
    _showMode = false
end

function TitleScene:update()
    -- Transition handled by scene manager before this runs

    if _showConfirm then
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            _confirmCursor = math.max(1, _confirmCursor - 1)
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            _confirmCursor = math.min(#CONFIRM_ITEMS, _confirmCursor + 1)
        elseif playdate.buttonJustPressed(playdate.kButtonA) then
            _showConfirm = false
            if _confirmCursor == 1 then
                startNewGame()
            end
        elseif playdate.buttonJustPressed(playdate.kButtonB) then
            _showConfirm = false
        end
    elseif _showMode then
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            _modeCursor = math.max(1, _modeCursor - 1)
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            _modeCursor = math.min(#MODE_ITEMS, _modeCursor + 1)
        elseif playdate.buttonJustPressed(playdate.kButtonA) then
            confirmMode()
        elseif playdate.buttonJustPressed(playdate.kButtonB) then
            _showMode = false
        end
    else
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            _cursor = math.max(1, _cursor - 1)
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            _cursor = math.min(#ITEMS, _cursor + 1)
        elseif playdate.buttonJustPressed(playdate.kButtonA) then
            confirmMain()
        end
    end

    drawTitle()
end

-- Inject dependencies (called from main.lua after requiring all modules)
function TitleScene.init(sm, sv)
    _sceneManager = sm
    _save = sv
end

return TitleScene
