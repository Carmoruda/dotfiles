#!/usr/bin/env bash

# Documentation: https://github.com/davatorium/rofi/wiki
# Config created by Aditya Shakya https://github.com/adi1090x
# Config modified by Carmoruda https://www.github.com/carmoruda/dotfiles
# Copyright (C) 2022 Carmoruda, Aditya Shakya

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/quicklinks.rasi"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Browser
app="firefox"

# Links
duckduckgo=""
twitch="既"
twitter="暑"
github=""
reddit="樓"
youtube="輸"

# Search
search_duckduckgo() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Search : "\
		-theme $HOME/.config/rofi/applets/styles/confirm.rasi
}

# Variable passed to rofi
options="$duckduckgo\n$youtube\n$twitch\n$twitter\n$github\n$reddit"

chosen="$(echo -e "$options" | $rofi_command -p "Open In  :  $app" -dmenu -selected-row 0)"
case $chosen in
    $duckduckgo)
        ans=$(search_duckduckgo)
        $app "https://www.duckduckgo.com/?q=$ans" &
        ;;
    $twitch)
        $app https://www.twitch.com &
        ;;
    $twitter)
        $app https://www.twitter.com &
        ;;
    $github)
        $app https://www.github.com &
        ;;
    $reddit)
        $app https://www.reddit.com &
        ;;
    $youtube)
        $app https://www.youtube.com &
        ;;
esac

