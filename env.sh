#!/bin/sh

if [ $# -eq 2 ]; then
    channel=$1
    version=$2
elif [ $# -eq 1 ]; then
    channel=$1
fi

if [ $channel = 'nightly' ]; then
    export TARBALL=rust-nightly-i586-unknown-linux-gnu.tar.bz2
    export BRANCH=master
fi
if [ $channel = 'beta' ]; then
    export TARBALL=rust-beta-i586-unknown-linux-gnu.tar.bz2
    export BRANCH=beta
fi
if [ $channel = 'stable' ]; then
    export TARBALL=rust-$version-i586-unknown-linux-gnu.tar.bz2
    export BRANCH=refs/tags/$version
fi

export CFLAGS=-march=pentium2
export CXXFLAGS=-march=pentium2

