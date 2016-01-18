#!/bin/sh

mkdir -p result
cp rust/LICENSE* rust/COPYRIGHT cargo/LICENSE* result
cp -r rust/i586-unknown-linux-gnu/stage2/* result
tar jcvf `cat tarball` result
cp `cat tarball` $CIRCLE_ARTIFACTS
rm -rf rust cargo
