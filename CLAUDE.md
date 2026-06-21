# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

DXer is a cozy ham-radio DXing game for the **Playdate** console, written in Lua against the Playdate SDK. The player tunes a radio with the crank (zero-beat mechanic), works contacts of varying rarity for points, and upgrades their station. Two meta modes: **Story** (cozy, endless) and **Tournament** (fixed rounds). Art is programmatic 1-bit. See `specs/roadmap.md` for the full M0–M10 feature roadmap.

## Build & run

```bash
./build.sh           # compiles Source/ → DXer.pdx via pdc, then opens the Simulator
```

`build.sh` honors `PLAYDATE_SDK_PATH` (defaults to `~/Developer/PlaydateSDK`). There is no separate compile step — `pdc Source DXer.pdx` both compiles and bundles. `DXer.pdx/` is a build artifact and is gitignored. There is no test framework or linter in this project.

### Runtime debugging (no GUI test runner)

- `playdate.datastore.write({stage="checkpoint"})` is the primary debugging tool — it works before any imports and persists to `~/Developer/PlaydateSDK/Disk/Data/com.smelsom.dxer/data.json`. When the game crashes silently, drop checkpoints and read that file to find the last stage reached.
- The Simulator opens on a separate macOS Space. To screenshot: `osascript -e 'tell application "Playdate Simulator" to activate'` then `screencapture -R 100,50,900,700 /tmp/out.png`.

#### Driving the Simulator from the terminal (verified workflow)

To reach a specific scene (e.g. a mid-game screen) you must feed it input. What works:

- **Send button presses by clicking the Simulator's on-screen controls — not the keyboard.** `osascript … keystroke`/`key code` into the Simulator is unreliable: presses often don't register, or they only give the window focus. Synthetic mouse clicks via CoreGraphics are reliable.
- The `Quartz` Python module is **not installed**; call CoreGraphics through `ctypes` instead. Reusable clicker:

  ```python
  import ctypes, ctypes.util, time, subprocess
  cg = ctypes.cdll.LoadLibrary(ctypes.util.find_library('ApplicationServices'))
  class P(ctypes.Structure): _fields_=[('x',ctypes.c_double),('y',ctypes.c_double)]
  cg.CGEventCreateMouseEvent.restype = ctypes.c_void_p
  cg.CGEventCreateMouseEvent.argtypes = [ctypes.c_void_p, ctypes.c_uint32, P, ctypes.c_uint32]
  cg.CGEventPost.argtypes = [ctypes.c_uint32, ctypes.c_void_p]
  subprocess.run(['osascript','-e','tell application "Playdate Simulator" to activate']); time.sleep(1)
  def click(x, y):                       # screen-point coords
      for t in (1, 2):                   # 1=LeftMouseDown, 2=LeftMouseUp
          cg.CGEventPost(0, cg.CGEventCreateMouseEvent(None, t, P(x, y), 0)); time.sleep(0.07)
  ```

- **Always `activate` first, then `time.sleep(~1s)`** before clicking — the window needs focus and the app a moment to settle.
- **Coordinates are screen points.** Screenshot first with `screencapture -R X,Y,W,H`, find the button in the PNG, then map back: `screen_x = X + dx*(W/png_point_width)`, same for y. On this Retina display the PNG pixel size is 2× the point region, so divide by the displayed width, not the pixel width. Button positions shift if the window moves, so re-screenshot after any rebuild rather than reusing old coords.
- **Step one click at a time, screenshotting between each** (title → menu → dialog → scene). Firing a fixed sequence of clicks blindly overshoots — a dialog (e.g. "Overwrite save?") may or may not appear depending on save state, so the click count isn't constant.
- `./build.sh` reopens the Simulator at the title screen, which is the most reliable way to reset to a known state before navigating.

## Playdate Lua conventions (critical — these differ from standard Lua)

- **No `require`.** Playdate Lua has no `package` library. Use `import "path"` (no return value). Every module exports its table as a **global** (`VFO = {}`, not `local VFO = {}`); callers reference the global directly after `main.lua` imports it. Some modules still have a trailing `return X` — harmless, but the global is what's actually used.
- **`main.lua` imports in strict dependency order** (CoreLibs → core no-deps → core with-deps → ui → scenes). Adding a module means adding its `import` at the correct position so its global exists before any consumer runs.
- Sound waveform constants are `kWaveSine`, `kWaveSquare`, `kWaveNoise`, `kWaveSawtooth` — **NOT** `kWaveformSine` (that's the C API). Passing nil to `synth.new()` crashes.
- The system pause menu allows **max 3 items** (currently Sound / Shop / End Session in `main.lua`).

## Architecture

Three layers, all wired together in `main.lua`:

- **`Source/core/`** — pure-logic modules, no rendering. `config` (all tunables — change here, never hardcode), `save` (datastore persistence + merge-on-upgrade), `scene_manager`, `vfo`, `band`, `clock`, `propagation`, `contact_manager`, `equipment`, `tournament`, `contest`, `dxcc`, `callsign`, `awards`, `qsl`, `qrm`, `zero_beat`.
- **`Source/scenes/`** — one table per screen. Each scene is a table with optional `enter()`/`leave()`/`update()` methods and an `init(SceneManager, save, ...)` called once at boot in `main.lua`.
- **`Source/ui/`** — reusable widgets: `panadapter` (scrolling spectrum), `zero_beat_meter`.

### Scene manager

`SceneManager.switch(scene)` defers the transition; `applyPendingSwitch()` (called first in `playdate.update()`) runs `leave()` on the old scene, **`gfx.sprite.removeAll()`** (every scene starts with a clean sprite list), then `enter()` on the new one. `SceneManager.previous()` supports back-navigation (e.g. Shop returns to wherever it was opened from). Scenes navigate by passing the global scene table directly: `_sceneManager.switch(TitleScene)`.

### Save system

`save.load()` on boot merges stored data **over** `DEFAULTS` (one level deep) so new keys appear on upgrade without wiping saves. `save.newStory()` resets only `story` (keeps settings, tutorialSeen, tournament record); `save.hasStoryProgress()` gates the Continue menu item. Call `save.write()` after any state change.

### Core gameplay wiring

- **Propagation gates contacts**: `ContactManager` spawn rate and signal strength derive from `Propagation`; closed bands spawn nothing. `QRM.strengthAt()` degrades the S-meter and the on-tune window in the operate scene.
- **Equipment** affects tuning: `zeroHzModifier` per mode (FM forgiving, CW tight); pileup/DXpedition contacts require 200W+ TX power.
- **Contest mode**: 30% chance per day after day 2, triggered from the solar_report scene.

## Known gaps (from project memory, verify before relying on)

- Launcher art referenced in `pdxinfo` (`Source/images/launcher/`) does not exist yet — `card.png` (350×155), `card~highlight.png`, `icon.png` (32×32), `icon~highlight.png`.
- In-game clock has no gameplay effect — sessions/rounds never auto-end (open design decision).
- GUI runtime verification of the operate HUD and scene navigation is still worth a visual pass on real hardware (Simulator runs 2–3× faster than device).
