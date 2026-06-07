#!/bin/bash
LOG="/root/build2.log"
DL_DIR="/root/openwrt/dl"

while true; do
    SIZE=$(du -sh "$DL_DIR" 2>/dev/null | cut -f1)
    FILES=$(ls "$DL_DIR"/*.tar.* "$DL_DIR"/*.tar.gz "$DL_DIR"/*.tar.bz2 "$DL_DIR"/*.tar.xz 2>/dev/null | wc -l)
    FAILS=$(grep -c "Download failed" "$LOG" 2>/dev/null)

    # Check if compilation started
    COMP=$(grep -c "BUILD START\|make -j5" "$LOG" 2>/dev/null)

    echo "$(date +%H:%M:%S) dl=$SIZE f=$FILES fails=$FAILS comp=$COMP"

    # Check if done
    if grep -q "BUILD COMPLETE" "$LOG" 2>/dev/null; then
        echo "=== BUILD DONE ==="
        ls -la /root/openwrt/bin/targets/ramips/mt7621/ 2>/dev/null
        break
    fi

    sleep 120
done
