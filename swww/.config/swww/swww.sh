#!/bin/bash

WALLPAPERS_DIR=~/.wallpapers/
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER" --transition-step 5 --transition-fps 250 --transition-type random
