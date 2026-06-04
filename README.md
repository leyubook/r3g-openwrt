# 小米 R3G OpenWrt 固件 — 云编译

## 硬件信息

| 项目 | 规格 |
|------|------|
| 型号 | 小米路由器 3G V1 (MIR3G) |
| SoC | MediaTek MT7621A 双核 880MHz |
| RAM | 256MB DDR3 |
| Flash | 128MB SLC NAND |
| WiFi 2.4G | MT7603E |
| WiFi 5G | MT7612E |
| 网口 | 1×WAN + 2×LAN 全千兆 |
| USB | 1×USB 3.0 |

## 集成组件

| 分类 | 组件 |
|------|------|
| **WiFi 2.4G** | kmod-mt7603 (MT7603E) |
| **WiFi 5G** | kmod-mt76x2 (MT7612E) |
| **WiFi 协议栈** | kmod-cfg80211, kmod-mac80211, wpad-basic-wolfssl |
| **Android 手机 USB 网络** | kmod-usb-net-rndis, kmod-usb-net-cdc-ether, kmod-usb-net-cdc-ncm, kmod-usb-net-cdc-eem, kmod-usb-net-cdc-subset |
| **iPhone USB 网络** | kmod-usb-net-ipheth, libusbmuxd, libimobiledevice, usbmuxd |
| **华为手机 USB 网络** | kmod-usb-net-huawei-cdc-ncm |
| **4G/5G 上网卡** | kmod-usb-net-cdc-mbim, kmod-usb-net-qmi-wwan, kmod-usb-net-sierrawireless |
| **USB 串口 (4G网卡AT/GPS)** | kmod-usb-serial, kmod-usb-serial-option, kmod-usb-serial-wwan, kmod-usb-serial-qualcomm, kmod-usb-acm |
| **USB 有线网卡** | kmod-usb-net-asix, kmod-usb-net-asix-ax88179, kmod-usb-net-rtl8152 |
| **USB 主机 & 存储** | kmod-usb-core, kmod-usb2, kmod-usb3, kmod-usb-ohci, kmod-usb-storage, kmod-usb-storage-uas, kmod-fs-ext4/ntfs/vfat/exfat |
| **USB 工具** | usb-modeswitch, usbutils |
| **代理上网** | OpenClash |
| **去广告** | AdGuard Home |
| **语言** | LuCI 中文界面 (zh-cn) |

## 如何使用云编译

1. Fork 本仓库到自己的 GitHub
2. 进入 Actions 页面，启用 Workflows
3. 点击 "小米R3G OpenWrt 云编译" → Run workflow
4. 等待编译完成（约 2-3 小时），在 Artifacts 中下载固件

## 编译产物

- `openwrt-ramips-mt7621-xiaomi_mi-router-3g-squashfs-sysupgrade.bin` → OpenWRT 系统升级用
- `openwrt-ramips-mt7621-xiaomi_mi-router-3g-squashfs-kernel1.bin` → Breed 刷入用
- `openwrt-ramips-mt7621-xiaomi_mi-router-3g-squashfs-rootfs0.bin` → Breed 刷入用

## 连接手机 USB 共享网络

路由刷好固件后，将手机通过 USB 数据线连到 R3G 的 USB 口，手机开启 USB 网络共享，然后在 LuCI 中：

1. 网络 → 接口 → 添加新接口
2. 名称：`WAN_USB`，协议：DHCP 客户端
3. 设备选 `usb0`（或 `eth1`）
4. 防火墙区域选 `wan`

## 刷机说明

初次从原厂刷 OpenWrt 需要先获取 SSH，参考：
- 官方 Wiki: https://openwrt.org/toh/xiaomi/mi_router_3g
- 已刷 Breed 的可以直接从 Breed 刷入
