#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh

####################################################################################################

(cd $NDK_ADDON_SRC; tar xf "$TARDIR/$NCURSES_TAR_FILE")
