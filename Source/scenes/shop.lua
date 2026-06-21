-- Shop scene: buy and equip gear to upgrade your station.
-- Navigation: Up/Down to scroll list; Left/Right to change category;
-- A to buy/equip; B to return.

import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

ShopScene = {}

local _sceneManager = nil
local _save         = nil

-- Categories shown in the shop
local CATEGORIES = { "radios", "antennas", "amplifiers", "locations" }
local CAT_LABELS  = { radios="Radios", antennas="Antennas", amplifiers="Amps", locations="QTH" }

local _catIndex    = 1
local _itemIndex   = 1
local _statusMsg   = ""
local _statusTimer = 0

local function getItems()
    local cat = CATEGORIES[_catIndex]
    return Equipment.catalog()[cat] or {}
end

local function isOwned(item)
    local cat  = CATEGORIES[_catIndex]
    local data = _save.get()
    local owned = data.story.owned
    if not owned then return false end
    -- Normalize category key
    local key = cat
    return owned[key] and owned[key][item.id] == true
end

local function isEquipped(item)
    local data = _save.get()
    local eq   = data.story.equipment
    if not eq then return false end
    local cat = CATEGORIES[_catIndex]
    if cat == "radios"     then return eq.radio    == item.id end
    if cat == "antennas"   then return eq.antenna  == item.id end
    if cat == "amplifiers" then return eq.amp      == item.id end
    if cat == "locations"  then return eq.location == item.id end
    return false
end

local function buyOrEquip(item)
    local data = _save.get()
    local cat  = CATEGORIES[_catIndex]
    local owned = data.story.owned
    if not owned then
        owned = { radios={}, antennas={}, amplifiers={}, locations={} }
        data.story.owned = owned
    end
    if not owned[cat] then owned[cat] = {} end

    if isOwned(item) then
        -- Just equip it
        local eq = data.story.equipment
        if cat == "radios"     then eq.radio    = item.id end
        if cat == "antennas"   then eq.antenna  = item.id end
        if cat == "amplifiers" then eq.amp       = item.id end
        if cat == "locations"  then eq.location  = item.id end
        _save.write()
        Equipment.init(eq)
        _statusMsg   = "Equipped: " .. item.name
        _statusTimer = 120
    elseif data.story.cash >= item.cost then
        -- Buy and equip
        data.story.cash = data.story.cash - item.cost
        owned[cat][item.id] = true
        local eq = data.story.equipment
        if cat == "radios"     then eq.radio    = item.id end
        if cat == "antennas"   then eq.antenna  = item.id end
        if cat == "amplifiers" then eq.amp       = item.id end
        if cat == "locations"  then eq.location  = item.id end
        _save.write()
        Equipment.init(eq)
        _statusMsg   = "Bought: " .. item.name
        _statusTimer = 120
    else
        _statusMsg   = "Not enough cash!"
        _statusTimer = 90
    end
end

local function drawShack()
    -- Text-based shack tier display (placeholder for pixel art in M5 polish)
    local data = _save.get()
    local eq   = data.story.equipment
    local loc  = eq and eq.location or "apartment"

    local labels = {
        apartment = "[ Apt ]",
        house     = "[ House ]",
        hilltop   = "[ Hilltop ]",
        mountain  = "[ Mountain ]",
    }
    gfx.drawText("Shack: " .. (labels[loc] or loc), 270, 30)
end

function ShopScene:enter()
    local data = _save.get()
    Equipment.init(data.story.equipment)
    _catIndex   = 1
    _itemIndex  = 1
    _statusMsg  = ""
    _statusTimer = 0
end

function ShopScene:leave() end

