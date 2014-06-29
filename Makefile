export ARCHS = armv7 armv7s arm64
export SDKVERSION = 7.1
export THEOS_BUILD_DIR = build_dir

include theos/makefiles/common.mk

TWEAK_NAME = NoLockBounce
NoLockBounce_FILES = Tweak.xm
NoLockBounce_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
