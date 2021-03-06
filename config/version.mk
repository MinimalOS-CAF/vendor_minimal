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

PRODUCT_VERSION_MAJOR = 6.0.1

ifndef MINIMAL_BUILD_TYPE
    MINIMAL_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(MINIMAL_BUILD_TYPE),OFFICIAL)
    MINIMAL_BUILD_TYPE := OFFICIAL
endif

ifndef MINIMAL_POSTFIX
    MINIMAL_POSTFIX := -$(shell date +"%Y%m%d")
endif

PLATFORM_VERSION_CODENAME := $(MINIMAL_BUILD_TYPE)

# Set all versions
MINIMAL_VERSION := minimal-$(PRODUCT_VERSION_MAJOR)-$(MINIMAL_BUILD_TYPE)$(MINIMAL_POSTFIX)
MINIMAL_MOD_VERSION := minimal-$(MINIMAL_BUILD)-$(PRODUCT_VERSION_MAJOR)-$(MINIMAL_BUILD_TYPE)$(MINIMAL_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.minimal.version=$(MINIMAL_VERSION) \
    ro.modversion=$(MINIMAL_MOD_VERSION) \
    ro.minimal.buildtype=$(MINIMAL_BUILD_TYPE)
