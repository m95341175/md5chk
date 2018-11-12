#!/usr/bin/env sh
#
# Replacement for md5sum on macOS. This script offers the additional feature to
# scan an external file for filenames and the coorresponding MD5 hashes.
#

VERSION=2.01
DATE=2017-10-19
QUIET=false
ERROR=0
thisName=${0##*/}

usage() {
    if [ "$1" == "invalid" ]; then
        echo "Invalid option: -$OPTARG" >&2
        echo
    fi
    echo "SYNOPSIS"
    echo "\t${thisName} [-q] FILE"
    echo "\t${thisName} [-v] [-h]"
    echo
}

if [ -z "$1" ] || [ "$1" = "help" ] || [ $# -ge 3 ]; then
    usage
    exit 0
fi

while getopts ":qhv" OPT; do
    case $OPT in
        q)
            QUIET=true
            ;;
        v)
            echo "${thisName} -- v$VERSION -- $DATE"
            echo
            exit 0
            ;;
        h)
            echo "${thisName} -- v$VERSION"
            echo
            usage
            echo "DESCRIPTION"
            echo "\tReads MD5 (128-bits) checksums and filenames in FILE and checks them"
            echo
            echo "\t-q\tQuiet mode, only prints mismatched hashes"
            echo
            echo "\t-h\tDisplays this help and exits"
            echo
            echo "\t-v\tDisplays version info"
            echo
            echo "AUTHOR"
            echo "\tOriginally written by Joris Berthelot <admin@eexit.net>"
            echo "\thttps://github.com/eexit/md5sum"
            echo "\tImproved by Mel Lowiz <mellowiz@hotmail.com>"
            echo "\thttps://github.com/mellowiz/md5sum"
            echo
            echo "COPYRIGHT"
            cat << EOT
        Copyright (c) 2017, Mel Lowiz <mellowiz@hotmail.com>
                 2011-2015, Joris Berthelot <admin@eexit.net>
EOT
            echo
            exit 0
            ;;
        \?)
            usage invalid
            ;;
    esac
done

# Loops on each argument
for ARG in $*; do
    
    # Checks arg filename existence
    if [ ! -e "$ARG" ]; then
        if [[ "-q" != "$ARG" ]]; then
            echo "md5sum: "$ARG": No such filename"
            ERROR=1
        fi
        continue
    fi
    
    # Checks if file content has at least one checksum pattern
    if [ 0 -eq "$(grep -csxE "^\w{32}\s(\s|\*).+$" "$ARG")" ]; then
        if ! $QUIET ; then
            echo "[  \033[0;33m!!\033[0m  ] "$ARG": No valid MD5 checksum entry found"
        fi
        ERROR=1
        continue
    fi
    
    # Loops on file lines
    while read LINE; do
        
        # Checks if the current line has a checksum pattern
        if [[ $(echo "$LINE" | grep -sxE "^\w{32}\s(\s|\*).+$") ]]; then
            
            # Gets the file name of the line
            CFILE=$(echo "$LINE" | cut -c 35-)
            MD5SUM=$(echo "$LINE" | cut -c -32)
            
            # If the file does not exist
            if [ ! -e "$CFILE" ]; then
                # If verbose output
                if ! $QUIET ; then
                    echo "[  \033[0;33m!!\033[0m  ] "$CFILE": File is missing"
                fi
                continue
            fi

            # Checks if the MD5 sum of the file is the expected one
            if [[ "$MD5SUM" == $(md5 -q "$CFILE") ]]; then
                # If verbose output
                if ! $QUIET ; then
                    echo "[  \033[0;32mOK\033[0m  ] "$CFILE""
                fi
            else # File checksum failed
                echo "[\033[0;31mFAILED\033[0m] "$CFILE": MD5 sum incorrect"
                ERROR=1
            fi
            
        fi
    done < $ARG
done

exit $ERROR
