#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Syntax: $0 debfile"
    exit 1
fi
DEBFILE="$1"
TMPDIR=$(mktemp -d /tmp/deb.XXXXXXXXXX || exit 1)
OUTPUT=$(basename "$DEBFILE").modfied.deb
dpkg-deb -x "$DEBFILE" "$TMPDIR"
dpkg-deb --control "$DEBFILE" "$TMPDIR"/DEBIAN
if [[ ! -e "$TMPDIR"/DEBIAN/control ]]; then
    echo DEBIAN/control not found.
    rm -r "$TMPDIR"
    exit 1
fi
CONTROL="$TMPDIR"/DEBIAN/control
vi "$CONTROL"
echo Building new deb...
dpkg -b "$TMPDIR" "$OUTPUT"
rm -r "$TMPDIR"
