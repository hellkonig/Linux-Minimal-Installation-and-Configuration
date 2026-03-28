#!/bin/bash
# Choose external monitor and set scale via wofi

LAPTOP="eDP-1"
DEFAULT_SCALE=1.5

get_external() {
    swaymsg -t get_outputs 2>/dev/null | grep -oP '"name":\s*"\K[^"]+' | grep -v "^${LAPTOP}$"
}

get_monitor_info() {
    local name=$1
    swaymsg -t get_outputs 2>/dev/null | python3 -c "
import sys, json
for o in json.load(sys.stdin):
    if o['name'] == '$name':
        print(f\"{o['scale']}|{o['rect']['x']}|{o['current_mode']['width']}\")
"
}

get_laptop_pos() {
    swaymsg -t get_outputs 2>/dev/null | python3 -c "
import sys, json
for o in json.load(sys.stdin):
    if o['name'] == '$LAPTOP':
        print(o['rect']['x'])
"
}

externals=($(get_external))
count=${#externals[@]}

if [ "$count" -eq 0 ]; then
    notify-send "Monitor" "No external monitor" 2>/dev/null
    exit 0
fi

if [ "$count" -eq 1 ]; then
    selected="${externals[0]}"
else
    selected=$(printf '%s\n' "${externals[@]}" | wofi --dmenu --prompt "Select monitor:")
    [ -z "$selected" ] && exit 0
fi

choice=$(echo -e "Default (1.5)\nScale 1 (Crisp)" | wofi --dmenu --prompt "Scale for $selected:")
[ -z "$choice" ] && exit 0

case "$choice" in
    "Default (1.5)")
        # Get external monitor info before changing
        IFS='|' read -r ext_scale ext_x ext_width <<< "$(get_monitor_info "$selected")"
        ext_logical=$(( ext_width / ext_scale ))
        
        swaymsg output "$selected" scale "$DEFAULT_SCALE"
        
        # Calculate new laptop position
        new_ext_logical=$(( ext_width / DEFAULT_SCALE ))
        new_laptop_x=$new_ext_logical
        swaymsg output "$LAPTOP" position "$new_laptop_x" 0
        
        notify-send "Monitor" "$selected: scale $DEFAULT_SCALE, laptop at $new_laptop_x" 2>/dev/null
        ;;
    "Scale 1 (Crisp)")
        # Get external monitor info before changing
        IFS='|' read -r ext_scale ext_x ext_width <<< "$(get_monitor_info "$selected")"
        
        swaymsg output "$selected" scale 1
        
        # Laptop goes to the right of external monitor
        new_laptop_x=$ext_width
        swaymsg output "$LAPTOP" position "$new_laptop_x" 0
        
        notify-send "Monitor" "$selected: scale 1, laptop at $new_laptop_x" 2>/dev/null
        ;;
esac
