#!/usr/bin/env bash

# Documentation: https://github.com/davatorium/rofi/wiki
# Config created by Aditya Shakya https://github.com/adi1090x
# Config modified by Carmoruda https://www.github.com/carmoruda/dotfiles
# Copyright (C) 2022 Carmoruda, Aditya Shakya

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/backlight.rasi"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

## Get Brightness
BNESS="$(brightnessctl get)"
MAX="$(brightnessctl max)"
PERC="$((BNESS*100/MAX))"
BLIGHT=${PERC%.*}

if [[ $BLIGHT -ge 1 ]] && [[ $BLIGHT -le 29 ]]; then
    MSG="Low"
elif [[ $BLIGHT -ge 30 ]] && [[ $BLIGHT -le 49 ]]; then
    MSG="Optimal"
elif [[ $BLIGHT -ge 50 ]] && [[ $BLIGHT -le 69 ]]; then
    MSG="High"
elif [[ $BLIGHT -ge 70 ]] && [[ $BLIGHT -le 99 ]]; then
    MSG="Too Much"
fi

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_OPT=""

notify="notify-send -u low -t 1500"
options="$ICON_UP\n$ICON_OPT\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BLIGHT%" -dmenu -selected-row 1)"
case $chosen in
    "$ICON_UP")
			brightnessctl -q set +10% && $notify "Brightness Up $ICON_UP"
			;;
    "$ICON_DOWN")
			brightnessctl -q set 10%- && $notify "Brightness Down $ICON_DOWN"
      ;;
    "$ICON_OPT")
			brightnessctl -q set 25% && $notify "Optimal Brightness $ICON_OPT"
      ;;
esac

