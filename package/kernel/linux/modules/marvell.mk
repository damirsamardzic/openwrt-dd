define KernelPackage/crypto-safexcel
  TITLE:=SAFEXCEL Crypto module
  SUBMENU:=Marvell
  KCONFIG:=CONFIG_CRYPTO_DEV_SAFEXCEL
  FILES:=$(LINUX_DIR)/drivers/crypto/inside-secure/crypto_safexcel.ko
endef

$(eval $(call KernelPackage,crypto-safexcel))

define KernelPackage/mvpp2x-sysfs
  TITLE:=Marvell Gigabit Ethernet driver
  SUBMENU:=Marvell
  KCONFIG:=CONFIG_MVPP2X_SYSFS
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/marvell/mvpp2x/sysfs/mvpp2x_sysfs.ko
endef

$(eval $(call KernelPackage,mvpp2x-sysfs))

