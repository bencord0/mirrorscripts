#!/bin/bash
CURRENT_DIR=$(dirname $0)
BASEURL=rsync://archive.ubuntu.com/ubuntu/

# Per-release repo metadata by recursive directory
for dir in \
    dists/trusty/main/binary-amd64 \
    dists/trusty/main/debian-installer/binary-amd64 \
    dists/trusty/main/installer-amd64/current \
    dists/trusty/main/source/
do
    mkdir -p "${CURRENT_DIR}/$dir"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
        "${BASEURL}$dir/" \
        "${CURRENT_DIR}/$dir"
done

# Per-release repo metadata top level files
for file in \
        dists/trusty/Contents-amd64.gz \
        dists/trusty/Release \
        dists/trusty/Release.gpg
do
    mkdir -p "${CURRENT_DIR}/$(dirname $file)"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
        "${BASEURL}$file" \
        "${CURRENT_DIR}/$file"
done

# Release agnostic pool of amd64 binary debs
mkdir -p "${CURRENT_DIR}/pool/main"
rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
    --include '*_amd64.deb' --include '*/' --exclude '*' \
    "${BASEURL}pool/main/" "${CURRENT_DIR}/pool/main"
