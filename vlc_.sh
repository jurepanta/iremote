#!/bin/bash
sleep 10
while true
do
# every 10 seconds checks if deamon is still running and if for some reason is not running it starts it again
if pgrep -x "iremoted" >/dev/null
then
true
else
/Users/username/iremoted > /Users/username/ir_received &>/dev/null &
fi
# checking for user idletime if user is not present at the computer for 90 seconds it checks if VLC is the application active in front of 
# other applications then activates the System Events as frontmost application so the iremoted deamon can receive IR signal,
# because VLC takes over the remote control and only if we make System Events focused we can use this scripts.
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
