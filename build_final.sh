#!/bin/bash
export FORCE_UNSAFE_CONFIGURE=1
export FORCE=1
export gl_cv_header_working_stdbool_h=yes
export ac_cv_header_stdbool_h=yes
export gl_cv_c_bool_type=yes
export CONFIG_SITE=/tmp/tar_config_cache
export PATH="/root/openwrt/staging_dir/host/bin:$PATH"

cd /root/openwrt
echo "=== BUILD START $(date) ===" >> /root/build4.log
make -j5 V=s 2>&1 | tee -a /root/build4.log
echo "=== BUILD COMPLETE $(date) ===" >> /root/build4.log
