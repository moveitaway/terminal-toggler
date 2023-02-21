#!/usr/bin/env bash

PID=$(ps axu | grep terminal | grep server | grep -v grep | awk '{ print $2 }')
if [ "$PID" = "" ]
then
    gnome-terminal &
    exit
else
    WINDOW=$(xdotool search --onlyvisible --pid $PID | tail -1)
    if [ "$WINDOW" != "" ]
    then
        if xprop -id $WINDOW | grep "window state: Normal"; then
            if xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) _NET_WM_PID | grep $PID; then
                xdotool windowminimize $WINDOW
            else 
                xdotool windowactivate $WINDOW && xdotool windowfocus $WINDOW
            fi
        else
            xdotool windowactivate $WINDOW
        fi
    else
        echo "Terminal not found"
    fi
fi
