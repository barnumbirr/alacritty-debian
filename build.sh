#!/bin/bash

set -eu

IMAGE="debian:bullseye-slim"
TARGET="$(dirname "$0" | xargs realpath)"
VERSION="v0.10.1"

if hash docker; then
    ENGINE="docker"
elif hash podman; then
    ENGINE="podman"
else
    echo "ERROR: A supported container engine was not found!"
    exit 1
fi

while getopts "v:i:e:h" opt
do
    case "$opt" in
        v)
            VERSION="$OPTARG"
            ;;
        i)
            IMAGE="$OPTARG"
            ;;
        e)
            ENGINE="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-i image] [-v version] [-e docker|podman]"
            exit 0
            ;;
        *)
            exit 1
            ;;
    esac
done

main() {
    ${ENGINE} run --rm --name alacritty-build-$$ \
                    --volume "$TARGET:/target" \
                    --workdir /target \
                    --env "VERSION=$VERSION" \
                    --user root "$IMAGE" \
                    sh entrypoint.sh
}

main
