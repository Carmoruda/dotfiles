#!/usr/bin/env bash

# Documentation: https://github.com/davatorium/rofi/wiki
# Config created by Aditya Shakya https://github.com/adi1090x
# Config modified by Carmoruda https://www.github.com/carmoruda/dotfiles
# Copyright (C) 2022 Carmoruda, Aditya Shakya

# style_1     style_2     style_3     style_4     style_5     style_6     style_7     style_custom

theme="style_custom"

dir="$HOME/.config/rofi/launchers"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

# comment this line to disable random colors
# sed -i -e "s/@import .*/@import \"$color\"/g" $dir/styles/colors.rasi

# comment these lines to disable random style
# themes=($(ls -p --hide="launcher.sh" --hide="styles" $dir))
# theme="${themes[$(( $RANDOM % 7 ))]}"

rofi -no-lazy-grab -show drun \
-modi run,drun,window \
-theme $dir/"$theme"

