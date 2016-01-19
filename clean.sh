#!/bin/sh

mkdir -p result
cp rust/LICENSE* rust/COPYRIGHT cargo/LICENSE* result
cp -r rust/i586-unknown-linux-gnu/stage2/* result
cd result
tar jcvf `cat tarball` ./
cp `cat tarball` $CIRCLE_ARTIFACTS
cd ..
rm -rf rust cargo
