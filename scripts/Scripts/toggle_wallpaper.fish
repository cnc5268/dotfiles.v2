#!/usr/bin/env fish

set wallpaper_dir "$HOME/Pictures/backgrounds/"
set state_file "/tmp/current_wallpaper_index"

set wallpapers (
    fd -d 1 -t f \
        -e jpg \
        -e jpeg \
        -e png \
        -e webp \
        -e gif \
        . "$wallpaper_dir" | sort
)
set count (count $wallpapers)

if not test -f $state_file
    echo 1 > $state_file
end

set index (cat $state_file)

# Wrap around when reaching the end
if test $index -gt $count
    set index 1
end

set chosen_wallpaper $wallpapers[$index]

# Save next index for next run
math "$index + 1" > $state_file

set trans_type "fade"
set trans_duration 0.5

awww img "$chosen_wallpaper" \
    --transition-type $trans_type \
    --transition-duration $trans_duration
