#!/bin/bash
while true
do
if pgrep -x "VLC" >/dev/null
then
num=$(awk '{n+=gsub("0x18", "&")}END{print n}' /Users/jore/ir_received)
if [[ $num -gt 3 ]]; then
fullscreen=$(osascript -e 'tell application "VLC"
                get fullscreen mode
            end tell')
if [[ $fullscreen == "true" ]]; then
sleep 4
osascript -e 'activate application "VLC"';
#if VLC is running and VLC is in fullscreen mode, and the menu button is pressed multiple times it activates VLC so that VLC takes control if we need to use the original VLC controls for fastforward and so on
else
playing=$(osascript -e 'tell application "VLC"
                get playing
            end tell')
if [[ $playing == "false" ]]; then
#if VLC is not in fullscreen and VLC is stopped or paused, and the menu button was pressed multiple times it closes VLC and starts VLC with another playlist
echo "" > '/Users/jore/ir_received';
killall -9 "VLC"
sleep 2
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/jore/Music/radio.xspf
sleep 2
osascript -e 'activate application "System Events"';
fi
fi

fi


fi
sleep 1
done
