include common.mk

SNAPPY_IMAGE := ubuntu-core-nutsboard.img
DEFAULT_IMAGE := nutsboard.img
UBUNTU_CORE_CH := stable
UBUNTU_IMAGE=/snap/bin/ubuntu-image

all: build

clean:
	rm -rf $(DEFAULT_IMAGE)
distclean: clean

build-snappy:
	@echo "build snappy..."
	$(UBUNTU_IMAGE) \
		-c $(UBUNTU_CORE_CH) \
		--image-size 1G \
		--extra-snaps ./$(GADGET_SNAP) \
		--extra-snaps ./$(KERNEL_SNAP) \
		--extra-snaps bluez \
		--extra-snaps modem-manager \
		--extra-snaps snapweb \
		-O $(DEFAULT_IMAGE) \
		$(IMAGE_MODEL)

pack: build-snappy
	gzip $(DEFAULT_IMAGE)/$(DEFAULT_IMAGE)

build: build-snappy pack

.PHONY: build-snappy pack build
