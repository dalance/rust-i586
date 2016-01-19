#!/bin/sh

mkdir -p result
cp rust/LICENSE* rust/COPYRIGHT cargo/LICENSE* result
cp -r rust/i586-unknown-linux-gnu/stage2/* result
cp cargo/target/i586-unknown-linux-gnu/release/cargo result
cd result
tar jcvf `cat ../tarball` ./
cp `cat ../tarball` $CIRCLE_ARTIFACTS
cd ..
rm -rf rust cargo
