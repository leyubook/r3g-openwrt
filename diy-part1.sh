#!/bin/bash
# diy-part1.sh - 添加第三方软件源

cd openwrt

# OpenClash
echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default

# AdGuard Home
echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default
