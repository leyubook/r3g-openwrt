#!/bin/bash
# diy-part1.sh - 添加第三方软件源

# OpenClash（feed 格式，标准方式）
echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default

# AdGuard Home — 直接克隆到 package 目录
# 该仓库是单包结构，不是 feed 格式，不能用 src-git
git clone --depth 1 https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
