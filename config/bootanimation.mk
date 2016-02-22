ifneq ($(filter minimal_falcon minimal_osprey minimal_titan,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/minimal/prebuilt/bootanimation/720.zip:system/media/bootanimation.zip
endif 
ifneq ($(filter minimal_hammerhead minimal_lux,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/minimal/prebuilt/bootanimation/1080.zip:system/media/bootanimation.zip
endif 
ifneq ($(filter minimal_angler,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/minimal/prebuilt/bootanimation/1440.zip:system/media/bootanimation.zip
endif
