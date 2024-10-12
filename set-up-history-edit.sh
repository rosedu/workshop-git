#!/bin/sh

./reset-all.sh

# Extract new files.
unzip support/c-bye.zip c-bye/bye.c
unzip support/c-bye.zip c-bye/build.qemu.x86_64
unzip support/c-bye.zip c-bye/build.fc.x86_64

# Go to base branch.
git checkout base

# Create commit with bad message.
git add c-bye/bye.c
git add c-bye/build.qemu.x86_64
git commit -s -m 'Add C Bue application'

# Create a commit that shouldn't exist.
tmp=$(mktemp XXXXXXXXX)
git add "$tmp"
git commit -s -m 'bla bla'

# Create correct commit.
git add c-bye/build.fc.x86_64
git commit -s -m 'c-bye: Add Firecracker build script for x86_64'
