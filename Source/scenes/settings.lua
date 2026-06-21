-- Settings scene: sound volume, crank sensitivity, reset save.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

SettingsScene = {}

local _sceneManager = nil
local _save         = nil

local ITEMS = {
    { key = "soundEnabled",      label = "Sound",             type = "bool"  },
    { key = "crankSensitivity",  label = "Crank Sensitivity", type = "float",
      min = 0.25, max = 3.0, step = 0.25 },
    { key = "resetSave",         label = "Reset Save Data",   type = "action" },
    { key = "tutorial",          label = "View Tutorial",     type = "action" },
}

local _cursor      = 1
local _confirmReset = false

local function getData() return _save.get() end

local function getValue(item)
    local data = getData()
    if item.type == "bool"  then return data[item.key] ~= false end
    if item.type == "float" then return data[item.key] or 1.0   end
    return nil
end

local function setValue(item, val)
    local data = getData()
    data[item.key] = val
    _save.write()
end

local function drawValue(item, y)
    local val = getValue(item)
    local str = ""
    if item.type == "bool"  then str = val and "[ON]"  or "[OFF]" end
    if item.type == "float" then str = string.format("%.2f", val) end
    if item.type == "action" then str = "[press A]" end
    gfx.drawText(str, 260, y)
end

function SettingsScene:enter()
    _cursor       = 1
    _confirmReset = false
end

function SettingsScene:leave() end

function SettingsScene:update()
    gfx.clear(gfx.kColorWhite)

    gfx.drawText("*Settings*", 160, 2)
    gfx.drawLine(0, 18, 400, 18)

    for i, item in ipairs(ITEMS) do
        local y = 22 + (i - 1) * 30
        if i == _cursor then
            gfx.fillRect(0, y - 1, 400, 24)
            gfx.setImageDrawMode(gfx.kDrawModeInverted)
        end
        gfx.drawText(item.label, 10, y + 3)
        drawValue(item, y + 3)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end

    -- Confirm reset dialog
    if _confirmReset then
        gfx.fillRect(60, 80, 280, 80)
        gfx.setImageDrawMode(gfx.kDrawModeInverted)
        gfx.drawText("Reset all save data?", 80, 94)
        gfx.drawText("This cannot be undone!", 80, 112)
        gfx.drawText("\u{24B6} YES  \u{24B7} No", 130, 134)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end

    gfx.drawLine(0, 228, 400, 228)
    gfx.drawText("\u{24B7} Back", 340, 230)

    -- Input
    if _confirmReset then
        if playdate.buttonJustPressed(playdate.kButtonA) then
            _save.delete()
            _save.load()
            _confirmReset = false
            _sceneManager.switch(TitleScene)
        elseif playdate.buttonJustPressed(playdate.kButtonB) then
            _confirmReset = false
        end
        return
    end

    if playdate.buttonJustPressed(playdate.kButtonUp) then
        _cursor = math.max(1, _cursor - 1)
    elseif playdate.buttonJustPressed(playdate.kButtonDown) then
        _cursor = math.min(#ITEMS, _cursor + 1)
    elseif playdate.buttonJustPressed(playdate.kButtonA) then
        local item = ITEMS[_cursor]
        if item.type == "bool" then
            local newValue = not getValue(item)
            setValue(item, newValue)
            if item.key == "soundEnabled" then
                ZeroBeat.setEnabled(newValue)
            end
        elseif item.type == "action" then
            if item.key == "resetSave" then
                _confirmReset = true
            elseif item.key == "tutorial" then
                _sceneManager.switch(TutorialScene)
            end
        end
    elseif playdate.buttonJustPressed(playdate.kButtonRight) then
        local item = ITEMS[_cursor]
        if item.type == "float" then
            local v = math.min(item.max, (getValue(item) or item.min) + item.step)
            setValue(item, v)
            if item.key == "crankSensitivity" then
                config.crankSensitivity = v
            end
        end
    elseif playdate.buttonJustPressed(playdate.kButtonLeft) then
        local item = ITEMS[_cursor]
        if item.type == "float" then
            local v = math.max(item.min, (getValue(item) or item.max) - item.step)
            setValue(item, v)
            if item.key == "crankSensitivity" then
                config.crankSensitivity = v
            end
        end
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        _sceneManager.switch(TitleScene)
    end
end

function SettingsScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return SettingsScene
