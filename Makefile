# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BUILD_DIR=./bin
BINARY_NAME=happynum_cli
BINARY_LINUX=$(BINARY_NAME)_linux
BINARY_DARWIN=$(BINARY_NAME)_darwin
BINARY_WINDOWS=$(BINARY_NAME)_windows
GIT_TAG=`git describe --tags`

all: test build
test:
		$(GOTEST) -v ./...
clean:
		$(GOCLEAN)
		rm -f $(BINARY_NAME)
		rm -f $(BINARY_UNIX)
# deps:
# 		$(GOGET) github.com/jjmark15/


# Cross compilation
build-linux-amd64:
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -ldflags "-X main.tagVersion=$(GIT_TAG)" -o $(BUILD_DIR)/$(BINARY_LINUX)_amd64_$(GIT_TAG) -v ./happynum_cli
build-linux-arm64:
		CGO_ENABLED=0 GOOS=linux GOARCH=arm64 $(GOBUILD) -ldflags "-X main.tagVersion=$(GIT_TAG)" -o $(BUILD_DIR)/$(BINARY_LINUX)_arm64_$(GIT_TAG) -v ./happynum_cli
build-darwin-amd64:
		CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GOBUILD) -ldflags "-X main.tagVersion=$(GIT_TAG)" -o $(BUILD_DIR)/$(BINARY_DARWIN)_amd64_$(GIT_TAG) -v ./happynum_cli
build-windows-amd64:
		CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) -ldflags "-X main.tagVersion=$(GIT_TAG)" -o $(BUILD_DIR)/$(BINARY_WINDOWS)_amd64_$(GIT_TAG).exe -v ./happynum_cli

build-all: build-linux-amd64 build-linux-arm64 build-darwin-amd64 build-windows-amd64