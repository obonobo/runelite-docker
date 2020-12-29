#!/bin/bash

build-container() {
    docker build -t runelite:latest .
    docker image prune -f
}

run-container() {
    docker container rm -f runelite
    docker run --name runelite \
               --env DISPLAY \
               --network host \
               --mount type=bind,source=${HOME}/.Xauthority,target=/root/.Xauthority \
               runelite:latest
}

r() {
    build-container
    run-container
}

[[ ${BASH_SOURCE[0]} == $0 ]] && r $@
