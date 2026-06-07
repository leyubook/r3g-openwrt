#!/bin/bash
export FORCE_UNSAFE_CONFIGURE=1
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export HOSTCC=/usr/bin/gcc
export HOSTCXX=/usr/bin/g++
export gl_cv_header_working_stdbool_h=yes
export ac_cv_header_stdbool_h=yes
export gl_cv_c_bool_type=yes
export CONFIG_SITE=/tmp/tar_config_cache
export PATH="/root/openwrt/staging_dir/host/bin:$PATH"
export GOPROXY="https://goproxy.cn,direct"
export GOFLAGS="-modcacherw"

LOG=/root/resume.log
STATUS=/root/build_status.txt

cd /root/openwrt

# Background status writer (every 30s)
while true; do
    echo "STATUS: $(date +%H:%M:%S)" > $STATUS
    echo "MEM: $(free -m | grep Mem | awk '{print $3"MB/"$2"MB"}')" >> $STATUS
    echo "LOAD: $(uptime | grep -oP 'load average: \K.*')" >> $STATUS
    echo "LOG_LINES: $(wc -l < $LOG 2>/dev/null)" >> $STATUS
    echo "ERRORS: $(grep -c 'ERROR:' $LOG 2>/dev/null)" >> $STATUS
    echo "LAST: $(tail -1 $LOG 2>/dev/null)" >> $STATUS
    echo "DONE: $(grep -c 'COMPLETE' $LOG 2>/dev/null)" >> $STATUS
    ls /root/openwrt/bin/targets/ramips/mt7621/*.bin 2>/dev/null >> $STATUS
    pgrep -c make >> $STATUS
    sleep 30
done &

echo "=== BUILD RESTART $(date) ===" >> $LOG
echo "GOPROXY=$GOPROXY" >> $LOG
make -j5 V=s 2>&1 | tee -a $LOG
echo "=== BUILD COMPLETE $(date) ===" >> $LOG
