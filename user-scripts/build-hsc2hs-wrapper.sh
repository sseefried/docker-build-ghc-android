#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

HSC2HS_TARGET=$(ls $GHC_PREFIX/bin/*-hsc2hs)
echo \#/bin/bash > $HSC2HS_TARGET
echo 'exec /usr/bin/hsc2hs --cross-compile "$@" --define=linux_android_HOST_OS=1' >> $HSC2HS_TARGET
chmod +x $HSC2HS_TARGET

