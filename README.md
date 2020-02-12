# `docker-build-ghc-android`

This package contains a Dockerfile and associated scripts to build a
GHC 7.8.3 cross compiler targeting the ARM architecture. Big thanks go out
*neuroctye* for the original build script and *joeyh* for additional changes.

You will see some errors in the standard output, some that even look like they might be fatal.
Stay strong and wait. It will build to the end. If it doesn't please contact me.

# Installation

*Please build with at least Docker version 1.6*. Check with `docker version`.

Once you've done that then:

    $ docker build .

# Running

You'll want to run the image inside an interactive shell. At the end of
the build it will tell you the image ID of the final image.

$ docker run -it <image ID> bash

# Motivation

This build script takes between 1 - 2 hours to run. It installs several
packages, some that require patches to make them work with Android.
Developing a build script with this many dependencies is a nightmare.

You can only be sure your script *really* works if you run it on a pristine
environment. But when your script breaks after 50 minutes it is just the sort of
thing that can make you want to consider changing careers, especially if it
happens a few times in a row. Development is made so much easier with
quick turn-around times.

The fantastic thing about Docker is that it effectively takes a snapshot of the *entire
file system* after each Dockerfile command allowing you to return to that
known state and try again.

Docker is great because:

1. It helped *me*. This script was developed much more quickly than it otherwise
   would have been. Because of how Docker works I had the confidence that it
   would build from a pristine environment once I had successfully built it the
   first time.


2. It will help *you*. This script will inevitably succumb to bitrot.
   It may fail but when it does you will not have to go all the way back to the
   beginning. You can make a change to one of the many mini-scripts in the
   ```user-scripts/``` directory and try again from the point of failure.

## More information

For more information read my [blog post](http://lambdalog.seanseefried.com/posts/2014-12-12-docker-build-scripts.html).

## Post script - 10 Feb 2020

And now for a public service announcement. If you _actually_ want to make games
don't [nerdsnipe](https://www.xkcd.com/356/) yourself like I did and work on the technological
foundations. Just make games on a platform that you can be productive in.

The lesson I learned from trying to get Haskell working on Android was this: the choice of programming language matters far less than the vibrancy of the community supporting your programming language for a particular domain (in this case: games).

It took me a long time, literally months, to get this development environment going and now I discover that it has succumbed to bitrot in the space of a few short years.

The lesson learned was a very difficult one for me to absorb, since I love Haskell as a programming language. It made me realise just how much we depend on working ecosystems of software in order to be productive. We stand on the shoulders of giants all the time.

Making a game written in Haskell that runs on iOS and Android reminds me very much of the guy who made a sandwich from scratch. You can watch his story here. 6 months for a self-declared "not bad" (i.e. decidedly average) sandwich.

I had to ask myself the question, was I really interested in making games or was I more interested in creating platforms for people to run the games on?

Would you believe that I am now learning to make games in Unity in C#? I thought the day would never come, but that is what I am doing and, in a little over a week I had made this. Sure, it's nothing special but it's better than the game I made in Haskell 5 - 6 years ago. You can view that here.
