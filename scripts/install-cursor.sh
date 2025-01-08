#!/bin/bash

# Function to print status messages
print_status() {
    echo "===> $1"
}

# Function to handle errors
handle_error() {
    echo "ERROR: $1"
    exit 1
}

# Create temporary directory for download
print_status "Creating temporary directory"
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR" || handle_error "Failed to create/enter temporary directory"

# Download Cursor
print_status "Downloading Cursor AppImage"
wget https://downloader.cursor.sh/linux/appImage/x64 -O cursor.AppImage || handle_error "Failed to download Cursor"

# Make AppImage executable
print_status "Making AppImage executable"
chmod +x cursor.AppImage || handle_error "Failed to make AppImage executable"

# Move to /usr/bin (requires sudo)
print_status "Moving Cursor to /usr/bin (requires sudo)"
sudo mv cursor.AppImage /usr/bin/cursor || handle_error "Failed to move Cursor to /usr/bin"

# Create desktop entry
print_status "Creating desktop entry"
cat << EOF | sudo tee /usr/share/applications/cursor.desktop
[Desktop Entry]
Name=Cursor
Comment=AI-first code editor
Exec=/usr/bin/cursor
Icon=cursor
Type=Application
Categories=Development;TextEditor;
StartupWMClass=Cursor
EOF

# Download icon
print_status "Downloading and installing icon"
wget https://raw.githubusercontent.com/getcursor/cursor/main/icons/cursor.png -O cursor.png || handle_error "Failed to download icon"
sudo mv cursor.png /usr/share/icons/cursor.png || handle_error "Failed to install icon"

# Clean up
print_status "Cleaning up temporary files"
cd || handle_error "Failed to leave temporary directory"
rm -rf "$TEMP_DIR"

print_status "Installation completed successfully!"
print_status "You can now launch Cursor from your application menu or run 'cursor' in terminal"