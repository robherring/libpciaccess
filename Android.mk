# Copyright (C) 2015 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

PCI_IDS := hwdata/pci.ids
PCI_IDS_GZ := $(TARGET_OUT_VENDOR)/etc/$(PCI_IDS).gz

$(PCI_IDS_GZ): $(LOCAL_PATH)/$(PCI_IDS) | $(MINIGZIP)
	$(hide) mkdir -p $(@D) && $(MINIGZIP) -9 < $< > $@

LOCAL_MODULE := libpciaccess
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_ADDITIONAL_DEPENDENCIES := $(PCI_IDS_GZ)

LOCAL_SRC_FILES := \
    src/common_bridge.c \
    src/common_capability.c \
    src/common_device_name.c \
    src/common_init.c \
    src/common_interface.c \
    src/common_io.c \
    src/common_iterator.c \
    src/common_map.c \
    src/common_vgaarb.c \
    src/linux_devmem.c \
    src/linux_sysfs.c \

LOCAL_CFLAGS := \
    -DHAVE_ZLIB \
    -DHAVE_STDINT_H \
    -DHAVE_STRING_H \
    -DPCIIDS_PATH=\"/etc/hwdata\" \
    -Wno-unused-parameter \
    -Wno-error

LOCAL_EXPORT_C_INCLUDE_DIRS := \
    $(LOCAL_PATH)/include \

LOCAL_C_INCLUDES := \
    external/zlib \
    $(LOCAL_EXPORT_C_INCLUDE_DIRS) \

LOCAL_SHARED_LIBRARIES := libz

include $(BUILD_SHARED_LIBRARY)
