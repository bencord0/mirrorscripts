#!/bin/bash
CURRENT_DIR=$(dirname $0)
BASEURL=rsync://mirror.bytemark.co.uk/archlinux/

# Install media directories
for dir in \
    iso/latest/arch/x86_64 \
    iso/latest/arch/boot/x86_64
do
    mkdir -p "${CURRENT_DIR}/$dir"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
         "${BASEURL}$dir/" \
    "${CURRENT_DIR}/$dir"
done

# Install media files
for file in \
    iso/latest/arch/aitab \
    iso/latest/arch/checksum.x86_64.md5
do
    mkdir -p "${CURRENT_DIR}/$(dirname $file)"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
             "${BASEURL}$file" \
        "${CURRENT_DIR}/$file"
done

# Packages
for dir in \
    core/os/x86_64 #\
    #community/os/x86_64 \
    #extra/os/x86_64
do
    mkdir -p "${CURRENT_DIR}/$dir"
    rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
        --copy-unsafe-links \
         "${BASEURL}$dir/" \
    "${CURRENT_DIR}/$dir"
done
