#!/bin/sh

git clone https://github.com/rust-lang/cargo.git

cd cargo
git submodule update --init
python -B src/etc/install-deps.py
./configure --target=i586-unknown-linux-gnu --local-rust-root=../rust/i586-unknown-linux-gnu/stage2
cd ..
