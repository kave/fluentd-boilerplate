SHA1 ?= $(shell git rev-parse HEAD)
image_name := fluentd
version := 1.11

define build_image
docker build --tag custom-$(image_name)-$(version):latest .
endef

image-latest:
	$(call build_image)

image: image-latest