#!/bin/bash
set -e
cd /root/openwrt

# Export these globally for all subshells
export FORCE_UNSAFE_CONFIGURE=1
export FORCE=1
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export HOSTCC=/usr/bin/gcc
export HOSTCXX=/usr/bin/g++
export gl_cv_header_working_stdbool_h=yes
export ac_cv_header_stdbool_h=yes
export gl_cv_c_bool_type=yes
export CONFIG_SITE=/tmp/tar_config_cache
export PATH="/root/openwrt/staging_dir/host/bin:$PATH"

LOG=/root/autobuild.log
echo "=== AUTO BUILD START $(date) ===" > $LOG

# Phase 1: Clean and rebuild known failing tools
echo "=== Phase 1: Fixing host tools ===" >> $LOG

for tool in gmp tar; do
    rm -rf build_dir/host/${tool}-* 2>/dev/null
    rm -f staging_dir/host/stamp/.${tool}* 2>/dev/null
done

# Rebuild tools with system compiler
echo "Building gmp..." >> $LOG
make -j1 tools/gmp/compile V=s 2>&1 | tee -a $LOG || echo "gmp: FAILED" >> $LOG
echo "gmp done" >> $LOG

echo "Building tar..." >> $LOG
make -j1 tools/tar/compile V=s 2>&1 | tee -a $LOG || echo "tar: FAILED" >> $LOG
echo "tar done" >> $LOG

# Phase 2: Full build
echo "=== Phase 2: Full build ===" >> $LOG
make -j5 V=s 2>&1 | tee -a $LOG

echo "=== AUTO BUILD COMPLETE $(date) ===" >> $LOG
echo "=== CHECK FIRMWARE ===" >> $LOG
ls -la /root/openwrt/bin/targets/ramips/mt7621/ 2>&1 | tee -a $LOG
