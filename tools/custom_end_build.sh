#!/bin/bash
# Copyright (C) 2016 - 2017 Tuxafgmur - Dhollmen 
# Removes files after the rom is builded
# When building ota, names the ota end file to distribution file name

WOURTDIR=${1%/system}
 
A=$(grep test-keys $WOURTDIR/build_fingerprint.txt)

B=${A%:*}
CODE=${B##*/}

A=${B#*:}
VERSION=${A%%/*}

DATE=$(date +"%Y%m%d")
OTAFILE="Dhollmen-"$VERSION"-athene_"$DATE".zip"

for B in $WOURTDIR/obj/PACKAGING/apkcerts_intermediates/*; do
    case $B in
        *$CODE*) 
            ;;
        *)
            rm -rf $B
            ;;
    esac
done

for B in $WOURTDIR/obj/PACKAGING/target_files_intermediates/*; do
    case $B in
        *$CODE*) 
            ;;
        *)
            rm -rf $B
            ;;
    esac
done

for B in $WOURTDIR/*-ota-*; do
    case $B in
        *$CODE*)
            if [ "$BUILDING_OTA" = "true" ]; then
                OTAFILE=${B%/*}"/"$OTAFILE
                rm -f $OTAFILE
                mv $B $OTAFILE
            fi
            ;;
        
        *)
            rm -rf $B
            ;;
    esac
done

rm -rf $WOURTDIR/ramdisk-recovery.*
