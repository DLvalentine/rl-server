#!/bin/bash

if [ "$1" = "angband" ] || [ "$1" = "a" ]; then
    /rl-server/start-angband.sh
elif [ "$1" = "crawl" ] || [ "$1" = "c" ]; then
    /rl-server/start-crawl.sh
elif [ "$1" = "cataclysm" ] || [ "$1" = "y" ]; then
    /rl-server/start-cataclysm.sh
else
    echo "Usage: play.sh [(a)ngband|(c)rawl|catacl(y)sm]"
    exit 1
fi