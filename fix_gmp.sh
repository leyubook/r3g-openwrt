#!/bin/bash
cd /root/openwrt
rm -rf build_dir/host/gmp-6.3.0
rm -f staging_dir/host/stamp/.gmp*

export FORCE_UNSAFE_CONFIGURE=1
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export HOSTCC=/usr/bin/gcc
export HOSTCXX=/usr/bin/g++

make -j1 tools/gmp/compile V=s
echo "=== GMP DONE: exit=$? ==="
