#!/bin/sh

FILE_PATH="$1"

case "$FILE_PATH"
in
        /*)
                NEW_PATH="$FILE_PATH"
                ;;
        *)
                NEW_PATH=`git rev-parse --show-toplevel`/"$FILE_PATH"
                ;;
esac

echo "$NEW_PATH"
