BUILD_STEPS := u-boot kernelsnap gadget snappy

all: build

pre-u-boot:
pre-linux:
pre-gadget:
pre-kernelsnap:
pre-snappy:

define BUILD_STEPS_TEMPLATE
build-$(1): pre-$(1)
	$$(MAKE) -f $(1).mk build
clean-$(1):
	$$(MAKE) -f $(1).mk clean
distclean-$(1):
	$$(MAKE) -f $(1).mk distclean
.PHONY: pre-$(1) build-$(1) clean-$(1) distclean-$(1)
endef

$(foreach step,$(BUILD_STEPS),$(eval $(call BUILD_STEPS_TEMPLATE,$(step))))

build: $(addprefix build-,$(BUILD_STEPS))

clean: $(addprefix clean-,$(BUILD_STEPS))

distclean: $(addprefix distclean-,$(BUILD_STEPS))

gadget: build-gadget

u-boot: build-u-boot

kernelsnap: build-kernelsnap

snappy: build-snappy

.PHONY: all build clean distclean gadget u-boot kernelsnap snappy
