#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

cd $NDK_ADDON_SRC
tar xf ${GHC_TAR_PATH}
mv ghc-${GHC_RELEASE} "$GHC_STAGE0_SRC"
pushd "$GHC_STAGE0_SRC" > /dev/null

    # Setup build.mk
    cat > mk/build.mk <<EOF
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
EOF

# Configure
perl boot
./configure --prefix="$GHC_STAGE0_PREFIX"
make $MAKEFLAGS
make $MAKEFLAGS install || true  # first time fails, for unknown reason
make $MAKEFLAGS install

