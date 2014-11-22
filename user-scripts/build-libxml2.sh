#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

apt-get source libxml2
pushd libxml2*
cp -v "$CONFIG_SUB_SRC/config.sub" .
cp -v "$CONFIG_SUB_SRC/config.guess" .
patch -p0 < $BASEDIR/patches/libxml2-no-tests.patch
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS || true
make install
popd
