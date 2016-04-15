TARGET =: clang
ARCHS = armv7 armv7s arm64
DEBUG = 0
GO_EASY_ON_ME = 1

THEOS_PACKAGE_DIR_NAME = debs
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libkarenprefs
libkarenprefs_FILES = $(wildcard *.m)
libkarenprefs_LIBRARIES = prefs
libkarenprefs_LDFLAGS = -F$(SYSROOT)/System/Library/PrivateFrameworks -weak_framework Preferences

include $(THEOS_MAKE_PATH)/library.mk

install-to-theos:: all
	@cp -v .theos/$(THEOS_OBJ_DIR_NAME)/libkarenprefs.dylib $(THEOS)/lib/
	@mkdir -pv $(THEOS)/include/KarenPrefs/
	@cp -v *.h $(THEOS)/include/KarenPrefs/

after-install::
	install.exec "killall Preferences; exit 0"
