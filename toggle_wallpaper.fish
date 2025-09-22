#!/usr/bin/env fish

# Define the directory containing your wallpapers
set wallpaper_dir "$HOME/.backgrounds/" # Your wallpaper directory

# Define the file extensions to look for (add or remove as needed)
# Includes jpg, png, jpeg, webp as per your previous script attempt and the bash script
set allowed_extensions jpg png jpeg webp

# Find all files in the directory with the allowed extensions
# Using find for potentially large directories and robustness
# Escape the $ in the grep pattern so fish passes it correctly
# Use string join to create the regex pattern for grep
set extensions_pattern (string join \| $allowed_extensions)
set wallpapers (find "$wallpaper_dir" -type f | grep -E "\.($extensions_pattern)\$" | sort | shuf -n1)

# Check if a wallpaper was found and selected
if test (count $wallpapers) -eq 0
    echo "No wallpapers found in $wallpaper_dir with extensions: $allowed_extensions"
    exit 1
end

# The 'shuf -n1' already selected a random wallpaper, so we just use the result
set chosen_wallpaper $wallpapers[1]

# Define transition type (can be changed)
set trans_type "simple" # Or "simple", "grow", etc.
set trans_duration 1    # Duration in seconds

# Check if swww is running
if not pgrep -x swww-daemon > /dev/null
    echo "swww-daemon is not running. Starting it..."
    swww init
    # Give the daemon a moment to start
    sleep 1
end

# Set the chosen wallpaper using swww
echo "Setting wallpaper to: $chosen_wallpaper"
swww img "$chosen_wallpaper" --transition-type $trans_type --transition-duration $trans_duration

