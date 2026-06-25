#!/usr/bin/env bash

choice=$(printf "⏻ Shutdown\n↻ Reboot\n⎋ Logout\n Lock" | fuzzel --dmenu --prompt="Power: ")

case "$choice" in
    "⏻ Shutdown") systemctl poweroff ;;
    "↻ Reboot") systemctl reboot ;;
    "⎋ Logout") hyprctl dispatch exit ;;
    " Lock") hyprlock ;;
esac
