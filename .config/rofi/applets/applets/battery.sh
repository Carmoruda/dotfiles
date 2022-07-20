#!/usr/bin/env bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/battery.rasi"
battery_path="/sys/class/power_supply/BAT1"

## Get data
BATTERY="$(cat /sys/class/power_supply/BAT1/capacity)"
STATUS="$(cat /sys/class/power_supply/BAT1/status)"

active=""
urgent=""

if [[ $STATUS = *"Charging"* ]]; then
    ICON_CHRG=""
    MSG=$BATTERY
elif [[ $STATUS = *"Full"* ]]; then
    ICON_CHRG=""
    MSG=$BATTERY
else
    ICON_CHRG=" ﮤ "
    MSG=$CHARGE
fi

# Discharging
#if [[ $CHARGE -eq 1 ]] && [[ $STATUS -eq 100 ]]; then
#    ICON_DISCHRG=""
if [[ $BATTERY -ge 5 ]] && [[ $BATTERY -le 19 ]]; then
    ICON_DISCHRG=""
elif [[ $BATTERY -ge 20 ]] && [[ $BATTERY -le 39 ]]; then
    ICON_DISCHRG=""
elif [[ $BATTERY -ge 40 ]] && [[ $BATTERY -le 59 ]]; then
    ICON_DISCHRG=""
elif [[ $BATTERY -ge 60 ]] && [[ $BATTERY -le 79 ]]; then
    ICON_DISCHRG=""
elif [[ $BATTERY -ge 80 ]] && [[ $BATTERY -le 99 ]]; then
    ICON_DISCHRG=""
elif [[ $BATTERY -ge 100 ]]; then
    ICON_DISCHRG=""
fi

## Icons
ICON_PMGR=""

options="$ICON_DISCHRG\n$ICON_CHRG\n$ICON_PMGR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BATTERY%" -dmenu $active $urgent -selected-row 0)"
case $chosen in
    $ICON_CHRG)
        ;;
    $ICON_DISCHRG)
        ;;
    $ICON_PMGR)
        xfce4-power-manager-settings
        ;;
esac

