#!/bin/bash

# Locate the anchrcrypt.py file
ANCHRCRYPT_PATH=$(find ~ -type f -name "anchrcrypt.py" 2>/dev/null | head -n 1)

if [ -z "$ANCHRCRYPT_PATH" ]; then
    echo "Error: anchrcrypt.py not found. Please ensure it's downloaded."
    exit 1
fi

# Make the file executable
chmod +x "$ANCHRCRYPT_PATH"

# Define the destination directory (e.g., /usr/local/bin)
DEST_DIR="/usr/local/bin"

# Create a wrapper script to run the Python file as a command
WRAPPER="$DEST_DIR/anchrcrypt"
echo "#!/bin/bash" > "$WRAPPER"
echo "python3 $ANCHRCRYPT_PATH \"\$@\"" >> "$WRAPPER"
chmod +x "$WRAPPER"

# Check if $DEST_DIR is in the PATH and add it if necessary
if [[ ":$PATH:" != *":$DEST_DIR:"* ]]; then
    echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
    source ~/.bashrc
fi

echo "Setup complete. You can now run 'anchrcrypt' from anywhere."
