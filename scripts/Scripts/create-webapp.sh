#!/usr/bin/env bash

if [[ -z "$TERM" || "$TERM" == "dumb" ]]; then
    exec alacritty -e "$0" "$@"
fi

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== WebApp Desktop Entry Creator ==="

# 1. Gather inputs
read -p "Enter App Name (e.g., WhatsApp): " APP_NAME
read -p "Enter Web URL (e.g., https://web.whatsapp.com): " APP_URL
read -p "Enter Category (e.g., Network;Chat; or Office;): " APP_CAT

# Standardize names for files/domains
LOW_NAME=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
DOMAIN=$(echo "$APP_URL" | awk -F[/:] '{print $4}')

# 2. Define target paths
ICON_DIR="$HOME/.local/share/applications/Icons"
DESKTOP_DIR="$HOME/.local/share/applications"
TARGET_ICON="$ICON_DIR/${APP_NAME}.png"
TARGET_DESKTOP="$DESKTOP_DIR/${APP_NAME}.desktop"

# Ensure directories exist
mkdir -p "$ICON_DIR"

# 3. Fetch and convert the website favicon automatically
echo "Fetching favicon for $DOMAIN..."
FAVICON_URL="https://www.google.com/s2/favicons?domain=${DOMAIN}&sz=128"

if curl -s --head "$FAVICON_URL" | grep "200 OK" > /dev/null; then
    # Download and convert to PNG cleanly using ImageMagick
    curl -s "$FAVICON_URL" -o "/tmp/${LOW_NAME}_tmp"
    magick "/tmp/${LOW_NAME}_tmp" "$TARGET_ICON"
    rm "/tmp/${LOW_NAME}_tmp"
    echo "✓ Icon downloaded and saved to: $TARGET_ICON"
else
    echo "⚠️ Could not fetch high-res icon automatically. Using a fallback browser icon."
    TARGET_ICON="browser"
fi

# 4. Generate the .desktop file
cat <<EOF > "$TARGET_DESKTOP"
[Desktop Entry]
Name=${APP_NAME}
Comment=${APP_NAME} Web App
Exec=brave --app=${APP_URL}
Icon=${TARGET_ICON}
Terminal=false
Type=Application
Categories=${APP_CAT}
StartupWMClass=brave-${DOMAIN}__-Default
EOF

# 5. Make it executable
chmod +x "$TARGET_DESKTOP"

echo "----------------------------------------"
echo "🎉 Success! WebApp created successfully."
echo "Location: $TARGET_DESKTOP"
echo "You can now launch '$APP_NAME' via fuzzel, rofi, or your Hyprland runner!"
echo "----------------------------------------"
