#!/bin/bash
CURRENT_DIR=$(dirname $0)
BASEURL=rsync://rsync.mirrorservice.org/dl.fedoraproject.org/pub/fedora/linux/

# Stable release and install media
mkdir -p "${CURRENT_DIR}/releases/20/Fedora/x86_64/os"
rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
         "${BASEURL}releases/20/Fedora/x86_64/os/" \
    "${CURRENT_DIR}/releases/20/Fedora/x86_64/os"

# Packages
mkdir -p "${CURRENT_DIR}/releases/20/Everything/x86_64/os/Packages"
rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
    --include '*.x86_64.rpm' --include '*.noarch.rpm' \
    --include '*/' --exclude '*' \
         "${BASEURL}releases/20/Everything/x86_64/os/Packages/" \
    "${CURRENT_DIR}/releases/20/Everything/x86_64/os/Packages"
