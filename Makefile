ROOT:=$(shell git rev-parse --show-toplevel)

all: clean patch build bundle

patch:
	[ -f "$(ROOT)/droidcam-obs-plugin/linux/linux.mk.bak" ] || sed -i.bak \
		-e 's/LIBUSBMUXD     ?= libusbmuxd$/LIBUSBMUXD     ?= libusbmuxd-2.0/' \
		-e 's/LIBIMOBILEDEV  ?= libimobiledevice$/LIBIMOBILEDEV  ?= libimobiledevice-1.0/' \
		$(ROOT)/droidcam-obs-plugin/linux/linux.mk

build:
	cd $(ROOT)/droidcam-obs-plugin/ \
		&& mkdir -p build \
		&& make

bundle:
	mkdir -p $(ROOT)/droidcam-plugin/bin/64bit/ \
		&& cp -R $(ROOT)/droidcam-obs-plugin/data $(ROOT)/droidcam-plugin/ \
		&& cp $(ROOT)/droidcam-obs-plugin/build/*.so $(ROOT)/droidcam-plugin/bin/64bit/droidcam-plugin.so

clean:
	rm -rf $(ROOT)/droidcam-obs-plugin/build || true
	rm -rf $(ROOT)/droidcam-plugin || true
