#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

apt-get source libidn
pushd libidn*
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH \
  --with-build-cc=$BUILD_GCC --enable-static --disable-shared
make $MAKEFLAGS || true
make install
popd


