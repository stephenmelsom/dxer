-- Scene/state manager.
-- Each scene is a table with optional enter(), leave(), update() methods.
-- Switching cleans up all sprites automatically.

local gfx <const> = playdate.graphics

SceneManager = {}

local _current  = nil
local _previous = nil   -- scene we switched away from (for back-navigation)
local _next     = nil   -- pending transition (deferred to start of next frame)

function SceneManager.switch(scene)
    _next = scene
end

-- Call at the top of playdate.update() before anything else.
function SceneManager.applyPendingSwitch()
    if _next == nil then return end

    -- Leave current scene
    if _current and _current.leave then
        _current:leave()
    end

    -- Remove all sprites so scenes start clean
    gfx.sprite.removeAll()

    _previous = _current
    _current  = _next
    _next     = nil

    -- Enter new scene
    if _current and _current.enter then
        _current:enter()
    end
end

function SceneManager.update()
    if _current and _current.update then
        _current:update()
    end
end

function SceneManager.current()
    return _current
end

function SceneManager.previous()
    return _previous
end

return SceneManager
