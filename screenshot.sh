#!/bin/bash

# DEFAULTS
SCREENSHOTS_FOLDER=~/Dropbox/Public/Screenshots
SCREENSHOT_FILENAME=Screenshot_`date +%Y-%m-%d-%H:%M`.png
GOO_GL_API_KEY=''

if [ -f ~/.screenshotsrc ]; then source ~/.screenshotsrc; fi

if [ -z "$GOO_GL_API_KEY" ]
then
    >&2 echo "ERROR: \$GOO_GL_API_KEY is empty"
    exit 1
fi

DEST_PATH=$SCREENSHOTS_FOLDER/$SCREENSHOT_FILENAME
echo "Distination file is $DEST_PATH"

gnome-screenshot -a -f "$DEST_PATH"
URL=`dropbox sharelink "$DEST_PATH"`
echo "Dropbox URL is $URL"

googl_response=`http -I --body post "https://www.googleapis.com/urlshortener/v1/url?key=$GOO_GL_API_KEY" longUrl="$URL"`
echo "goo.gl responses with $googl_response"
SHORT_URL=`echo $googl_response | jq -r '.id'`
echo "Short URL is $SHORT_URL"

if [ "$WAYLAND_DISPLAY" ]
then
    echo "Wayland detected"
    echo -n "$SHORT_URL" | xsel --clipboard -i
else
    echo "X Window detected "
    echo -n "$SHORT_URL" | xclip -selection clipboard
fi

notify-send 'Screenshot' "Copied $SHORT_URL to clipboard"