VERSION := 1.13.35.1-beta

.PHONY: image build

all: image build

image:
	@sudo docker build -t mgit/pagespeed-builder .

build:
	@mkdir -p "build/$(VERSION)"
	@sudo docker run --rm -v "$(CURDIR)/build/$(VERSION):/srv/build" mgit/pagespeed-builder "$(VERSION)"
