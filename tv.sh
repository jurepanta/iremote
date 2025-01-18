#!/bin/bash
while true
do
if pgrep -x "VLC" >/dev/null
then
num=$(awk '{n+=gsub("0x18", "&")}END{print n}' /Users/username/ir_received)
if [[ $num -gt 3 ]]; then
fullscreen=$(osascript -e 'tell application "VLC"
                get fullscreen mode
            end tell')
if [[ $fullscreen == "true" ]]; then
sleep 4
osascript -e 'activate application "VLC"';
else
osascript -e 'activate application "VLC"';
osascript -e '
                tell application "System Events" to tell process "VLC"
                keystroke "+" using {command down}
                end tell';
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/username/Music/radio.xspf
osascript -e 'activate application "System Events"';
fi

fi


fi
sleep 1
done
