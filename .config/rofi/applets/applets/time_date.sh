#!/usr/bin/env bash

# Documentation: https://github.com/davatorium/rofi/wiki
# Config created by Aditya Shakya https://github.com/adi1090x
# Config modified by Carmoruda https://www.github.com/carmoruda/dotfiles
# Copyright (C) 2022 Carmoruda, Aditya Shakya

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/time.rasi"

## Get time and date
TIME="$(date +"%OH:%M %p")"
DN=$(date +"%A")
MN=$(date +"%B")
DAY="$(date +"%d")"
MONTH="$(date +"%m")"
YEAR="$(date +"%Y")"

options="$DAY\n$MONTH\n$YEAR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "${DN[@]^}, $TIME" -dmenu -selected-row 1)"
