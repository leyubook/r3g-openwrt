#!/bin/bash
set -e
cd /root/openwrt

# Fix 1: Clean and rebuild gmp with system compiler
rm -rf build_dir/host/gmp-6.3.0
rm -f staging_dir/host/stamp/.gmp*

export FORCE_UNSAFE_CONFIGURE=1
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export HOSTCC=/usr/bin/gcc
export HOSTCXX=/usr/bin/g++

echo "=== REBUILDING GMP ==="
make -j1 tools/gmp/compile V=s 2>&1 | tee /root/gmp_build.log
echo "GMP DONE: $?"

# Fix 2: Also rebuild other failed tools with system compiler if needed
rm -rf build_dir/host/tar-1.35 2>/dev/null
rm -f staging_dir/host/stamp/.tar* 2>/dev/null

echo "=== REBUILDING TAR ==="
make -j1 tools/tar/compile V=s 2>&1 | tee /root/tar_build.log
echo "TAR DONE: $?"

# Now continue full build
echo "=== RESUMING FULL BUILD ===" >> /root/build4.log
make -j5 V=s 2>&1 | tee -a /root/build4.log
echo "=== BUILD COMPLETE $(date) ===" >> /root/build4.log
