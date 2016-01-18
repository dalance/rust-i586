#!/bin/sh

mkdir -p result
cp rust/LICENSE* rust/COPYRIGHT cargo/LICENSE* result
cp -r rust/i586-unknown-linux-gnu/stage2/* result
tar jcvf $TARBALL result
cp $TARBALL $CIRCLE_ARTIFACTS
rm -rf rust cargo
