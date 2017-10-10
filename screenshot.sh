#!/bin/bash

GOO_GL_API_KEY="AIzaSyD9jrYh54JDyQefDUFifjYlcSPhYeI-_2U"
filename=$(date "+%F %H:%M:%S.png")
path=~/Dropbox/Apps/Screenshots/$filename
echo "Distination file is $path"

gnome-screenshot -a -f "$path"
URL=`dropbox sharelink "$path"`
echo "Dropbox URL is $URL"

googl_response=`http -I --body post "https://www.googleapis.com/urlshortener/v1/url?key=$GOO_GL_API_KEY" longUrl="$URL"`
echo "goo.gl responses with $googl_response"
SHORT_URL=`echo $googl_response | jq -r '.id'`
echo "Short URL is $SHORT_URL"

echo -n "$SHORT_URL" | xsel --clipboard -i
notify-send 'Screenshot' "URL is copied to clipboard $SHORT_URL"
