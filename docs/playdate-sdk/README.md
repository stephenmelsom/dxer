# Playdate SDK Documentation (local mirror)

Markdown conversion of the official **Inside Playdate** reference docs, for offline
reference and grepping.

- **Source:** <https://sdk.play.date/3.0.6/>
- **SDK version:** 3.0.6
- **Converted:** 2026-06-20 via `pandoc` (HTML → GFM)

## Contents

| File | Source page | Covers |
|------|-------------|--------|
| [`inside-playdate-lua.md`](inside-playdate-lua.md) | Inside Playdate | The Lua API (what DXer uses) |
| [`inside-playdate-c.md`](inside-playdate-c.md) | Inside Playdate with C | The C API |

## Notes

- Each file opens with a Table of Contents; section anchors (`#_...`) are preserved
  from the original HTML.
- Code blocks are fenced as `lua` / `c` respectively.
- Internal cross-reference links (e.g. `#f-graphics.drawText`) point to anchors that
  exist in the original HTML; they may not resolve perfectly in a plain markdown viewer.
- This is a build/reference artifact regenerated from the upstream HTML; do not edit by hand.
