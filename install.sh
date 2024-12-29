#!/bin/bash

# Look for anchrcrypt.py in the current directory
ANCHRCRYPT_PATH="./anchrcrypt.py"

if [ ! -f "$ANCHRCRYPT_PATH" ]; then
    echo "Error: anchrcrypt.py not found in the current directory. Please ensure it's here."
    exit 1
fi

# Make the file executable
chmod +x "$ANCHRCRYPT_PATH"

# Define the destination directory (e.g., /usr/local/bin)
DEST_DIR="/usr/local/bin"

# Create a wrapper script to run the Python file as a command
WRAPPER="$DEST_DIR/anchrcrypt"
echo "#!/bin/bash" > "$WRAPPER"
echo "python3 $(realpath $ANCHRCRYPT_PATH) \"\$@\"" >> "$WRAPPER"
chmod +x "$WRAPPER"

# Check if $DEST_DIR is in the PATH and add it if necessary
if [[ ":$PATH:" != *":$DEST_DIR:"* ]]; then
    echo "export PATH=\$PATH:$DEST_DIR" >> ~/.bashrc
    source ~/.bashrc
fi

echo "Setup complete. You can now run 'anchrcrypt' from anywhere."
