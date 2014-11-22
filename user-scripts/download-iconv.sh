#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Checking out iconv Android git repository"
git clone https://github.com/ironsteel/iconv-android.git $ICONV_SRC 2>&1
pushd $ICONV_SRC
git checkout $ICONV_GIT_COMMIT 2>&1
popd