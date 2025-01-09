#!/bin/bash
if hyprctl monitors | grep -q "HDMI-A-1"; then
    hyprctl keyword monitor "eDP-1,disable"
    hyprctl keyword monitor "HDMI-A-1,1920x1080@60,0x0,1"
else
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
fi
