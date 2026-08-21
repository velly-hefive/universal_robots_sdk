#!/bin/bash
# Give URSim a drop box that lives in the repo instead of the container's
# writable layer: one shared folder, reachable from every robot type, for
# passing files in and out of the simulator -- .urp programs, .installation and
# .variables files, URCap .jar files to install from PolyScope's file browser.
#
# It shows up as "sharedspace/" in PolyScope's Load/Save browser and maps to
# ursim_sharedspace/ in the repo, so its contents survive a container rebuild.
#
# Run automatically by postStartCommand in devcontainer.json; safe to re-run.
set -euo pipefail

LINK_NAME=sharedspace
REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SHARED_DIR="$REPO_ROOT/ursim_sharedspace"

mkdir -p "$SHARED_DIR"

# One link per robot model: PolyScope only ever reads programs.$ROBOT_MODEL, so
# linking every model dir keeps the same drop box reachable whichever model the
# simulator boots as. /ursim/programs itself is deliberately left alone --
# start-ursim.sh deletes and recreates that symlink on every boot.
count=0
for model_dir in /ursim/programs.*; do
	[ -d "$model_dir" ] || continue
	ln -sfn "$SHARED_DIR" "$model_dir/$LINK_NAME"
	count=$((count + 1))
done

if [ "$count" -eq 0 ]; then
	echo "warning: no /ursim/programs.* folders found - is this the URSim image?" >&2
	exit 0
fi

echo "Linked $SHARED_DIR into $count URSim program folder(s) as '$LINK_NAME/'"
