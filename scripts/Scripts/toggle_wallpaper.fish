#!/usr/bin/env fish

set wallpaper_dir "$HOME/Pictures/backgrounds/"

set allowed_extensions jpg png jpeg webp

set extensions_pattern (string join \| $allowed_extensions)
set wallpapers (find "$wallpaper_dir" -type f | grep -E "\.($extensions_pattern)\$" | sort | shuf -n1)

if test (count $wallpapers) -eq 0
    echo "No wallpapers found in $wallpaper_dir with extensions: $allowed_extensions"
    exit 1
end

set chosen_wallpaper $wallpapers[1]

set trans_type "outer"
set trans_duration 0.5

if not pgrep -x awww-daemon > /dev/null
    echo "awww-daemon is not running. Starting it..."
    awww-daemon &
    # Give the daemon a moment to start
    sleep 1
end

echo "Setting wallpaper to: $chosen_wallpaper"
awww img "$chosen_wallpaper" --transition-type $trans_type --transition-duration $trans_duration
