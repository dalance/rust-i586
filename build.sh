#!/bin/sh

export CFLAGS=-march=pentium2
export CXXFLAGS=-march=pentium2

git clone https://github.com/rust-lang/rust.git
git clone https://github.com/rust-lang/cargo.git

cd rust
cp ../src/i586-unknown-linux-gnu.mk ./mk/cfg
cp ../src/main.mk ./mk
cp ../src/i586_unknown_linux_gnu.rs ./src/librustc_back/target
cp ../src/snapshot.py ./src/etc
./configure --enable-dist-host-only --target=i586-unknown-linux-gnu --host=i586-unknown-linux-gnu --build=i686-unknown-linux-gnu
make
cd ..

cd cargo
git submodule update --init
python -B src/etc/install-deps.py
./configure --target=i586-unknown-linux-gnu --local-rust-root=../rust/i586-unknown-linux-gnu/stage2/bin/rustc
make
cd ..

mkdir -p rust-i586
cp rust/LICENSE* rust/COPYRIGHT cargo/LICENSE* rust-i586
cp -r rust/i586-unknown-linux-gnu/stage2/* rust-i586
tar jcvf rust-nightly-i586-linux.tar.bz2 rust-i586
cp rust-nightly-i586-linux.tar.bz2 $CIRCLE_ARTIFACTS
