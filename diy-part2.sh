#!/bin/bash
# diy-part2.sh - 自定义默认设置

# 默认 IP 改为 192.168.123.1
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate

# 默认密码改为 password（实际为空，需要首次登录后设置）
# Lean LEDE 默认密码是 password，无需修改

# 增加内核分区大小（R3G 128M flash 够用）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
echo 'CONFIG_TARGET_KERNEL_PARTSIZE=4' >> .config
sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo 'CONFIG_TARGET_ROOTFS_PARTSIZE=120' >> .config
