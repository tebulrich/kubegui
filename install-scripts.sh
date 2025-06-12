#!/bin/bash

# This script must be run as a normal user with sudo, e.g.:
# sudo ./install-scripts.sh

#########################
# Helper Functions
#########################

# Print a log message with a consistent format.
log() {
  echo "=> $1"
}

# Exit with an error message.
error_exit() {
  echo "Error: $1"
  exit 1
}

#########################
# Preconditions
#########################

# Ensure the script is run with root privileges.
if [[ $EUID -ne 0 ]]; then
  error_exit "This script must be run as sudo. Example: sudo ./install-scripts.sh"
fi

# Ensure that the script was invoked using sudo (SUDO_USER must be set).
if [[ -z "$SUDO_USER" ]]; then
  error_exit "This script must be run using sudo, not directly as root."
fi

#########################
# Main Script Logic
#########################

# Determine the repository root directory (the directory where this script is located)
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
log "Repository directory: $REPO_DIR"

# Update the repository using the non-root user's credentials.
log "Updating repository from remote as $SUDO_USER..."
sudo -u "$SUDO_USER" git -C "$REPO_DIR" pull || error_exit "Failed to update repository."

# Define the scripts and destination directories.
SCRIPTS_DIR="$REPO_DIR/scripts"
DEST_DIR="/usr/local/bin"

# Verify that the scripts folder exists.
if [[ ! -d "$SCRIPTS_DIR" ]]; then
  error_exit "The 'scripts' folder does not exist in the repository."
fi

# Iterate over all files in the scripts folder and install them.
for file in "$SCRIPTS_DIR"/*; do
  if [[ -f "$file" ]]; then
    BASENAME=$(basename "$file")
    cp "$file" "$DEST_DIR/" && chmod +x "$DEST_DIR/$BASENAME" || error_exit "Failed to install $BASENAME"
    log "Installed $BASENAME to $DEST_DIR"
  fi
done

log "All shell scripts from the 'scripts' folder have been successfully installed to $DEST_DIR."
