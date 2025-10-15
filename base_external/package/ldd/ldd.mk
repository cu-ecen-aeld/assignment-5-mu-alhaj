##############################################################
#
# LDD Package
#
##############################################################

LDD_VERSION = d454a8fc28bb532716dacdd348f11c6ceb52f84b
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-mu-alhaj.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

# Directories containing kernel modules
LDD_MODULE_SUBDIRS = scull misc-modules

# Build as kernel module package
$(eval $(kernel-module))

# Install helper scripts and modules
define LDD_POST_BUILD
    # Install scull helpers
    $(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin
    $(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin

    # Install misc-module helpers
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin

    # Install kernel modules into /lib/modules/<kernel-version>/
    $(INSTALL) -m 0644 $(@D)/scull/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/
    $(INSTALL) -m 0644 $(@D)/misc-modules/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/

    # Update module dependencies
    $(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
endef

LDD_POST_BUILD_HOOKS += LDD_POST_BUILD

$(eval $(generic-package))

