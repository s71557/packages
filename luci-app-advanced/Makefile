# Copyright (C) 2019  sirpdboy <https://github.com/sirpdboy/luci-app-advanced/>
# 
#
#
# This is free software, licensed under the Apache License, Version 2.0 .
# 

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/package.mk

PKG_NAME:=luci-app-advanced
PKG_VERSION:=1.20
PKG_RELEASE:=20220218
define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  DEPENDS:=
   TITLE:=LuCI Support for advanced
   PKGARCH:=all
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/advanced $(1)/etc/config/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
