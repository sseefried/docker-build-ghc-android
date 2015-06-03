#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cabal update
cabal install \
  binary-0.7.5.0 \
  directory-1.2.2.1 \
  network-2.6.2.0 \
  process-1.2.3.0 \
  Cabal-1.22.3.0 \
  random-1.1 \
  stm-2.4.4 \
  text-1.2.1.1 \
  transformers-0.4.3.0 \
  mtl-2.2.1 \
  parsec-3.1.9 \
  network-uri-2.6.0.3 \
  HTTP-4000.2.19 \
  zlib-0.5.4.2 \
  cabal-install-1.22.4.0