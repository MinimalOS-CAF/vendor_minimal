# APNS
$(call inherit-product, vendor/aospb/config/common_apn.mk)

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Stk
