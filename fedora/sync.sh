#!/bin/bash
CURRENT_DIR=$(dirname $0)
rsync -vaH --numeric-ids --delete --delete-after --delay-updates \
    "rsync://dl.fedoraproject.org/fedora-enchilada/linux/releases/20/Fedora/x86_64/os" \
    "${CURRENT_DIR}/releases/20/Fedora/x86_64"
