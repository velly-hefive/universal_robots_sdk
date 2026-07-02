#!/bin/bash
unset WAYLAND_DISPLAY XDG_SESSION_TYPE # VScode sets these, x11vnc silently exits in entrypoint.sh

# override hostname to write localhost instead of what was configured by base container
hostname() { [ "$1" = "-i" ] && echo "localhost" || command hostname "$@"; }
export -f hostname

cd /
./entrypoint.sh
