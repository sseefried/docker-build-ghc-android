#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Downloading GHC $GHC_RELEASE"
echo curl -o "$GHC_TAR_PATH" http://downloads.haskell.org/~ghc/${GHC_RELEASE}/${GHC_TAR_FILE}
curl -o "$GHC_TAR_PATH" http://downloads.haskell.org/~ghc/${GHC_RELEASE}/${GHC_TAR_FILE} 2>&1
check_md5 "$GHC_TAR_PATH" "$GHC_MD5"
