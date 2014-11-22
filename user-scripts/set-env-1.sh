#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

if ! [ -e "$CONFIG_SUB_SRC/config.sub" ] ; then
    CONFIG_SUB_SRC=${CONFIG_SUB_SRC:-$NCURSES_SRC}
fi
