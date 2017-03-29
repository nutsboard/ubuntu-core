# U-Boot is flashed in NOR on Nitrogen platforms, so having a bootloader image
# doesn't make sense.
# Also, we want this image to work on all Nitrogen platforms so specifying only
# one bootloader isn't possible.
# So we create a stub environment but use our regular 6x_bootscript to do all
# the magic when booting.

include common.mk

UBOOT_SPL := $(UBOOT_DIR)/u-boot-am335x/MLO
UBOOT_BIN := $(UBOOT_DIR)/u-boot-am335x/u-boot.img

OEM_UBOOT_SPL := gadget/boot-assets/MLO
OEM_UBOOT_BIN := gadget/boot-assets/u-boot.img


all: build

clean:
	rm -rf $(OEM_UBOOT_SPL)
	rm -rf $(OEM_UBOOT_BIN)
	rm -f $(GADGET_DIR)/uboot.conf
	rm -f $(GADGET_DIR)/uboot.env

distclean: clean

u-boot:
	@if [ ! -f $(UBOOT_BIN) ] ; then echo "Build u-boot first."; exit 1; fi
	cp -f $(UBOOT_SPL) $(OEM_UBOOT_SPL)
	cp -f $(UBOOT_BIN) $(OEM_UBOOT_BIN)


preload: u-boot
	mkenvimage -r -s 8192 -o $(GADGET_DIR)/uboot.env $(GADGET_DIR)/uboot.env.in
	@if [ ! -f $(GADGET_DIR)/uboot.conf ]; then ln -s uboot.env $(GADGET_DIR)/uboot.conf; fi

snappy: preload
	snapcraft --target-arch armhf snap gadget

build: u-boot preload snappy

.PHONY: u-boot snappy gadget build preload
