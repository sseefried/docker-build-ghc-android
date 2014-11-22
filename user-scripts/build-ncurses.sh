#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

pushd $NCURSES_SRC > /dev/null
./configure --prefix="$NDK_ADDON_PREFIX" --host=$NDK_TARGET --build=$BUILD_ARCH --with-build-cc=$BUILD_GCC --enable-static --disable-shared --includedir="$NDK_ADDON_PREFIX/include" --without-manpages
echo '#undef HAVE_LOCALE_H' >> "$NCURSES_SRC/include/ncurses_cfg.h"   # TMP hack
make $MAKEFLAGS
make install
popd > /dev/null
