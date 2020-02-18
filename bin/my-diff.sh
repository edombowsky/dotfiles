#!/bin/sh

LOCAL="$1"
REMOTE="$2"

case "$LOCAL"
in
    *)
    L=$(echo "C:/Users/caeadom/AppData/Local/lxss/rootfs${LOCAL}" | sed 's,/,\\\\,g')
    ;;
esac

case "$REMOTE"
in
    *)
    R=$(echo `git rev-parse --show-toplevel`/"$REMOTE" | sed 's,/mnt/c/,C:/,g' | sed 's,/,\\\\,g')
    ;;
esac

echo "$L"
echo "$R"
winmerge "$L" "$R"
