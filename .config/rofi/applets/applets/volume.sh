#!/usr/bin/env bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/volume.rasi"

## Get Volume
#VOLUME=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@)

active=""
urgent=""

ICON_MUTED=" ﱝ "

if [[ $MUTE == *"Mute: no"* ]]; then
    ICON_MUTED="墳"
    active="-a 1"
else
    urgent="-u 1"
fi

if [[ $MUTE == *"Mute: yes"* ]]; then
    VOLUME="Mute"
else
    VOLUME="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%') %"
fi

## Icons
ICON_UP=" ﱛ "
ICON_DOWN=" ﱜ "

options="$ICON_UP\n$ICON_MUTED\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$VOLUME" -dmenu $active $urgent -selected-row 0)"
case $chosen in
    $ICON_UP)
        amixer -Mq set Master,0 5%+ unmute && notify-send -u low -t 1500 "Volume Up $ICON_UP"
        ;;
    $ICON_DOWN)
        amixer -Mq set Master,0 5%- unmute && notify-send -u low -t 1500 "Volume Down $ICON_DOWN"
        ;;
    $ICON_MUTED)
        amixer -q set Master toggle
        ;;
esac

