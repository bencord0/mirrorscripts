#!/bin/bash
CURRENT_DIR=$(dirname $0)
BASEURL=rsync://mirrorservice.org/ftp.debian.org/debian/

# Per-release repo metadata by recursive directory
for dir in \
    dists/stable/main/binary-all \
    dists/stable/main/binary-amd64 \
    dists/stable/main/debian-installer/binary-all \
    dists/stable/main/debian-installer/binary-amd64 \
    dists/stable/main/installer-amd64/current \
    dists/stable/main/source/
do
    mkdir -p "${CURRENT_DIR}/$dir"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
        "${BASEURL}$dir/" \
        "${CURRENT_DIR}/$dir"
done

# Per-release repo metadata top level files
for file in \
        dists/stable/ChangeLog \
        dists/stable/Contents-amd64.gz \
        dists/stable/Release \
        dists/stable/Release.gpg
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
