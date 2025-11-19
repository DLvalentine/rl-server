#!/bin/bash

if [ "$1" = "angband" ] || [ "$1" = "a" ]; then
    /usr/games/angband -mgcu
elif [ "$1" = "crawl" ] || [ "$1" = "c" ]; then
    /usr/games/crawl
elif [ "$1" = "cataclysm" ] || [ "$1" = "y" ]; then
    /usr/games/cataclysm
else
    echo "Usage: play [(a)ngband|(c)rawl|catacl(y)sm]"
    exit 1
fi