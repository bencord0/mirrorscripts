#!/bin/bash

MIRROR=rsync://rsync.mirrorservice.org/ftp.openbsd.org/pub/OpenBSD/
SUBDIRS=$(echo {ftplist,timestamp,songs/,{5.{4,5}/{amd64/,i386/,README,SHA256{,.sig},{ports,src,sys}.tar.gz,root.mail},snapshots/{amd64/,i386/,ports.tar.gz,timestamp}}})

for subdir in $SUBDIRS; do
    rsync -vr $MIRROR$subdir $subdir
done

