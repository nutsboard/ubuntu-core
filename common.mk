OUTPUT_DIR := $(PWD)
IMAGE_MODEL := $(OUTPUT_DIR)/model/nutsboard.model
GADGET_DIR := $(OUTPUT_DIR)/gadget
GADGET_VERSION := $(grep version $(GADGET_DIR)/meta/snap.yaml | awk '{print $2}')
GADGET_SNAP := nutsboard-gadget_16.04-1_armhf.snap
KERNEL_DIR := $(OUTPUT_DIR)/kernel
KERNEL_VERSION := $(cat $(KERNEL_DIR)/prime/meta/snap.yaml | grep version: | awk '{print $2}')
KERNEL_SNAP := nutsboard-kernel_4.4.32_armhf.snap

UBOOT_DIR := $(OUTPUT_DIR)/u-boot
ARCH := arm
TOOLCHAIN := DEB
ifeq ($(TOOLCHAIN),VENDOR)
CC :=
else
CC := arm-linux-gnueabihf-
endif
CPUS := $(shell getconf _NPROCESSORS_ONLN)
