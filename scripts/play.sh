#!/bin/bash
clear

if [ "$1" = "angband" ] || [ "$1" = "a" ]; then
    /usr/games/angband -mgcu
elif [ "$1" = "crawl" ] || [ "$1" = "c" ]; then
    /usr/games/crawl
elif [ "$1" = "cataclysm" ] || [ "$1" = "y" ]; then
    /usr/games/cataclysm
elif [ "$1" = "nethack" ] || [ "$1" = "n" ]; then
    /usr/games/nethack
else
    echo "Usage: play [(a)ngband|(c)rawl|catacl(y)sm|(n)ethack]"
    exit 1
fi
