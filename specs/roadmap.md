# DXer — Product Roadmap

A cozy ham-radio DXing game for Playdate. The player tunes their radio (with the crank),
works contacts of varying rarity for points, and upgrades their station from a cheap 2m
handheld to a flagship 1500W base station on a mountain. Two meta modes — **Story** (cozy,
endless) and **Tournament** (fixed rounds, survival).

This document is the **prioritized feature roadmap**, ordered beginning → end. Each
milestone is a shippable, runnable increment. Confirmed pillars: **zero-beat crank
tuning**, **full game scope**, **Story mode first**, **programmatic 1-bit art**. Toolchain
ready: SDK 3.0.6, `pdc`, Simulator at `~/Developer/PlaydateSDK/bin/Playdate Simulator.app`.

Legend: **[P0]** must-have for the milestone · **[P1]** strongly wanted · **[P2]** nice-to-have/stretch.

---

## M0 — Foundation (skeleton that runs)
*Goal: an empty but launchable game with navigation and persistence plumbing.*
- **[P0]** Project scaffold from the lua-starter; `pdxinfo` (name=DXer, bundleID, buildNumber).
- **[P0]** `build.sh`: `pdc Source DXer.pdx` then open in the Simulator.
- **[P0]** Scene/state manager (enter/leave, sprite cleanup) + global 30fps update loop.
- **[P0]** Title screen: New Game / Continue / mode select placeholder.
- **[P0]** Save/load plumbing via `playdate.datastore` (read on boot, write on change).
- **[P1]** System pause-menu hooks (`getSystemMenu`) — sound toggle stub.
- **[P1]** Global config/constants module for all tunables.

## M1 — Core tuning loop (the "is it fun?" slice)
*Goal: one band, tune with the crank, hear zero-beat, log a contact. Proves the core.*
- **[P0]** Panadapter/spectrum widget: scrolling 1-bit band view with signal blips + fixed VFO cursor.
- **[P0]** Crank → VFO tuning; coarse sweep + fine-tune (hold B); large frequency readout.
- **[P0]** Zero-beat audio: synth tone whose pitch tracks offset from a signal's center.
- **[P0]** Tuning/zero-beat meter (visual) so it's playable muted.
- **[P0]** On-tune detection + **A** to call/log a single static contact.
- **[P0]** D-pad tuning fallback when crank is docked + `ui.crankIndicator`.
- **[P1]** Band-noise floor synth (hiss) under the signal for atmosphere.
- **[P1]** "QSO complete" feedback (chime + brief flash/animation).

## M2 — Contacts & scoring
*Goal: a live band full of varied contacts that score points.*
- **[P0]** Contact system: spawn/despawn, lifetimes, occupied frequencies.
- **[P0]** Call sign generator + DXCC entity/prefix table with rarity weights.
- **[P0]** Rarity tiers (Common / Uncommon / Rare DX / DXpedition) → difficulty + point values.
- **[P0]** S-meter: received signal strength per contact.
- **[P0]** Scoring + running session score.
- **[P0]** Logbook scene: contacts worked this session (call, entity, band, points, time).
- **[P1]** Signal **fading** (QSB) for rare/weak DX — window comes and goes.
- **[P1]** Duplicate detection ("dupe" — already worked) with reduced/zero points.
- **[P2]** Signal report exchange (RST) flavor on logging.

## M3 — Bands, propagation & day/night
*Goal: a living spectrum that changes with conditions and time.*
- **[P0]** Multiple bands (160/80/40/20/15/10m HF + 6m/2m VHF) with Up/Down band switching.
- **[P0]** Day/night clock per round; round = a session of in-game time.
- **[P0]** Propagation model: per-band condition (closed/poor/good/open) varying day vs night.
- **[P0]** Solar report scene at start of round (flux/conditions, which bands favor day/night).
- **[P0]** Gradual spawn/despawn across dawn/dusk on opening/closing bands.
- **[P1]** Band-condition indicators in the HUD (which bands are hot now).
- **[P2]** Greyline/long-path bonus windows; sporadic-E openings on 6m/10m.
- **[P2]** Solar events (flare blackout / aurora) that shake up a day's conditions.

## M4 — Station & equipment
*Goal: the gear you operate, and what it lets you do.*
- **[P0]** Equipment model: Radio, Antenna(s), Mic/Key, Amplifier, Location/Tower with stats.
- **[P0]** Capability gating: which **bands**, **modes**, **TX power**, **filter/tolerance**, noise floor.
- **[P0]** Start the player on a low-cost **2m HT** (VHF/local only).
- **[P0]** Operating modes: SSB / CW / FM (mode selector; gear-gated).
- **[P0]** Antenna switcher (Left/Right) — different gain/bands per antenna.
- **[P1]** CW: sharper zero-beat + higher points; FM: on-channel, no zero-beat (VHF).
- **[P1]** TX power matters: weak DX / pileups need power (amp) to be heard.
- **[P2]** Directional beam antenna with **crank-rotated** heading for gain toward a region.
- **[P2]** Antenna tuner / SWR mini-consideration for off-band-edge operation.

