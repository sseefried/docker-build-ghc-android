#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env-1.sh
####################################################################################################

arm-linux-androideabi-cabal update
CFG=$NDK/.cabal/config

cat $CFG | sed 's/^\(jobs.*\)$/-- \1/' > $CFG.new
rm -f $CFG
mv $CFG.new $CFG

