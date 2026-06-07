#!/bin/bash
# diy-part1.sh - 添加第三方软件源

# Argon 主题配置面板 — 直接克隆到 package 目录
# 该包不在任何 feed 中，需手动添加
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
