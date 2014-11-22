#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Downloading ncurses $NCURSES_RELEASE
curl -o "${TARDIR}/${NCURSES_TAR_FILE}"  http://ftp.gnu.org/pub/gnu/ncurses/${NCURSES_TAR_FILE} 2>&1
check_md5 "$NCURSES_TAR_PATH" "$NCURSES_MD5"
