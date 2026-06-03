#!/bin/bash
cd /root/openwrt
export PATH="/root/openwrt/staging_dir/host/bin:$PATH"

echo "=== BUILD START $(date) ==="
make download -j8 V=s 2>&1 | tee /root/build2.log
echo "=== DOWNLOAD DONE $(date) ==="

make -j5 V=s 2>&1 | tee -a /root/build2.log
echo "=== BUILD COMPLETE $(date) ==="
