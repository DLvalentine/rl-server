#!/bin/bash

if [ "$1" = "angband" ]; then
    /rl-server/start-angband.sh
elif [ "$1" = "crawl" ]; then
    /rl-server/start-crawl.sh
elif [ "$1" = "cataclysm" ]; then
    /rl-server/start-cataclysm.sh
else
    echo "Usage: play.sh [angband|crawl|cataclysm]"
    exit 1
fi