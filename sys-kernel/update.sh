#!/bin/bash

echo "Downloading snapshot"
wget -O - "http://git.overlays.gentoo.org/gitweb/?p=dev/anarchy.git;a=snapshot;h=a4869ab71bcaf4ffff201aec1db930d1dd821e66;sf=tgz" | tar xvvzf - --strip-components 1 -C hardened-sources

echo "Updating digest"
ebuild `ls -1 hardened-sources/*.ebuild | head -n 1` digest
