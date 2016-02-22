# Copyright (C) 2016 Minimal OS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

include vendor/minimal/config/bootanimation.mk

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/minimal/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/minimal/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/minimal/prebuilt/common/bin/50-minimal.sh:system/addon.d/50-minimal.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/minimal/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Minimal-specific init file
PRODUCT_COPY_FILES += \
    vendor/minimal/prebuilt/common/etc/init.local.rc:root/init.minimal.rc

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

PRODUCT_COPY_FILES += \
    vendor/minimal/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/minimal/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    Launcher3 \
    su

# Optional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker

# Extra Optional packages
PRODUCT_PACKAGES += \
    LatinIME \
    BluetoothExt

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/minimal/overlay/common

# Versioning System
PRODUCT_VERSION_MAJOR = 6.0.1
PRODUCT_VERSION_MINOR = alpha
PRODUCT_VERSION_MAINTENANCE = 0.1
ifdef MINIMAL_BUILD_EXTRA
    MINIMAL_POSTFIX := -$(MINIMAL_BUILD_EXTRA)
endif
ifndef MINIMAL_BUILD_TYPE
    MINIMAL_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif

ifeq ($(MINIMAL_BUILD_TYPE),DM)
    MINIMAL_POSTFIX := -$(shell date +"%Y%m%d")
endif

ifndef MINIMAL_POSTFIX
    MINIMAL_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

PLATFORM_VERSION_CODENAME := $(MINIMAL_BUILD_TYPE)

# Set all versions
MINIMAL_VERSION := MINIMAL-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(MINIMAL_BUILD_TYPE)$(MINIMAL_POSTFIX)
MINIMAL_MOD_VERSION := MINIMAL-$(MINIMAL_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(MINIMAL_BUILD_TYPE)$(MINIMAL_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.minimal.version=$(MINIMAL_VERSION) \
    ro.modversion=$(MINIMAL_MOD_VERSION) \
    ro.minimal.buildtype=$(MINIMAL_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/minimal/tools/process_props.py

