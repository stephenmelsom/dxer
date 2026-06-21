-- Tutorial scene: walks through the tuning mechanic step by step.
-- One page per step; A/Right to advance, B to skip to title.

import "CoreLibs/graphics"
import "CoreLibs/ui"

local gfx <const> = playdate.graphics

TutorialScene = {}

local _sceneManager = nil
local _save         = nil

local _page = 1

local PAGES = {
    {
        title = "Welcome to DXer!",
        body  = {
            "You're a ham radio operator hunting",
            "contacts (QSOs) from around the world.",
            "",
            "The key mechanic is ZERO-BEAT tuning:",
            "spin the crank to tune your radio to",
            "a signal's exact frequency.",
            "",
            "Let's walk through it step by step.",
        },
    },
    {
        title = "The Panadapter",
        body  = {
            "The top of the screen shows the BAND —",
            "a scrolling spectrum of signals.",
            "",
            "Each spike = a station calling CQ.",
            "Rarer stations have shorter, weaker spikes.",
            "",
            "The triangle at the center = your VFO",
            "(the frequency you're listening on).",
        },
    },
    {
        title = "Tuning with the Crank",
        body  = {
            "SPIN THE CRANK to move your VFO across",
            "the band. The spectrum scrolls as you tune.",
            "",
            "HOLD B + crank for fine-tune mode",
            "(10x more precise — great for CW).",
            "",
            "No crank? Use UP/DOWN on the D-pad.",
            "The crank hint shows when it's docked.",
        },
    },
    {
        title = "Zero-Beat Tuning",
        body  = {
            "When your VFO gets close to a signal,",
            "you'll hear a BEAT TONE.",
            "",
            "As you tune closer, the tone drops in",
            "pitch. At zero-beat (exactly on freq),",
            "the tone nearly disappears.",
            "",
            "Watch the TUNING METER for a visual cue!",
        },
    },
    {
        title = "Logging a Contact",
        body  = {
            "When you're on frequency, the station's",
            "callsign appears above the tuning meter.",
            "",
            "Press A to call them and LOG the QSO!",
            "",
            "You'll see a flash and hear a chime.",
            "The contact is saved in your logbook.",
            "",
            "Rare DX contacts need more TX power.",
        },
    },
    {
        title = "The S-Meter & Scoring",
        body  = {
            "The S-METER shows received signal strength.",
            "Rare DX stations have weak signals (QSB).",
            "",
            "Points per QSO depend on rarity:",
            "  Common    = 10-25 pts",
            "  Uncommon  = 30-50 pts",
            "  Rare DX   = 75-160 pts",
            "  DXpedition= 500-800 pts",
        },
    },
    {
        title = "Daily Loop",
        body  = {
            "Each day starts with a Solar Report",
            "showing which bands are open.",
            "",
            "Operate → earn points → End Session",
            "from the pause menu.",
            "",
            "Points convert to cash. Spend cash in",
            "the SHOP to upgrade your station!",
        },
    },
    {
        title = "You're Ready!",
        body  = {
            "You now know the basics of DXer.",
            "",
            "Tips for success:",
            "  * Hunt the rarest DX you can hear",
            "  * Upgrade antennas for better signals",
            "  * Check propagation — bands open/close",
            "  * Save cash for HF gear upgrades",
            "",
            "Good luck and 73!",
        },
    },
}

local function drawPage(page)
    gfx.clear(gfx.kColorWhite)

    -- Progress indicator
    local prog = string.format("%d / %d", _page, #PAGES)
    gfx.drawText(prog, 350, 2)

    -- Title
    gfx.drawText("*" .. page.title .. "*", 10, 4)
    gfx.drawLine(0, 18, 400, 18)

    -- Body text
    for i, line in ipairs(page.body) do
        gfx.drawText(line, 10, 22 + (i - 1) * 18)
    end

    gfx.drawLine(0, 210, 400, 210)
    if _page < #PAGES then
        gfx.drawText("\u{24B6} / \u{2192} = Next   \u{24B7} = Skip", 100, 214)
    else
        gfx.drawText("\u{24B6} Start Playing!", 130, 214)
    end
end

function TutorialScene:enter()
    _page = 1
end

function TutorialScene:leave() end

function TutorialScene:update()
    drawPage(PAGES[_page])

    local advance = playdate.buttonJustPressed(playdate.kButtonA)
               or  playdate.buttonJustPressed(playdate.kButtonRight)

    if advance then
        if _page < #PAGES then
            _page = _page + 1
        else
            -- Done — mark tutorial seen and go to title
            local data = _save.get()
            data.tutorialSeen = true
            _save.write()
            _sceneManager.switch(TitleScene)
        end
    elseif playdate.buttonJustPressed(playdate.kButtonB) then
        local data = _save.get()
        data.tutorialSeen = true
        _save.write()
        _sceneManager.switch(TitleScene)
    end
end

function TutorialScene.init(sm, sv)
    _sceneManager = sm
    _save         = sv
end

return TutorialScene
