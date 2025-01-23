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
#dosomething when menu and volumedown is pressed on the remote within one second (very quick)

elif [[ "$value" == *"$vup"* ]] && [[ "$value" == *"$vdown"* ]]; then
true
#dosomethingelse when menu and volume down is pressed on the remote within one second (very quick)
#here you can add more combinations with more elif

elif [[ "$value" == *"$mnu"* ]] && [[ "$value" == *"$vup"* ]]; then
#if menu and volume up is pressed on the remote within one second (very quick) and the VLC is running it closes the VLC and opens VLC with playlist
if pgrep -x "VLC" >/dev/null
then
killall -9 "VLC"
sleep 2
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/username/Movies/TV/TV_eng.xspf
sleep 4
osascript -e 'activate application "System Events"';
echo "" > '/Users/username/ir_received';
fi
#when menu and playpause buttons on the remote are pressed within one second (very quick), the computer shutdown is executed
elif [[ "$value" == *"$mnu"* ]] && [[ "$value" == *"$playpause"* ]]; then
osascript -e 'tell app "System Events" to shut down';

else
#when upper combinations are not pressed it checks for single button press and if VLC is running
#the menu button toggles the Shuffle On/Off
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
#in case we have USB external sound card we send the volume up down commands to VLC when the VLC is not focused application.
esac
else
num=$(awk '{n+=gsub("0x18", "&")}END{print n}' <<<"$value")
#here it checks if the button was pressed more than 4 times and if VLC is not open it opens a playlist
if [[ $num -gt 4 ]]; then
open -a /Applications/VLC.app/Contents/MacOS/VLC /Users/username/Music/radio.xspf
sleep 2
osascript -e 'activate application "System Events"';
echo "" > '/Users/username/ir_received';
fi

fi


fi
#here the ir_received file is cleared the empty string is written into the file if the file contains the codes received by iremoted deamon
if [[ "$value" -eq "" ]]; then
true
else echo "" > '/Users/username/ir_received';
fi
sleep 1
done
