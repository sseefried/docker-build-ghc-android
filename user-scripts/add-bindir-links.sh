#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

# Add target bindir links
function bindir_link() {
    [ -e $GHC_PREFIX/$NDK_TARGET/bin/$1 ] || \
        (echo ln -s $GHC_PREFIX/bin/*-$1 $GHC_PREFIX/$NDK_TARGET/bin/$1 ;\
        ln -s $GHC_PREFIX/bin/*-$1 $GHC_PREFIX/$NDK_TARGET/bin/$1)
}
bindir_link ghc
bindir_link ghc-pkg
bindir_link hp2ps
bindir_link hsc2hs
bindir_link cabal
