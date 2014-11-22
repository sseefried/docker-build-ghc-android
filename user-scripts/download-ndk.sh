#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo Downloading the Android NDK $NDK_RELEASE
curl -o "${TARDIR}/${NDK_TAR_FILE}"  http://dl.google.com/android/ndk/${NDK_TAR_FILE} 2>&1
check_md5 "$NDK_TAR_PATH" "$NDK_MD5"