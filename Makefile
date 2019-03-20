VERSION ?= 6.12.0
DOCKER_TAG ?= pmd-$(USER)
SHA256SUM := $(shell which sha256sum || which gsha256sum)

.PHONY: build
build:
	docker build --build-arg VERSION=$(VERSION) . -t $(DOCKER_TAG)

.PHONY: run
run: build
	docker run --rm $(DOCKER_TAG) --help

# Downloads latest pmd zip
pmd-bin-$(VERSION).zip:
	curl -L -o pmd-bin-$(VERSION).zip https://github.com/pmd/pmd/releases/download/pmd_releases%2F$(VERSION)/pmd-bin-$(VERSION).zip

# Generates new sha256 for this version file
pmd-bin-$(VERSION).zip.sha256: pmd-bin-$(VERSION).zip
	$(SHA256SUM) pmd-bin-$(VERSION).zip > pmd-bin-$(VERSION).zip.sha256

# Checks that the downloaded file matches the sha sum
.PHONY: check
check: 
	$(SHA256SUM) -c pmd-bin-$(VERSION).zip.sha256

# Updates PMD and generates a new sha
.PHONY: update
update: clean pmd-bin-$(VERSION).zip.sha256 check

# Cleans all zips and shas
.PHONY: clean
clean:
	rm -f pmd-bin-*.zip pmd-bin-*.zip.sha256

# Creates a git tag for the current pmd version
.PHONY: tag
tag:
	git tag -v $(VERSION)
