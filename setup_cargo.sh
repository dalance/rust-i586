#!/bin/sh

git clone https://github.com/rust-lang/cargo.git

cd cargo
git submodule update --init
python -B src/etc/install-deps.py
./configure --target=i586-unknown-linux-gnu --build=i586-unknown-linux-gnu --host=i586-unknown-linux-gnu --local-rust-root=/usr/local
make
mkdir ../mods
cp -r ~/.cargo/registry/src/github.com-*/* ../mods/
mkdir .cargo
grep -lr target.i686-unknown-linux-gnu.dependencies `pwd`/../mods | awk 'BEGIN{print "paths = ["}//{out=$0;gsub("Cargo.toml","",$out);print "\""$out"\","}END{print "]"}' > .cargo/config
grep -lr target.i686-unknown-linux-gnu.dependencies ../mods | xargs sed -i.bak -e 's/target.i686-unknown-linux-gnu.dependencies/target.i586-unknown-linux-gnu.dependencies/g'
grep -lr "curl-sys = { path = \"curl-sys\", version = \"0.1.0\" }" ../mods | xargs sed -i.bak -e 's/curl-sys = { path = \"curl-sys\", version = \"0.1.0\" }/curl-sys = \"0.1.0\"/g'
make
grep -lr rustc-link-search=native=/usr/lib/x86_64-linux-gnu ./ | xargs sed -i.bak -e 's/rustc-link-search=native=/usr/lib/x86_64-linux-gnu/rustc-link-search=native=/usr/lib32/g'
cd ..
