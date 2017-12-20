#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

GIT_URL:=https://github.com/MarvellEmbeddedProcessors/dpdk-marvell.git
GIT_BRANCH:=dpdk-17.05-armada-17.10
GIT_HASH:=$(shell echo `git ls-remote $(GIT_URL) $(GIT_BRANCH)` | sed -e 's/ .*//')

PKG_NAME:=dpdk-marvell
PKG_VERSION:=$(shell echo $(GIT_BRANCH)|cut -d'-' -f4)
PKG_RELEASE:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=$(GIT_URL)
PKG_SOURCE_VERSION:=$(GIT_HASH)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=Damir Samardzic <damir.samardzic@sartura.hr>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=+musdk-marvell

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

DISABLE_NLS=

# for debugging
#STRIP=/bin/true
#TARGET_CFLAGS+= -g
#MAKE_FLAGS += --trace

ifeq ($(ARCH),i386)
	TARGET=i686-native-linuxapp-gcc
endif
ifeq ($(ARCH),x86_64)
	TARGET=x86_64-native-linuxapp-gcc
endif
ifeq ($(ARCH),arm)
	TARGET=arm-armv7a-linuxapp-gcc
endif
ifeq ($(ARCH),aarch64)
	TARGET=arm64-armv8a-linuxapp-gcc
endif

MAKE_FLAGS += KDIR=$(LINUX_DIR) RTE_KERNELDIR=$(LINUX_DIR) RTE_TARGET=$(TARGET) \
	ARCH=$(LINUX_KARCH) HOSTCC=$(HOSTCC) LIBMUSDK_PATH=$(STAGING_DIR_ROOT)/usr prefix=/usr \
	kerneldir=/lib/modules/$(LINUX_VERSION)

define Package/dpdk-marvell
    TITLE:=Data Plane Development Kit (DPDK) for Marvell MUSDK
    SECTION:=net
    CATEGORY:=Network
    SUBMENU:=Marvell
    DEPENDS:=+musdk-marvell +python
endef

define Package/dpdk-marvell/description
Data Plane Development Kit (DPDK) is a set of libraries and drivers for fast packet processing.
Marvell Poll Mode Driver (PMD) is implemented based on Marvell User-Space SDK (MUSDK).
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR)/$(CONFIGURE_PATH)/$(strip $(3)); \
	$(MAKE) config T=$(TARGET); \
	)
endef

define Build/Compile
	$(call Build/Compile/Default)
	ln -sf $(PKG_BUILD_DIR)/build $(PKG_BUILD_DIR)/$(TARGET)
	$(call Build/Compile/Default, examples T=$(TARGET))
	cp -a $(PKG_BUILD_DIR)/examples/*/$(TARGET)/app/* $(PKG_BUILD_DIR)/build/app/
endef

define Package/dpdk-marvell/install
	find $(PKG_INSTALL_DIR) -name $(TARGET) | xargs rm -rf
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,dpdk-marvell))
