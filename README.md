#docker-build-ghc-android

This package contains a Dockerfile and associated scripts to build a
GHC 7.8.3 cross compiler targeting the ARM architecture. Big thanks go out
*neuroctye* for the original build script and *joeyh* for additional changes.

# Installation

    $ docker build .

# Motivation

This build script takes between 1 - 2 hours to run. It installs several
packages, some that require patches to make them work with Android.
Developing a build script with this many dependencies is a nightmare.

You can only be sure your script *really* works if you run it on a pristine
environment. But finding your last change to the script breaks it 50 minutes
in is just the thought of thing that can make you want to consider changing
careers, especially if it happens a few times in a row.

The fantastic thing about Docker is that it effectively checkpoints the *entire
file system* after each Dockerfile command allowing you to return to that
known state and try again.

In conclusion, Docker is great because:

1. It helped me develop this script much more quickly and have confidence
   that when it built for the first time it really would build again when
   I started from a pristine environment.

2. It will help you as this script inevitably succumbs to bitrot. The script
   may fail but you will not have to go all the way back to the beginning.
   You can make a change to one of the many mini-scripts in the
   ```user-scripts/``` directory.

