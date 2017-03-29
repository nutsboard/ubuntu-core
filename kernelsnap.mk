include common.mk

KERNEL_SRC := $(KERNEL_DIR)/linux-am335x
KERNEL_BRANCH := nutsboard_ti_4.4.32_1.0.0_ga
KERNEL_COMMIT := `git ls-remote https://github.com/nutsboard/linux-am335x.git $(KERNEL_BRANCH) | awk '{print $$1}'`
KERNEL_ARCHIVE := https://github.com/nutsboard/linux-am335x/archive/$(KERNEL_COMMIT).tar.gz

FW_PATH := $(KERNEL_DIR)/firmware.tar
FW_URL := https://github.com/nutsboard/firmware/raw/master/firmware.tar

all: build

clean:
	rm -f nutsboard-kernel*.snap
	cd $(KERNEL_DIR); snapcraft clean
	rm -rf $(KERNEL_SRC)
	rm -rf $(FW_PATH)

distclean: clean
	rm -rf $(KERNEL_SRC)
	rm -rf $(FW_PATH)

build: kernel_src firmware
	cd $(KERNEL_DIR); snapcraft --target-arch armhf snap
	mv $(KERNEL_DIR)/$(KERNEL_SNAP) $(OUTPUT_DIR)

kernel_src:
	if [ ! -f $(KERNEL_SRC)/Makefile ] ; then \
		curl -L $(KERNEL_ARCHIVE) | tar xz && \
		mv linux-am335x-* $(KERNEL_SRC) ; \
	fi

firmware:
	if [ ! -f $(FW_PATH) ] ; then \
		wget $(FW_URL) -O $(FW_PATH) ; \
	fi


.PHONY: build
