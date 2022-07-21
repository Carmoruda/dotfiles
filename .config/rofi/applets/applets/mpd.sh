#!/usr/bin/env bash

# Documentation: https://github.com/davatorium/rofi/wiki
# Config created by Aditya Shakya https://github.com/adi1090x
# Config modified by Carmoruda https://www.github.com/carmoruda/dotfiles
# Copyright (C) 2022 Carmoruda, Aditya Shakya

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/mpd.rasi"

# Gets the current status of playerctl (for us to parse it later on)
playing_status="$(playerctl status)"
loop_status="$(playerctl loop)"
shuffle_status="$(playerctl shuffle)"

# Defines the Play / Pause option content
if [[ $playing_status == *"Playing"* ]]; then
    play_pause=""
else
    play_pause=""
fi
active=""
urgent=""

# Display if loop mode is on / off
tog_loop=""
if [[ $loop_status == *"Playlist"* ]]; then
    loop_toggle="Track"
    tog_loop="凌"
    active="-a 4"
elif [[ $loop_status == *"Track"* ]]; then
    loop_toggle="None"
    tog_loop="綾"
    active="-a 4"
elif [[ $loop_status == *"None"* ]]; then
    loop_toggle="Playlist"
    tog_loop="稜"
    urgent="-u 4"
else
    tog_loop="稜"
fi

# Display if shuffle mode is on / off
tog_shuffle="咽"
if [[ $shuffle_status == *"On"* ]]; then
    shuffle_toggle="Off"
    [ -n "$active" ] && active+=",5" || active="-a 5"

elif [[ $shuffle_status == *"Off"* ]]; then
    shuffle_toggle="On"
    tog_shuffle="劣"
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    tog_shuffle="劣"
fi
stop=""
next=""
previous=""


# Variable passed to rofi
options="$previous\n$play_pause\n$stop\n$next\n$tog_loop\n$tog_shuffle"

# Get the current playing song
current=$(playerctl metadata title)
# If playerctl isn't running it will return an empty string, we don't want to display that
if [[ -z "$current" ]]; then
    current="-"
fi

# Spawn the playerctl menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "  $current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $previous)
        playerctl previous && notify-send -u low -t 1800 " Previous track "
        ;;
    $play_pause)
        playerctl play-pause && notify-send -u low -t 1800 " $(playerctl metadata title) by $(playerctl metadata artist)"
        ;;
    $stop)
        playerctl stop
        ;;
    $next)
        playerctl next && notify-send -u low -t 1800 " Next track "
        ;;
    $tog_loop)
        playerctl loop $loop_toggle && notify-send -u low -t 1800 " Loop set to: $loop_toggle " " $(playerctl metadata title) by $(playerctl metadata artist)"
        ;;
    $tog_shuffle)
        playerctl shuffle $shuffle_toggle && notify-send -u low -t 1800 " Shuffle $shuffle_toggle " " $(playerctl metadata title) by $(playerctl metadata artist)"
        ;;
esac
