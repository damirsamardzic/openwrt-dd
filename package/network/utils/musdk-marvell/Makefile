include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

GIT_URL:=https://github.com/MarvellEmbeddedProcessors/musdk-marvell.git
GIT_BRANCH:=musdk-armada-17.10
GIT_HASH:=$(shell echo `git ls-remote $(GIT_URL) $(GIT_BRANCH)` | sed -e 's/ .*//')

PKG_NAME:=musdk-marvell
PKG_VERSION:=$(shell echo $(GIT_BRANCH)|cut -d'-' -f3)
PKG_RELEASE:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=$(GIT_URL)
PKG_SOURCE_VERSION:=$(GIT_HASH)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=Damir Samardzic <damir.samardzic@sartura.hr>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
PKG_FORTIFY_SOURCE:=2

include $(INCLUDE_DIR)/package.mk

DISABLE_NLS=

CONFIGURE_ARGS += --enable-shared=no --enable-sam --enable-sam-statistics --enable-bpool-dma=64  \
	CROSS_COMPILE=$(TARGET_CROSS) KDIR=$(LINUX_DIR)

TARGET_CFLAGS+= -O0
MAKE_FLAGS += KDIR=$(LINUX_DIR)
MAKE_FLAGS += --trace

define Package/musdk-marvell
	TITLE:=MUSDK
	SECTION:=Marvell
	CATEGORY:=Marvell
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	( cd $(PKG_BUILD_DIR) ; \
		[ -f ./configure ] || { \
			./bootstrap ; \
		} \
	)
endef

define Build/Compile
	$(call Build/Compile/Default)
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/modules/uio" \
		modules
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/modules/pp2" \
		modules
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/modules/sam" \
		modules
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/modules/dmax2" \
		modules
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		SUBDIRS="$(PKG_BUILD_DIR)/modules/neta" \
		modules
endef

define Package/musdk-marvell/install
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)
	$(CP) $(PKG_BUILD_DIR)/modules/uio/*.ko $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/modules/pp2/*.ko $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/modules/sam/*.ko $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/modules/dmax2/*.ko $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/modules/neta/*.ko $(PKG_INSTALL_DIR)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,musdk-marvell))
