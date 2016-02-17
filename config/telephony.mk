# APNS
$(call inherit-product, vendor/minimal/config/common_apn.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Stk
