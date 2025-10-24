##############################################################
#
# LDD Package
#
##############################################################

AESDCHAR_VERSION = 42fffd56b58bbc979a7a8f2ab738b1025cc08d3b
AESDCHAR_SITE = git@github.com:cu-ecen-aeld/assignment-7-mu-alhaj.git
AESDCHAR_SITE_METHOD = git
AESDCHAR_GIT_SUBMODULES = YES

# Directories containing kernel modules
AESDCHAR_MODULE_SUBDIRS = aesd-char-driver

# Build as kernel module package
$(eval $(kernel-module))

# Install helper scripts and modules
define LDD_POST_BUILD
    # Install scull helpers
    $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin
    $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin

    # Install misc-module helpers
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin

    # Install kernel modules into /lib/modules/<kernel-version>/
    $(INSTALL) -m 0644 $(@D)/aesd-char-driver/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/

    # Update module dependencies
    $(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
endef

AESDCHAR_POST_BUILD_HOOKS += AESDCHAR_POST_BUILD

$(eval $(generic-package))

