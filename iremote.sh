#!/bin/bash
mnu="0x18";
vup="0x21";
vdown="0x22";
playpause="0x19";
while true
do
value=`cat /Users/username/ir_received`;

if [[ "$value" == *"$mnu"* ]] && [[ "$value" == *"$vdown"* ]]; then
true
#dosomething

elif [[ "$value" == *"$vup"* ]] && [[ "$value" == *"$vdown"* ]]; then
true
#dosomethingelse

elif [[ "$value" == *"$mnu"* ]] && [[ "$value" == *"$vup"* ]]; then
if pgrep -x "VLC" >/dev/null
then
killall -9 "VLC"
sleep 2
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/username/Movies/TV/TV_eng.xspf
sleep 4
osascript -e 'activate application "System Events"';
echo "" > '/Users/username/ir_received';
fi

elif [[ "$value" == *"$mnu"* ]] && [[ "$value" == *"$playpause"* ]]; then
osascript -e 'tell app "System Events" to shut down';

else
num=$(awk '{n+=gsub("0x18", "&")}END{print n}' <<<"$value")
if pgrep -x "VLC" >/dev/null
then
case "$value" in
        *"$mnu"*)
          osascript -e 'activate application "VLC"';
          osascript -e '
                tell application "System Events" to tell process "VLC"
                keystroke "z" using {command down}
                end tell';
          osascript -e 'activate application "System Events"';;
      *"$vup"*) osascript -e 'tell app "VLC" to volumeUp';;
      *"$vdown"*) osascript -e 'tell app "VLC" to volumeDown';;
*);;
esac
else
if [[ $num -gt 4 ]]; then
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/username/Music/radio.xspf
sleep 2
osascript -e 'activate application "System Events"';
echo "" > '/Users/username/ir_received';
fi

fi


fi

if [[ "$value" -eq "" ]]; then
true
else echo "" > '/Users/username/ir_received';
fi
sleep 1
done
