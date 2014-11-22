#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Preparing the Android NDK toolchain in $NDK
"$NDK_PATH/build/tools/make-standalone-toolchain.sh" --toolchain=$NDK_TOOLCHAIN \
  --platform=$NDK_PLATFORM --install-dir="$NDK"

#TMP hack, fake pthread library for ghc linker
(cd "$NDK_ADDON_PREFIX/lib" && ln -s libcharset.a libpthread.a)