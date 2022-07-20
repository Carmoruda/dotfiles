#!/usr/bin/env bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/apps.rasi"

# Links
terminal=""
files=""
editor=""
browser=""
music=""
settings=""

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
	$terminal)
		kitty
    ;;
  $files)
		thunar
    ;;
  $editor)
		code
    ;;
  $browser)
		firefox
    ;;
  $music)
		spotify
    ;;
  $settings)
		kitty code ~/.config/i3/config
    ;;
esac

