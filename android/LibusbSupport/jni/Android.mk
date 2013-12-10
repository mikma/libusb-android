JNI_PATH := $(call my-dir)

LOCAL_PATH := $(JNI_PATH)/../../../libusb

LIBUSB_DESCRIBE := \"`git --git-dir "$(JNI_PATH)/../.git" describe --tags 2>/dev/null`\"

local_cflags := -I$(JNI_PATH) -std=gnu99 -Wall -Wundef -Wunused -Wstrict-prototypes -Werror-implicit-function-declaration -Wno-pointer-sign -DLIBUSB_DESCRIBE=$(LIBUSB_DESCRIBE)

local_src_files := \
	core.c \
	descriptor.c \
	io.c \
	sync.c \
	os/android_java.c \
	os/linux_usbfs.c \
	os/threads_posix.c \

#
# Build shared libusb library
#
include $(CLEAR_VARS)

LOCAL_MODULE := libusb
LOCAL_MODULE_FILENAME := libusb
LOCAL_CFLAGS := $(local_cflags)
LOCAL_SRC_FILES := $(local_src_files)
LOCAL_LDFLAGS := -Wl,-no-undefined

LOCAL_LDLIBS := -llog

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)

include $(BUILD_SHARED_LIBRARY)

#
# Build static libusb library
#
include $(CLEAR_VARS)

LOCAL_MODULE := libusb_static
LOCAL_MODULE_FILENAME := libusb
LOCAL_CFLAGS := $(local_cflags)
LOCAL_SRC_FILES := $(local_src_files)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)

include $(BUILD_STATIC_LIBRARY)
