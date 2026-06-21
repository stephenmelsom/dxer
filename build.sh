#!/usr/bin/env bash
set -euo pipefail

PDC="${PLAYDATE_SDK_PATH:-$HOME/Developer/PlaydateSDK}/bin/pdc"
SIM="${PLAYDATE_SDK_PATH:-$HOME/Developer/PlaydateSDK}/bin/Playdate Simulator.app"

echo "▸ Building DXer.pdx …"
"$PDC" Source DXer.pdx

echo "▸ Opening in Simulator …"
open -a "$SIM" DXer.pdx
