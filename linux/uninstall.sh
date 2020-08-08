#!/bin/sh

echo "Uninstalling LiveG Emoji...\n"

set -v

# Set XDG_DATA_HOME to default if empty.
if [ -z "$XDG_DATA_HOME" ]; then
    XDG_DATA_HOME=$HOME/.local/share
fi

FONTCONFIG=$HOME/.config/fontconfig

rm $XDG_DATA_HOME/fonts/LiveG-Emoji.ttf
rm $FONTCONFIG/conf.d/56-liveg-emoji.conf

echo "Clearing font cache..."
fc-cache -f

echo "Done!"