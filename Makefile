export ARCHS = armv7 arm64
export TARGET = iphone:clang:10.3:10.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GoogleEnhancer

GoogleEnhancer_FILES = Tweak.xm
GoogleEnhancer_FRAMEWORKS = UIKit Foundation WebKit
GoogleEnhancer_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSafari"
