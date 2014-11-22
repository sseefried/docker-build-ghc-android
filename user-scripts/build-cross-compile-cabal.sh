#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

# install a cabal that supports cross compilation
cabal update
cabal install Cabal cabal-install --bindir=$GHC_STAGE0_PREFIX/bin/

# Write cabal wrapper
echo \#/bin/bash > "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
echo NDK=$GHC_PREFIX >> "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
echo NDK_TARGET=$NDK_TARGET >> "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
echo NEW_CABAL=$GHC_STAGE0_PREFIX/bin/cabal >> "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
cat "$BASEDIR/patches/cabal-wrapper" >> "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
chmod +x "$GHC_PREFIX/bin/$NDK_TARGET-cabal"
