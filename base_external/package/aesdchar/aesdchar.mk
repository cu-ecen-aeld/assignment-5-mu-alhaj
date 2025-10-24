##############################################################
#
# LDD Package
#
##############################################################

AESDCHAR_VERSION = 42fffd56b58bbc979a7a8f2ab738b1025cc08d3b
AESDCHAR_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-mu-alhaj.git
AESDCHAR_SITE_METHOD = git
AESDCHAR_GIT_SUBMODULES = YES

# Directories containing kernel modules
AESDCHAR_MODULE_SUBDIRS = aesd-char-driver

# Build as kernel module package
$(eval $(kernel-module))

# Install helper scripts and modules
define AESDCHAR_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))

