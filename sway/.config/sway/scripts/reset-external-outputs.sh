#!/bin/bash
# Reset all external monitors after resume

swaymsg -t get_outputs | grep -oP '"name": "\K[^"]+' | grep -v -E '^(eDP|Virtual)' | while read -r output; do
    swaymsg output "$output" disable
    swaymsg output "$output" enable
done
