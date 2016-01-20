#!/bin/sh

git clone https://github.com/rust-lang/rust.git

cd rust
git checkout `cat ../branch`
cp ../src/i586-unknown-linux-gnu.mk ./mk/cfg
cp ../src/i586_unknown_linux_gnu.rs ./src/librustc_back/target
cp ../src/snapshot.py ./src/etc
cp ../src/get-snapshot.py ./src/etc
echo ./src/librustc_back/target/mod.rs | xargs sed -i.bak -e 's/i686_unknown_linux_gnu/i586_unknown_linux_gnu/g'
./configure --target=i586-unknown-linux-gnu --host=i586-unknown-linux-gnu --build=i586-unknown-linux-gnu
cd ..