function ShopScene:update()
    gfx.clear(gfx.kColorWhite)

    local data = _save.get()
    local cash = data.story.cash or 0

    -- Header
    gfx.drawText("*Shop*", 180, 2)
    gfx.drawText(string.format("$%d", cash), 330, 2)
    gfx.drawLine(0, 16, 400, 16)

    -- Category tabs
    for i, cat in ipairs(CATEGORIES) do
        local x = (i - 1) * 80 + 10
        local label = CAT_LABELS[cat]
        if i == _catIndex then
            gfx.fillRect(x - 2, 18, 78, 16)
            gfx.setImageDrawMode(gfx.kDrawModeInverted)
            gfx.drawText(label, x + 2, 20)
            gfx.setImageDrawMode(gfx.kDrawModeCopy)
        else
            gfx.drawRect(x - 2, 18, 78, 16)
            gfx.drawText(label, x + 2, 20)
        end
    end
    gfx.drawLine(0, 36, 400, 36)

    drawShack()

    -- Items list
    local items = getItems()
    local ROWS  = 7
    local startRow = math.max(1, _itemIndex - ROWS + 1)

    for i = 0, ROWS - 1 do
        local idx = startRow + i
        if idx > #items then break end
        local item = items[idx]
        local y    = 40 + i * 22
        local owned    = isOwned(item)
        local equipped = isEquipped(item)

        -- Cursor
        if idx == _itemIndex then
            gfx.fillRect(0, y - 1, 250, 20)
            gfx.setImageDrawMode(gfx.kDrawModeInverted)
        end

        -- Badge
        local badge = equipped and "[EQ]" or (owned and "[OWN]" or "")
        gfx.drawText(item.name, 4, y + 1)
        if badge ~= "" then gfx.drawText(badge, 200, y + 1) end

        gfx.setImageDrawMode(gfx.kDrawModeCopy)

        -- Cost (right column)
        local costStr = owned and "owned" or string.format("$%d", item.cost)
        local canAfford = owned or cash >= item.cost
        if not canAfford then
            -- Gray out with lighter text (dither not needed; just show the price)
        end
        gfx.drawText(costStr, 260, y + 1)
    end

    gfx.drawLine(0, 200, 400, 200)

    -- Selected item detail
    if #items > 0 then
        local item = items[_itemIndex]
        if item then
            local detail = ""
            if item.bands then detail = detail .. "Bands: " .. table.concat(item.bands, "/") .. "  " end
            if item.txPower then detail = detail .. "TX:" .. item.txPower .. "W  " end
            if item.gain    then detail = detail .. "Gain:" .. item.gain .. "dBd  " end
            if item.mult    then detail = detail .. "Amp:" .. item.mult .. "x  " end
            gfx.drawText(detail, 4, 202)
        end
    end

    -- Status message
    if _statusTimer > 0 then
        _statusTimer = _statusTimer - 1
        local mw = gfx.getTextSize(_statusMsg)
        gfx.drawText(_statusMsg, (400 - mw) // 2, 215)
    end

    gfx.drawLine(0, 228, 400, 228)
    gfx.drawText("\u{24B6}=Buy/Equip  \u{24B7}=Back  \u{2190}\u{2192}=Category", 4, 230)

    -- ── Input ────────────────────────────────────────────────────────────────
    if playdate.buttonJustPressed(playdate.kButtonUp) then
        _itemIndex = math.max(1, _itemIndex - 1)
    elseif playdate.buttonJustPressed(playdate.kButtonDown) then
        local items2 = getItems()
        _itemIndex = math.min(#items2, _itemIndex + 1)
    elseif playdate.buttonJustPressed(playdate.kButtonLeft) then
        _catIndex  = math.max(1, _catIndex - 1)
        _itemIndex = 1
    elseif playdate.buttonJustPressed(playdate.kButtonRight) then
        _catIndex  = math.min(#CATEGORIES, _catIndex + 1)
        _itemIndex = 1
    elseif playdate.buttonJustPressed(playdate.kButtonA) then
        local items3 = getItems()
        if items3[_itemIndex] then
            buyOrEquip(items3[_itemIndex])
        end
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        -- If the shop was opened mid-session (from the pause menu while
        -- operating), resume operating with the newly-bought gear. Otherwise
        -- proceed to the Solar Report as before.
        if SceneManager.previous() == OperateScene then
            _sceneManager.switch(OperateScene)
        else
            _sceneManager.switch(SolarReportScene)
        end
    end
end

function ShopScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return ShopScene
