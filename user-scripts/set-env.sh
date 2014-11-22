#!/bin/bash

#
# This script is responsible for setting up all the environment variables exactly the way
# they should be for building GHC. It will be sourced from other build scripts, but not
# run directly by Docker.
#

[ -e /etc/makepkg.conf ] && source /etc/makepkg.conf
MAKEFLAGS=${MAKEFLAGS:--j9}

# Basic configuration
GHCHOME=$HOME/.ghc
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$BASEDIR"

# Basic parameters
NDK_RELEASE=${NDK_RELEASE:-r9b}
NDK_MD5=d7f783deaeea6b60cb515d9427c01c2e
NDK_PLATFORM=${NDK_PLATFORM:-android-14}

if [ "x$1" == "x--x86" ] ; then
    NDK_TOOLCHAIN=${NDK_TOOLCHAIN:-x86-4.8}
    NDK_TARGET=${NDK_TARGET:-i686-linux-android}
    ARCH_OPTS=""
else
    NDK_TOOLCHAIN=${NDK_TOOLCHAIN:-arm-linux-androideabi-4.8}
    NDK_TARGET=${NDK_TARGET:-arm-linux-androideabi}
    ARCH_OPTS="-fllvm"
fi

NDK_DESC=$NDK_PLATFORM-$NDK_TOOLCHAIN
NDK="$GHCHOME/$NDK_PLATFORM/$NDK_TOOLCHAIN"
NDK_ADDON_SRC="$BASEDIR/build-$NDK_DESC"
NDK_ADDON_PREFIX="$NDK/sysroot/usr"

GHC_STAGE0_SRC="$BASEDIR/stage0"
GHC_STAGE0_PREFIX="$GHCHOME/android-host"
GHC_STAGE0="$GHC_STAGE0_PREFIX/bin/ghc"

GHC_PREFIX="$NDK"
GHC_SRC="$NDK_ADDON_SRC/ghc"

# GHC tarball
GHC_RELEASE=7.8.3
GHC_MD5=5e34b2a29564596c9ed83fb8667b47d4

NCURSES_RELEASE=5.9
NCURSES_MD5=8cb9c412e5f2d96bc6f459aa8c6282a1

GMP_RELEASE=5.1.3
GMP_MD5=e5fe367801ff067b923d1e6a126448aa

CONFIG_SUB_SRC=${CONFIG_SUB_SRC:-/usr/share/automake-1.14}

BUILD_GCC=gcc
BUILD_ARCH=$($BUILD_GCC -v 2>&1 | grep ^Target: | cut -f 2 -d ' ')

mkdir -p "$GHCHOME"
mkdir -p "$NDK_ADDON_SRC"
mkdir -p "${BASEDIR}/tarfiles"
TARDIR="${BASEDIR}/tarfiles"

function check_md5() {
    FILENAME="$1"
    MD5="$2"
    [ -e "${FILENAME}" ] || return 1;
    ACTUAL_MD5=$(md5sum "$FILENAME" | cut -f1 -d ' ')
    if [ ! "$ACTUAL_MD5" == "$MD5" ]; then
      >&2 echo "MD5 hash of $FILENAME did not match."
      >&2 echo "$MD5 =/= $ACTUAL_MD5"
      exit 1
    fi
}

function apply_patches() {
    pushd $2 > /dev/null
    for p in $(find "$BASEDIR/patches" -name "$1") ; do
        echo Applying patch $p in $(pwd)
        patch -p1 < "$p"
    done
    popd > /dev/null
}

# Add toolchain to path
export PATH="$NDK/bin":$PATH

# Download and configure the Android NDK toolchain
NDK_TAR_FILE=android-ndk-${NDK_RELEASE}-linux-x86.tar.bz2
NDK_TAR_PATH="${TARDIR}/${NDK_TAR_FILE}"
NDK_PATH="$HOME/android-ndk-$NDK_RELEASE"

# Unpack ncurses
NCURSES_TAR_FILE=ncurses-${NCURSES_RELEASE}.tar.gz
NCURSES_TAR_PATH="${TARDIR}/${NCURSES_TAR_FILE}"
NCURSES_SRC="$NDK_ADDON_SRC/ncurses-${NCURSES_RELEASE}"

ICONV_SRC="$NDK_ADDON_SRC/iconv"
# Last known working git commit
ICONV_GIT_COMMIT=d5006db0ff4449b447946ab31d1a41b63078c773

GMP_TAR_FILE=gmp-${GMP_RELEASE}.tar.xz
GMP_TAR_PATH="${TARDIR}/${GMP_TAR_FILE}"
GMP_SRC="$NDK_ADDON_SRC/gmp-${GMP_RELEASE}"

GHC_TAR_FILE=ghc-${GHC_RELEASE}-src.tar.xz
GHC_TAR_PATH="${TARDIR}/${GHC_TAR_FILE}"