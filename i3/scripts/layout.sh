#!/bin/sh

IMAGE="$HOME/dotfiles/i3/images/copyright_www.danielronnback.com_019.jpg"

if [ "$1" = "-f" ]; then
	# Laptop default configuration
	# In case we are undocking the laptop
	xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1-1 --off --output HDMI-2 --off
	feh --bg-fill "$IMAGE"
	exit 0
elif xrandr | grep -q 'HDMI-1 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal
	feh --bg-fill "$IMAGE"
	exit 0 
elif xrandr | grep -q 'HDMI-1-1 connected'; then
	xrandr --output eDP-1-1 --off --output HDMI-1-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal
elif xrandr | grep -q 'HDMI-2 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-2 --off --output HDMI-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal
	feh --bg-fill "$IMAGE"
	exit 0
elif xrandr | grep -q '^DP-1 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output HDMI-1 --off --output HDMI-2 --off
	feh --bg-fill "$IMAGE"
	exit 0
else
	feh --bg-fill "$IMAGE"
	exit 0
fi

# Auto scale the background image
exit 0
