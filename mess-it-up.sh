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
echo "blabla" > blabla.txt
git add blabla.txt
git commit -s -m 'bla bla'

# Add file in staging but do not commit.
git add c-bye/build.fc.x86_64

# Remove file and add to staging.
git rm c-hello/hello.c

# Remove file but do not add to staging.
rm c-hello/Makefile

# Create random files.
for i in $(seq 1 10); do
    mktemp XXXXXXXXX
    mktemp c-hello/XXXXXXXXX
    mktemp nginx/rootfs/XXXXXXXXX
done
