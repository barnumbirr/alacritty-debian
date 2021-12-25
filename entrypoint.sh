#!/bin/bash

set -xeu

BRANCH="$VERSION"
DEBIAN_FRONTEND=noninteractive
DEB_BUILD_OPTIONS=parallel=$(nproc)
OS_VERSION=$(sed 's/\..*//' /etc/debian_version)
TARGET="$PWD"

export DEBIAN_FRONTEND DEB_BUILD_OPTIONS

dependencies() {
    apt update && apt install -y devscripts equivs git
    if [ "$OS_VERSION" = 11 ]; then
        apt install -y curl
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        . ~/.cargo/env
    fi
}

get_sources() {
    cd "$(mktemp -d)"
    git clone -b "$BRANCH" https://github.com/alacritty/alacritty.git alacritty
    cd alacritty
}

build() {
    cp -a "$TARGET/debian" .
    yes | mk-build-deps --install
    dpkg-source --before-build .
    debian/rules build
    debian/rules binary
}

copy() {
    TARGET_UID="$(stat --printf %u "$TARGET")"
    TARGET_GID="$(stat --printf %g "$TARGET")"
    install -o "$TARGET_UID" -g "$TARGET_GID" -t "$TARGET/target" ../*.deb
}

main() {
    dependencies
    get_sources
    build
    copy
}

main
