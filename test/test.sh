#!/usr/bin/env sh

VERSION=2.01
DATE=2017-10-19
QUIET=false
ERROR=0

usage(){
        echo "Invalid option: -$OPTARG" >&2
        echo
        echo "SYNOPSIS"
        echo "\tmd5sum [-q] source_file"
        echo "\tmd5sum [-v] [-h]"
        exit 0
}

if [ -z "$1" ] || [ "$1" = "help" ] || [ $# -ge 2 ]; then
        usage
fi

while getopts ":qhv" OPT; do
    case $OPT in
        q)
#            QUIET=true
            echo "You pressed Quiet"
            echo $* $0
            ;;
        v)
            echo "You pressed Version"
            echo "md5sum -- v$VERSION -- $DATE"
            exit 0
            ;;
        h)
            echo "You pressed Help"
            echo "\t\t\tmd5sum -- v$VERSION"
            echo
            echo "SYNOPSIS"
            echo "\tmd5sum [-q] source_file"
            echo "\tmd5sum [-v] [-h]"
            echo
            echo "DESCRIPTION"
            echo "\tReads MD5 (128-bits) checksums in the file and compare them to the files"
            echo
            echo "\t-q"
            echo "\t\tQuiet mode. Don't print OK messages or warnings messages"
            echo
            echo "\t-h"
            echo "\t\tDisplays this help and exits"
            echo
            echo "\t-v"
            echo "\t\tOutputs the version information and exits"
            echo
            echo "AUTHOR"
            echo "\tWritten by Joris Berthelot <admin@eexit.net>"
            echo "\thttps://github.com/eexit/md5sum"
            echo
            echo "COPYRIGHT"
            cat << EOT
        Copyright  message
        
EOT
            echo
            exit 0
            ;;
        \?)
#            echo "Invalid option: -$OPTARG" >&2
#            echo
#            echo "SYNOPSIS"
#            echo "\tmd5sum [-q] source_file"
#            echo "\tmd5sum [-v] [-h]"
#            exit 0
            usage
            ;;
    esac
done
