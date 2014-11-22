#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

cd $NDK_ADDON_SRC
apt-get source nettle
pushd nettle*
cp -v "$CONFIG_SUB_SRC/config.sub" .
cp -v "$CONFIG_SUB_SRC/config.guess" .
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS
make install
popd
