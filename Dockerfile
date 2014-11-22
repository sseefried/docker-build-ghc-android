FROM joeyh/debian-stable-i386
MAINTAINER sean.seefried@gmail.com

#
# I live in Australia so change the mirror to one more appropriate
# to where you live.
#
run echo "deb http://ftp.au.debian.org/debian stable main" > /etc/apt/sources.list
run echo "deb-src http://ftp.au.debian.org/debian stable main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install build-essential ghc git libncurses5-dev cabal-install \
  llvm-3.0 ca-certificates curl file m4 autoconf zlib1g-dev \
  libgnutls-dev libxml2-dev libgsasl7-dev pkg-config python c2hs
WORKDIR /root
ENV TERM xterm

# Install automake-1.14
ADD root-scripts/install-automake.sh /root/
RUN bash -c ./install-automake.sh

# Create a new user 'androidbuilder'
ADD root-scripts/create-androidbuilder-user.sh /root/
RUN bash -c ./create-androidbuilder-user.sh

# Log-in to the new user and set the working directory
USER androidbuilder
ENV BASE /home/androidbuilder/ghc-build
RUN mkdir -p $BASE/patches
ADD patches/* $BASE/patches/
ADD user-scripts/set-env.sh $BASE/


WORKDIR $BASE

#
# These downloads take quite a while and are annoying. I put them here
# at the beginning to get them out of the way. If something breaks in the
# build it would suck if you had to rewind to a Docker image BEFORE
# the downloads had occurred.
#
ADD user-scripts/download-iconv.sh $BASE/
RUN ./download-iconv.sh
ADD user-scripts/download-ncurses.sh $BASE/
RUN ./download-ncurses.sh
ADD user-scripts/download-gmp.sh $BASE/
RUN ./download-gmp.sh
ADD user-scripts/download-ghc.sh $BASE/
RUN ./download-ghc.sh
ADD user-scripts/download-ndk.sh $BASE/
RUN ./download-ndk.sh

#
# Start preparing the environment.
#
ADD user-scripts/unpack-ndk.sh $BASE/
RUN ./unpack-ndk.sh

ADD user-scripts/create-ndk-standalone-toolchain.sh $BASE/
RUN ./create-ndk-standalone-toolchain.sh

################# WORKING UP TO THIS POINT #################

