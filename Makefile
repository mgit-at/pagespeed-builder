DISTRO := debian
CODENAME := buster
VERSION := 1.13.35.2-stable

.PHONY: image build

all: image build

image:
	@sed 's/^FROM.*/FROM $(DISTRO):$(CODENAME)/' Dockerfile > "Dockerfile.$(DISTRO)-$(CODENAME)"
	@sudo docker build -f "Dockerfile.$(DISTRO)-$(CODENAME)" -t "mgit/pagespeed-builder:$(DISTRO)-$(CODENAME)" .

build:
	@mkdir -p "build/$(VERSION)/$(DISTRO)/$(CODENAME)"
	@sudo docker run --rm -v "$(CURDIR)/build/$(VERSION)/$(DISTRO)/$(CODENAME):/srv/build" "mgit/pagespeed-builder:$(DISTRO)-$(CODENAME)" "$(VERSION)"
