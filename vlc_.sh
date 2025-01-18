#!/bin/bash
sleep 10
while true
do
if pgrep -x "iremoted" >/dev/null
then
true
else
/Users/jore/iremoted > /Users/jore/ir_received &>/dev/null &
fi

n_j=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000));
if [[ $n_j -gt 90 ]]
then
if pgrep -x "VLC" >/dev/null
then
vlc_front=$(osascript -e "tell application \"System Events\" to get name of application processes whose frontmost is true and visible is true");
if [ $vlc_front == "VLC" ]
then
osascript -e 'tell application "System Events"' -e 'set visible of process "Finder" to false' -e 'end tell'
osascript -e 'activate application "System Events"'
fi

fi
fi
sleep 10
done
