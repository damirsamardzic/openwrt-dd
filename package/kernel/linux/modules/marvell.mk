define KernelPackage/crypto-safexcel
  TITLE:=SAFEXCEL Crypto module
  SUBMENU:=Marvell
  KCONFIG:=CONFIG_CRYPTO_DEV_SAFEXCEL
  FILES:=$(LINUX_DIR)/drivers/crypto/inside-secure/crypto_safexcel.ko
endef

$(eval $(call KernelPackage,crypto-safexcel))

