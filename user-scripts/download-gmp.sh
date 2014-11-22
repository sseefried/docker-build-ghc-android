#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Downloading gmp $GMP_RELEASE
curl -o "${TARDIR}/${GMP_TAR_FILE}"  https://gmplib.org/download/gmp/${GMP_TAR_FILE} 2>&1
check_md5 "$GMP_TAR_PATH" "$GMP_MD5"
