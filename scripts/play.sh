#!/bin/bash

if [ "$1" = "angband" ]; then
    /rl-server/start-angband.sh
elif [ "$1" = "crawl" ]; then
    /rl-server/start-crawl.sh
else
    echo "Usage: play.sh [angband|crawl]"
    exit 1
fi