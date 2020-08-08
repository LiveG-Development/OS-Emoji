#!/bin/sh

echo -e "Installing LiveG Emoji...\n"

# Check for URW Gothic L Book
fc-list | grep "URW Gothic L" > /dev/null
RETURN=$?
if [ $RETURN -ne 0 ]; then
    echo "Please install the Circumference font to continue."
    exit 1
fi

# Stop on errors
set -e
# Set XDG_DATA_HOME to default if empty.
if [ -z "$XDG_DATA_HOME" ]; then
    XDG_DATA_HOME=$HOME/.local/share
fi

# Remove font from old directory if exists (temporary backwards compat)
if [ -f $HOME/.fonts/LiveG-Emoji.ttf ]; then
    echo "Removing the font from $HOME/.fonts..."
    rm $HOME/.fonts/LiveG-Emoji.ttf
fi

# Create a user font directory
mkdir -p $XDG_DATA_HOME/fonts
echo "Installing the font in $XDG_DATA_HOME/fonts/..."
cp ../build/LiveG-Emoji.ttf $XDG_DATA_HOME/fonts/

# Create a font config directory
FONTCONFIG=$HOME/.config/fontconfig
mkdir -p $FONTCONFIG/conf.d/
# Check for an existing font config
if [ -f $FONTCONFIG/fonts.conf ];then
    # (temporary backwards compat)
    echo "Existing fonts.conf backed up to fonts.bak"
    cp $FONTCONFIG/fonts.conf $FONTCONFIG/fonts.bak
fi
# Install fonts.conf
cp fontconfig/56-liveg-emoji.conf $FONTCONFIG/conf.d/

echo "Clearing font cache..."
fc-cache -f

echo "Done!"