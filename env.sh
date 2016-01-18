#!/bin/sh

if [ $# -eq 2 ]; then
    channel=$1
    version=$2
elif [ $# -eq 1 ]; then
    channel=$1
fi

if [ $channel = 'nightly' ]; then
    echo rust-nightly-i586-unknown-linux-gnu.tar.bz2 > tarball
    echo master > branch
fi
if [ $channel = 'beta' ]; then
    echo rust-beta-i586-unknown-linux-gnu.tar.bz2 > tarball
    echo beta > branch
fi
if [ $channel = 'stable' ]; then
    echo rust-$version-i586-unknown-linux-gnu.tar.bz2 > tarball
    echo refs/tags/$version > branch
fi

echo Tarball: `cat tarball`
echo Branch: `cat branch`
