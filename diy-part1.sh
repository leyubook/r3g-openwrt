#!/bin/bash
# diy-part1.sh - 添加第三方软件源

# OpenClash
echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default

# AdGuard Home
echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default

# PassWall 依赖包（消除 make 时的 WARNING）
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >>feeds.conf.default
