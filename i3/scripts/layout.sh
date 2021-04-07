#!/bin/sh
if xrandr | grep -q 'HDMI-1 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal
elif xrandr | grep -q 'HDMI-2 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-2 --off --output HDMI-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal
else
	echo "We do nothing"
fi
exit 0
