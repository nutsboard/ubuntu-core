include common.mk

UBOOT_BRANCH := nutsboard-v2016.05
UBOOT_COMMIT := `git ls-remote https://github.com/nutsboard/u-boot-am335x.git $(UBOOT_BRANCH) | awk '{print $$1}'`
UBOOT_ARCHIVE := https://github.com/nutsboard/u-boot-am335x/archive/$(UBOOT_COMMIT).tar.gz
UBOOT_DEFCONFIG := nutsboard_almond_defconfig
all: build

clean:
	if test -d "$(UBOOT_SRC)/u-boot-am335x" ; then $(MAKE) ARCH=arm CROSS_COMPILE=${CC} -C $(UBOOT_DIR)/u-boot-am335x clean ; fi
	rm -f $(UBOOT_BIN)
	rm -rf $(wildcard $(UBOOT_DIR))

distclean: clean
	rm -rf $(wildcard $(UBOOT_DIR/u-boot-am335x))

build: src
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=${CC} -C $(UBOOT_DIR)/u-boot-am335x $(UBOOT_DEFCONFIG)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=${CC} -C $(UBOOT_DIR)/u-boot-am335x -j$(CPUS) all

src:
	mkdir -p $(UBOOT_DIR)
	if [ ! -f $(UBOOT_DIR)/u-boot-am335x/Makefile ] ; then \
		curl -L $(UBOOT_ARCHIVE) | tar xz && \
		mv u-boot-am335x-* $(UBOOT_DIR)/u-boot-am335x ; \
	fi

u-boot: $(UBOOT_BIN)


.PHONY: build
