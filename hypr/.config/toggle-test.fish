#!/usr/bin/env fish

# Replace with the actual name of your touchpad device
# You can find this name by running: hyprctl devices
set TOUCHPAD_NAME "ftcs1000:00-2808:0105-touchpad"

# Define a file to store the touchpad state
# We create a filename based on the device name to avoid conflicts if you have multiple touchpads
# Corrected command substitution for filename generation
set STATE_FILE "/tmp/hyprland_touchpad_"(echo "$TOUCHPAD_NAME" | string replace -a ":" "_" | string replace -a "/" "_" | string replace -a "-" "_")".state"

# Default state if the state file doesn't exist
set DEFAULT_STATE "enabled"

set new_state ""
set current_state ""

# Read the current state from the state file
if test -f "$STATE_FILE"
    # Read the content and trim any whitespace
    set current_state (cat "$STATE_FILE" | string trim)
    # If the file is empty or contains unexpected content, use the default state
    if test "$current_state" != "enabled"; and test "$current_state" != "disabled"
        set current_state "$DEFAULT_STATE"
    end
else
    # If the file doesn't exist, use the default state
    set current_state "$DEFAULT_STATE"
end

# Determine the new state and the command to execute
if test "$current_state" = "enabled"
    # Touchpad is currently enabled according to our state file, so disable it
    set new_state "disabled"
    hyprctl keyword device["$TOUCHPAD_NAME"]:enabled false
    notify-send "Touchpad Disabled" "Your touchpad has been disabled."
else
    # Touchpad is currently disabled according to our state file, so enable it
    set new_state "enabled"
    hyprctl keyword device["$TOUCHPAD_NAME"]:enabled true
    notify-send "Touchpad Enabled" "Your touchpad has been enabled."
end

# Save the new state to the state file
echo "$new_state" > "$STATE_FILE"

# Optional: Print states for debugging (you can remove these lines once it works)
# echo "Current state (from file): $current_state"
# echo "New state (written to file): $new_state"