## M5 — Economy, shop & visible progression
*Goal: earn, spend, and see your station grow.*
- **[P0]** Cash/economy: convert score → spendable currency.
- **[P0]** Shop scene with reusable list menu; buy + equip flow.
- **[P0]** Upgrade catalog: full tier ladder (2m HT → mobile HF → base → **flagship 1500W + mast on a mountain**).
- **[P1]** Visible station/shack art tiers that evolve as you upgrade (cozy payoff).
- **[P1]** Sell/replace gear; equipped-vs-owned inventory.
- **[P2]** "QTH move" upgrades (apartment → house → mountain) lowering noise / boosting all.

## M6 — Story mode (primary)
*Goal: the cozy endless loop with persistence and long-term goals.*
- **[P0]** Daily loop: solar report → operate the day → logbook → shop → next day.
- **[P0]** Round-result/summary screen (contacts, points, new bests).
- **[P0]** Full per-mode save persistence (station, cash, day #, logbook, settings).
- **[P1]** Multiple save slots / "operators".
- **[P1]** Awards/achievements: DXCC count, Worked All States/Continents, milestones.
- **[P2]** Cumulative logbook stats & a simple world map of entities worked.
- **[P2]** Cozy flavor: shack ambiance, "Elmer" mentor tips, seasonal vibes.

## M7 — Tournament mode
*Goal: the strategic, high-stakes survival mode.*
- **[P0]** Fixed N rounds with **rising score thresholds**; miss → elimination.
- **[P0]** Higher rare/high-value contact odds; aggressive shop spending between rounds.
- **[P0]** Game-over (elimination) and victory screens.
- **[P1]** Local high-score / best-run leaderboard via datastore.
- **[P2]** Difficulty settings (rounds count, threshold curve).
- **[P2]** Special tournament conditions per round (band-limited, mode-limited).

## M8 — Contests & competitions
*Goal: sporadic bursts of action for bonus rewards.*
- **[P0]** Sporadic contest events (random between Story days): timed burst of easy contacts.
- **[P0]** Contest scoring (rapid QSOs, run rate, time bonus) feeding cash.
- **[P1]** Contest exchange flavor (serial number / grid square).
- **[P1]** Contest calendar so players can plan/anticipate.
- **[P2]** Pileup mechanic for DXpeditions — compete to be heard (power + timing + persistence).
- **[P2]** Split-frequency operation (listen up) for working pileups.

## M9 — Depth & collectibles (replay/flavor)
*Goal: reasons to keep playing.*
- **[P1]** QSL-card collection: earn/collect cards for notable contacts.
- **[P1]** QRM/interference & noise variety to make tuning skill matter more.
- **[P2]** Rare DXpedition "events" that appear for limited windows (must catch them).
- **[P2]** Daily/weekly challenges or goals.
- **[P2]** Unlockable cosmetics for the shack.

## M10 — Polish, accessibility & release
*Goal: ship-quality feel.*
- **[P0]** Onboarding/tutorial for the tuning mechanic.
- **[P0]** Audio mixing + sfx pass (tuning clicks, QSO chime, cash register, UI).
- **[P0]** Accessibility: crank-docked fallback everywhere, `getReduceFlashing`, visual cues for all audio.
- **[P0]** Launcher assets: card 350×155, icon 32×32 (+ ~highlight), `pdxinfo` finalization.
- **[P1]** Settings: sound volume, crank sensitivity, reset save.
- **[P1]** Performance pass: `drawFPS`, keep spectrum redraw ~30fps, pool objects.
- **[P1]** Optional background music / shack ambiance toggle.
- **[P2]** Packaging for itch.io / Playdate Catalog submission.

---

## Critical path (dependency order)
**M0 → M1 → M2 → M3 → M4 → M5 → M6** delivers a complete, cozy, shippable Story game.
**M7 → M8** add the competitive layers. **M9 → M10** add depth and ship polish.
Each milestone ends with a build that runs in the Simulator (`./build.sh`).

## Verification per milestone
Build with `pdc Source DXer.pdx`, open `DXer.pdx` in the Simulator, and manually exercise
that milestone's loop (tune→log, conditions change with time, buy→equip→effect, save
persists across restart, thresholds enforced). Keep `drawFPS` near 30 and confirm D-pad
fallback works with the crank docked.
