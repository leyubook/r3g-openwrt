#!/bin/bash
# diy-part1.sh - 添加第三方软件源

# Argon 主题配置面板 — 直接克隆到 package 目录
# 该包不在任何 feed 中，需手动添加
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# smartdns 核心
# 官方仓库的 OpenWrt 打包脚本在 package/openwrt/ 子目录下
# 需要将打包文件移至 package/smartdns/ 根目录才能被构建系统识别
git clone --depth 1 https://github.com/pymumu/smartdns.git package/smartdns
cp -r package/smartdns/package/openwrt/* package/smartdns/
cp -r package/smartdns/package/openwrt/.* package/smartdns/ 2>/dev/null || true
rm -rf package/smartdns/package

# luci-app-smartdns 管理界面
git clone --depth 1 https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
