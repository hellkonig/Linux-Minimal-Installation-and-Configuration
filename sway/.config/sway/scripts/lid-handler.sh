#!/bin/bash
# Lid handler - clean version
# Checks lid state on startup and monitors for changes

LAPTOP_SCREEN="eDP-1"
LID_STATE="/proc/acpi/button/lid/LID0/state"

has_external() {
    local count
    count=$(swaymsg -t get_outputs 2>/dev/null | grep -o '"name": "'"$LAPTOP_SCREEN"'"' | wc -l)
    local total
    total=$(swaymsg -t get_outputs 2>/dev/null | grep -o '"active": true' | wc -l)
    [ "$total" -gt "$count" ]
}

lid_state() {
    grep -oP 'state:\s*\K\w+' "$LID_STATE" 2>/dev/null || echo open
}

handle_close() {
    has_external && swaymsg output "$LAPTOP_SCREEN" disable || systemctl suspend
}

handle_open() {
    swaymsg output "$LAPTOP_SCREEN" enable 2>/dev/null
}

# Simple single-instance check
[ -f /tmp/lid.lock ] && kill $(cat /tmp/lid.lock 2>/dev/null) 2>/dev/null
echo $$ > /tmp/lid.lock
trap "rm /tmp/lid.lock" EXIT

# Wait for sway
sleep 1

# Initial check
state=$(lid_state)
[ "$state" = closed ] && handle_close || handle_open

# Monitor loop
prev="$state"
while :; do
    curr=$(lid_state)
    if [ "$curr" != "$prev" ]; then
        [ "$curr" = closed ] && handle_close || handle_open
        prev="$curr"
    fi
    sleep 0.5
done
