APP ?= $(shell basename $(PWD))
REPO ?= $(shell git config --get remote.origin.url | sed 's,^http.*//,,;s,^.*@,,;s,:,/,;s,\.git$,,')
TAG ?= $(shell git rev-parse HEAD)-dev
BUILD_DATE := $(shell date +%FT%T%z)
BUILD_EXTRA ?= "-o ./bin/$(APP) ./cmd/$(APP)"

# Build the main binary.
build:
	@mkdir -p ./bin
	go build -ldflags '-s -X $(REPO)/version.Commit=$(TAG) -X $(REPO)/version.BuildDate=$(BUILD_DATE)' $(BUILD_EXTRA)

# Produce checksums for built binaries.
checksums:
	cd ./bin/; sha256sum $(APP)* > SHA256SUMS

# Run all tests.
test:
	@go test -race -cover `go list ./... | grep -v vendor`

# Remove build files.
clean:
	rm -rf ./bin
