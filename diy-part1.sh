#!/bin/bash
# diy-part1.sh - 添加第三方软件源

# Argon 主题配置面板 — 直接克隆到 package 目录
# 该包不在任何 feed 中，需手动添加
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# smartdns 核心（OpenWrt 独立打包仓库，放入 feeds）
# 官方说明: https://github.com/pymumu/openwrt-smartdns
mkdir -p feeds/packages/net/smartdns
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns

# luci-app-smartdns 管理界面（LEDE 必须用 lede 分支）
# 官方说明: https://github.com/pymumu/luci-app-smartdns
mkdir -p feeds/luci/applications/luci-app-smartdns
git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns
