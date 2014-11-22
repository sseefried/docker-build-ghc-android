#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

cd $NDK_ADDON_SRC
tar xf ${GHC_TAR_PATH}
mv ghc-${GHC_RELEASE} "$GHC_SRC"
apply_patches 'ghc-*' "$GHC_SRC"
pushd "$GHC_SRC" > /dev/null

# Setup build.mk
cat > mk/build.mk <<EOF
Stage1Only = YES
DYNAMIC_GHC_PROGRAMS = NO
SRC_HC_OPTS     = -O -H64m
GhcStage1HcOpts = -O2 -fasm
GhcStage2HcOpts = -O2 -fasm $ARCH_OPTS
GhcHcOpts       = -Rghc-timing
GhcLibHcOpts    = -O2
GhcLibWays      = v
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
EOF

# Update config.sub and config.guess
for x in $(find . -name "config.sub") ; do
    dir=$(dirname $x)
    cp -v "$CONFIG_SUB_SRC/config.sub" "$dir"
    cp -v "$CONFIG_SUB_SRC/config.guess" "$dir"
done

# Apply library patches
apply_patches "hsc2hs-*" "$GHC_SRC/utils/hsc2hs"
apply_patches "haskeline-*" "$GHC_SRC/libraries/haskeline"
apply_patches "unix-*" "$GHC_SRC/libraries/unix"
apply_patches "base-*" "$GHC_SRC/libraries/base"

# Configure
perl boot
./configure --enable-bootstrap-with-devel-snapshot --prefix="$GHC_PREFIX" --target=$NDK_TARGET \
  --with-ghc=$GHC_STAGE0 --with-gcc=$NDK/bin/$NDK_TARGET-gcc

function check_install_gmp_constants() {
    GMPDCHDR="libraries/integer-gmp/mkGmpDerivedConstants/dist/GmpDerivedConstants.h"
    if ! [ -e  "$GMPDCHDR" ] ; then
        if [ -e "$BASEDIR/patches/gmp-$NDK_DESC-GmpDerivedConstants.h" ] ; then
            cp -v "$BASEDIR/patches/gmp-$NDK_DESC-GmpDerivedConstants.h" "$GMPDCHDR"
        else
            echo \#\#\# Execute the following commands to generate a GmpDerivedConstants.h for your target, then run build again:
            echo \#\#\# adb push ghc-$NDK_DESC/libraries/integer-gmp/cbits/mkGmpDerivedConstants /data/local
            echo \#\#\# adb shell /data/local/mkGmpDerivedConstants \> $BASEDIR/patches/gmp-$NDK_DESC-GmpDerivedConstants.h
            echo \#\#\# adb shell rm /data/local/mkGmpDerivedConstants
            exit 1
        fi
    fi
}

make $MAKEFLAGS || true # TMP hack, see http://hackage.haskell.org/trac/ghc/ticket/7490
make $MAKEFLAGS || true # TMP hack, target mkGmpDerivedConstants fails on build host
# There's a long pause at this point. Just be patient!
check_install_gmp_constants
make $MAKEFLAGS || true # TMP hack, tries to execut inplace stage2
make $MAKEFLAGS || true # TMP hack, one more for luck
make install


