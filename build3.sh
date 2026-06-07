#!/bin/bash
export FORCE_UNSAFE_CONFIGURE=1
export FORCE=1
export PATH="/root/openwrt/staging_dir/host/bin:$PATH"
cd /root/openwrt

echo "=== BUILD START $(date) ===" >> /root/build3.log
make -j5 V=s 2>&1 | tee -a /root/build3.log
echo "=== BUILD COMPLETE $(date) ===" >> /root/build3.log
