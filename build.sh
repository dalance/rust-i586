#!/bin/sh

channel=nightly
#channel=beta
#channel=stable
stable_version=1.5.0

if [ $channel = 'nightly' ]; then
    tarball=rust-nightly-i586-unknown-linux-gnu.tar.bz2
    branch=master
fi
if [ $channel = 'beta' ]; then
    tarball=rust-beta-i586-unknown-linux-gnu.tar.bz2
    branch=beta
fi
if [ $channel = 'stable' ]; then
    tarball=rust-$stable_version-i586-unknown-linux-gnu.tar.bz2
    branch=refs/tags/$stable_version
fi

export CFLAGS=-march=pentium2
export CXXFLAGS=-march=pentium2

git clone https://github.com/rust-lang/rust.git
git clone https://github.com/rust-lang/cargo.git

cd rust
git checkout $branch
cp ../src/i586-unknown-linux-gnu.mk ./mk/cfg
cp ../src/i586_unknown_linux_gnu.rs ./src/librustc_back/target
cp ../src/snapshot.py ./src/etc
cp ../src/get-snapshot.py ./src/etc
./configure --target=i586-unknown-linux-gnu --host=i586-unknown-linux-gnu --build=i586-unknown-linux-gnu
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
tar jcvf $tarball rust-i586
cp $tarball $CIRCLE_ARTIFACTS
