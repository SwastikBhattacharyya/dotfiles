#!/bin/bash

WALLPAPERS_DIR=~/.wallpapers/
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER" --transition-step 80 --transition-fps 30 --transition-type random
