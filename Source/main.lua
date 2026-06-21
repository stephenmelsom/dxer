import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

-- core (no deps)
import "core/config"
import "core/band"
import "core/dxcc"
import "core/callsign"
import "core/clock"
import "core/awards"
import "core/qsl"
import "core/contest"
import "core/save"
import "core/scene_manager"
import "core/qrm"

-- core (with deps on above)
import "core/vfo"             -- uses config, Band
import "core/propagation"     -- uses Clock, Band
import "core/contact_manager" -- uses config, DXCC, Callsign
import "core/equipment"
import "core/tournament"      -- uses config
import "core/zero_beat"       -- uses config

-- ui
import "ui/panadapter"
import "ui/zero_beat_meter"   -- uses config

-- scenes (all core globals already set)
import "scenes/title"
import "scenes/tutorial"
import "scenes/solar_report"
import "scenes/operate"
import "scenes/logbook"
import "scenes/shop"
import "scenes/summary"
import "scenes/tournament_hub"
import "scenes/game_over"
import "scenes/victory"
import "scenes/contest_result"
import "scenes/qsl_collection"
import "scenes/settings"

local gfx <const> = playdate.graphics

-- Load save data on boot
save.load()

local _saveData    = save.get()
local soundEnabled = _saveData.soundEnabled ~= false

-- Apply saved crank sensitivity so VFO tuning honors the setting
config.crankSensitivity = _saveData.crankSensitivity or 1.0

-- Accessibility: respect reduce-flashing system setting
local _reduceFlashing = playdate.getReduceFlashing()

playdate.display.setRefreshRate(config.targetFPS)

-- Wire up all scenes
TitleScene.init(SceneManager, save)
TutorialScene.init(SceneManager, save)
SolarReportScene.init(SceneManager, save, Propagation, Clock)
OperateScene.init(SceneManager, save, Tournament)
LogbookScene.init(SceneManager, save)
ShopScene.init(SceneManager, save)
SummaryScene.init(SceneManager, save, Tournament)
TournamentHubScene.init(SceneManager, save)
GameOverScene.init(SceneManager, save)
VictoryScene.init(SceneManager, save)
ContestResultScene.init(SceneManager, save)
QSLScene.init(SceneManager, save)
SettingsScene.init(SceneManager, save)

-- System pause menu (max 3 items)
local menu = playdate.getSystemMenu()
menu:addCheckmarkMenuItem("Sound", soundEnabled, function(value)
    soundEnabled = value
    local data = save.get()
    data.soundEnabled = value
    save.write()
    -- Apply immediately so audio mutes/unmutes live during a session
    ZeroBeat.setEnabled(value)
end)
menu:addMenuItem("Shop", function()
    SceneManager.switch(ShopScene)
end)
menu:addMenuItem("End Session", function()
    SceneManager.switch(SummaryScene)
end)

-- Boot: show tutorial on first run, otherwise go to title
local data = save.get()
if not data.tutorialSeen then
    SceneManager.switch(TutorialScene)
else
    SceneManager.switch(TitleScene)
end

-- ── Main update loop ────────────────────────────────────────────────────────

local _showFPS = false  -- toggle with A+B held at title (debug only)

function playdate.update()
    SceneManager.applyPendingSwitch()
    SceneManager.update()
    gfx.sprite.update()
    playdate.timer.updateTimers()

    if _showFPS then
        playdate.drawFPS(380, 0)
    end
end
