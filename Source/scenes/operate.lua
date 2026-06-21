-- Operate scene — core radio-operating gameplay loop.
-- M3: live band switching, propagation-gated contacts, in-game clock.

import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/ui"

local gfx <const> = playdate.graphics

OperateScene = {}

local _sceneManager  = nil
local _save          = nil
local _tournament    = nil   -- injected when in tournament mode

-- ── QSO flash ────────────────────────────────────────────────────────────────
local _qsoFlash      = false
local _qsoFlashMsg   = ""
local _qsoFlashTimer = nil

-- ── Runtime state ─────────────────────────────────────────────────────────────
local _nearContact  = nil
local _offsetHz     = 0
local _onTune       = false
local _effectiveStrength = 0   -- displayStrength after QRM degradation (S-meter)
local _worked       = {}
local _lastFrameMs  = 0

-- Band list for Up/Down switching (index into Band.all())
local _bandIndex    = 1

-- ── Helpers ───────────────────────────────────────────────────────────────────

local function currentBandDef()
    return Band.all()[_bandIndex]
end

local function drawFreqReadout()
    local freqStr = VFO.formatFreq()
    local lw = gfx.getTextSize("*" .. freqStr .. "*")
    gfx.drawText("*" .. freqStr .. "*", (400 - lw) // 2, 2)
    gfx.drawText(VFO.getBand().name, 4, 2)
    -- Mode label
    local mode = Equipment.getMode()
    gfx.drawText(string.upper(mode), 4, 14)
    if VFO.isFine() then gfx.drawText("FINE", 60, 14) end
    -- Clock
    gfx.drawText(Clock.formatTime(), 330, 2)
end

-- S-meter row: boxes at y136, scale text at y152. Lives in its own band
-- below the panadapter freq labels (≈y121-133) and above the zero-beat meter.
local SMETER_Y    = 142
local SMETER_SCALE_Y = 160
local function drawSMeter()
    local SEGS  = 12
    local SEG_W = 14
    local SEG_H = 14
    local startX = (400 - SEGS * (SEG_W + 2)) // 2
    -- _effectiveStrength is the QRM-degraded reading (see update()).
    local strength = _effectiveStrength or 0
    local lit = math.floor(strength * SEGS)

    gfx.drawText("S:", startX - 20, SMETER_Y)
    for i = 1, SEGS do
        local sx = startX + (i - 1) * (SEG_W + 2)
        gfx.drawRect(sx, SMETER_Y, SEG_W, SEG_H)
        if i <= lit then
            gfx.fillRect(sx + 1, SMETER_Y + 1, SEG_W - 2, SEG_H - 2)
        end
    end
    gfx.drawText("1            5           9       +", startX + 2, SMETER_SCALE_Y)
end

local function drawBandCondition()
    local bandId = VFO.getBandId()
    local cond   = Propagation.getCondition(bandId)
    local label  = Propagation.conditionLabel(cond)
    -- Left side of the S-meter scale row; the centered "1 5 9 +" scale
    -- starts at x≈104, so this never overprints it.
    gfx.drawText("Prop: " .. label, 6, SMETER_SCALE_Y)
end

local function drawCallPrompt()
    if _nearContact == nil then return end
    local prompt
    if _worked[_nearContact.callsign] then
        prompt = "DUPE: " .. _nearContact.callsign
    elseif _onTune then
        prompt = "\u{24B6} CALL " .. _nearContact.callsign
    else
        prompt = "Tuning... " .. _nearContact.callsign
    end
    local pw = gfx.getTextSize(prompt)
    gfx.drawText(prompt, (400 - pw) // 2, 188)
end

local function drawQsoFlash()
    if not _qsoFlash then return end
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.fillRect(0, 202, 400, 24)
    local mw = gfx.getTextSize(_qsoFlashMsg)
    gfx.drawText(_qsoFlashMsg, (400 - mw) // 2, 206)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
end

local function logContact(contact)
    if _worked[contact.callsign] then return end
    _worked[contact.callsign] = true

    local data = _save.get()
    local t    = playdate.getTime()
    local timeStr = t and string.format("%02d:%02d", t.hour, t.minute) or "--:--"
    local pts = math.floor(contact.points * Equipment.pointsMultiplier())
    if Contest.isActive() then
        pts = Contest.logQso(pts)
    end
    if _tournament and _tournament.isActive() then
        _tournament.addPoints(pts)
    end
    table.insert(data.story.logbook, {
        call   = contact.callsign,
        entity = contact.entity,
        band   = VFO.getBandId(),
        mode   = Equipment.getMode(),
        points = pts,
        time   = timeStr,
    })
    data.story.totalPoints = (data.story.totalPoints or 0) + pts
    data.story.dxccWorked  = data.story.dxccWorked or {}
    data.story.dxccWorked[contact.entity] = true

    -- QSL card award
    if QSL.roll(contact.rarity) then
        QSL.addCard(data, {
            call   = contact.callsign,
            entity = contact.entity,
            band   = VFO.getBandId(),
            mode   = Equipment.getMode(),
            rarity = contact.rarity,
        })
    end

    _save.write()

    ZeroBeat.playQsoChime()
    _qsoFlash    = true
    _qsoFlashMsg = string.format("QSO! %s  +%d pts", contact.callsign, pts)
    if _qsoFlashTimer then _qsoFlashTimer:remove() end
    _qsoFlashTimer = playdate.timer.new(2000)
    _qsoFlashTimer.timerEndedCallback = function() _qsoFlash = false end
end

local function switchBand(delta)
    local bands = Band.all()
    local tries = 0
    local idx   = _bandIndex
    repeat
        idx   = idx + delta
        tries = tries + 1
        if idx < 1       then idx = #bands end
        if idx > #bands  then idx = 1      end
    until Equipment.canUseBand(bands[idx].id) or tries > #bands

    if Equipment.canUseBand(bands[idx].id) then
        _bandIndex   = idx
        local b      = bands[idx]
        VFO.setBand(b.id)
        ContactManager.init(b.id, b.hzLow, b.hzHigh)
        _nearContact = nil
        _offsetHz    = 0
    end
end

-- ── Scene lifecycle ───────────────────────────────────────────────────────────

function OperateScene:enter()
    local data = _save.get()

    -- Load equipment from save
    Equipment.init(data.story.equipment)

    -- Start on first available band
    _bandIndex = 1
    local bands = Band.all()
    for i, b in ipairs(bands) do
        if Equipment.canUseBand(b.id) then
            _bandIndex = i
            break
        end
    end
    local b = bands[_bandIndex]
    VFO.init(b.id)

    ContactManager.init(b.id, b.hzLow, b.hzHigh)
    QRM.init(b.hzLow, b.hzHigh)
    ZeroBeat.init(data.soundEnabled ~= false)

    _worked      = {}
    _qsoFlash    = false
    _lastFrameMs = playdate.getCurrentTimeMilliseconds()
end

function OperateScene:leave()
    ZeroBeat.setEnabled(false)
end

function OperateScene:update()
    local now = playdate.getCurrentTimeMilliseconds()
    local dt  = (now - _lastFrameMs) / 1000
    _lastFrameMs = now

    -- Advance in-game clock
    Clock.update(dt)

    -- Contact manager ticks
    ContactManager.update(dt)

    -- QRM update
    QRM.update(dt)

    -- ── Input ────────────────────────────────────────────────────────────────
    VFO.setFine(playdate.buttonIsPressed(playdate.kButtonB))

    local crankDelta = playdate.getCrankChange()
    if math.abs(crankDelta) > 0.1 then
        VFO.applyCrank(crankDelta)
    end

    -- Bug #6b: Up/Down are context-sensitive.
    --  • Crank DOCKED  → coarse tuning (accessibility fallback for crank tuning)
    --  • Crank ACTIVE  → cycle operating mode (tuning is done via the crank)
    if playdate.isCrankDocked() then
        if playdate.buttonJustPressed(playdate.kButtonUp) then
            VFO.stepUp()
        elseif playdate.buttonJustPressed(playdate.kButtonDown) then
            VFO.stepDown()
        end
    else
        if playdate.buttonJustPressed(playdate.kButtonUp)
        or playdate.buttonJustPressed(playdate.kButtonDown) then
            Equipment.cycleMode()
            -- Persist the chosen mode to save.
            local d = _save.get()
            d.story.equipment = d.story.equipment or {}
            d.story.equipment.mode = Equipment.getMode()
            _save.write()
        end
    end

    -- Band switching: Left = lower band, Right = higher band
    if playdate.buttonJustPressed(playdate.kButtonLeft) then
        switchBand(-1)
    elseif playdate.buttonJustPressed(playdate.kButtonRight) then
        switchBand(1)
    end

    -- Find nearest contact
    local vfoFreq = VFO.getFreq()
    _nearContact, _offsetHz = ContactManager.findNearest(vfoFreq)
    local audioRange = config.zeroHzThreshold * 4
    if _nearContact and math.abs(_offsetHz) >= audioRange then
        _nearContact = nil
        _offsetHz    = 0
    end

    -- Bug #6a: apply the per-mode zero-beat modifier so CW needs tighter
    -- tuning and FM is effectively "on channel". FM returns 999 from the
    -- modifier (meaning no zero-beat required); we treat that as "anywhere a
    -- signal is in audio range counts as on-tune", capped at audioRange so it
    -- stays sane rather than literally 999×threshold.
    local modeMod = Equipment.zeroHzModifier()
    local effThreshold
    if modeMod >= 999 then
        effThreshold = audioRange   -- FM: on-channel anywhere within audio range
    else
        effThreshold = config.zeroHzThreshold * modeMod
    end

    -- Bug #5: QRM degrades reception. Sample interference at the contact's
    -- frequency. Strong QRM lowers the effective S-meter reading AND tightens
    -- how close you must tune to land the contact (you must "dig it out" of the
    -- noise). Kept simple and fair: QRM 1.0 halves usable strength and roughly
    -- halves the on-tune window; QRM 0 leaves everything untouched.
    local qrm = 0
    if _nearContact then
        qrm = QRM.strengthAt(_nearContact.freq)
        _effectiveStrength = math.max(0, _nearContact.displayStrength * (1 - 0.5 * qrm))
        effThreshold = effThreshold * (1 - 0.5 * qrm)
    else
        _effectiveStrength = 0
    end

    _onTune = _nearContact ~= nil and math.abs(_offsetHz) <= effThreshold

    -- Zero-beat audio (feed the QRM-degraded strength so audio dims under noise)
    if _nearContact then
        ZeroBeat.update(_offsetHz, _effectiveStrength)
    else
        ZeroBeat.update(nil, 0)
    end

    -- Contest: update timer, check for auto-end
    if Contest.isActive() then
        Contest.update(dt)
        if not Contest.isActive() then
            -- Contest just ended
            _sceneManager.switch(ContestResultScene)
            return
        end
    end

    -- A: log contact
    if playdate.buttonJustPressed(playdate.kButtonA) then
        if _onTune and _nearContact and not _worked[_nearContact.callsign] then
            -- Pileup power check for DXpedition contacts
            if _nearContact.rarity == "dxpedition" then
                local power = Equipment.getTxPower()
                local needed = 200  -- watts minimum to break pileup
                if power < needed then
                    -- Show "power too low" message instead of logging
                    _qsoFlash    = true
                    _qsoFlashMsg = string.format("Need %dW to break pileup! (%dW)", needed, math.floor(power))
                    if _qsoFlashTimer then _qsoFlashTimer:remove() end
                    _qsoFlashTimer = playdate.timer.new(1800)
                    _qsoFlashTimer.timerEndedCallback = function() _qsoFlash = false end
                else
                    logContact(_nearContact)
                end
            else
                logContact(_nearContact)
            end
        end
    end

    -- ── Draw ─────────────────────────────────────────────────────────────────
    gfx.clear(gfx.kColorWhite)

    drawFreqReadout()

    local band = VFO.getBand()
    Panadapter.draw(VFO.getFreq(), band.hzPerPx, ContactManager.getPanadapterBlips(), QRM.getBlobs())

    drawSMeter()
    drawBandCondition()
    ZeroBeatMeter.draw(_offsetHz, _nearContact ~= nil)
    drawCallPrompt()
    drawQsoFlash()

    -- Contest HUD overlay
    if Contest.isActive() then
        local timeLeft = Contest.getTimeLeft()
        local mins = math.floor(timeLeft / 60)
        local secs = math.floor(timeLeft % 60)
        local contestBar = string.format("[%s] %02d:%02d  QSOs:%d  Score:%d  #%d",
            Contest.getName(), mins, secs, Contest.getQsoCount(), Contest.getScore(), Contest.getSerial())
        -- Draw contest banner at bottom-ish
        gfx.setImageDrawMode(gfx.kDrawModeXOR)
        gfx.fillRect(0, 212, 400, 14)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
        local cw = gfx.getTextSize(contestBar)
        gfx.drawText(contestBar, (400 - cw) // 2, 214)
    end

    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:draw()
    end

    gfx.drawLine(0, 216, 400, 216)
    -- Hint reflects context-sensitive Up/Down (Bug #6b).
    local udHint = playdate.isCrankDocked() and "\u{2195}=Tune" or "\u{2195}=Mode"
    gfx.drawText("\u{2190}\u{2192}=Band  " .. udHint .. "  \u{24b7}=Fine  \u{24B6}=Log", 4, 220)

    -- Score display
    if _tournament and _tournament.isActive() then
        local roundScore = _tournament.getScore()
        local needed     = _tournament.getThreshold()
        gfx.drawText(string.format("R%d: %d/%d", _tournament.getRound(), roundScore, needed), 270, 220)
    else
        local data = _save.get()
        local pts  = data and data.story.totalPoints or 0
        gfx.drawText(string.format("%d pts", pts), 330, 220)
    end
end

function OperateScene.init(sm, sv, tourn)
    _sceneManager = sm
    _save         = sv
    _tournament   = tourn
end

return OperateScene
