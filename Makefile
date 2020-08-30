.PHONY: default
.DEFAULT_GOAL := default

BUILDFLAGS := -trimpath -tags forceposix -a $(BUILD_FLAG)
LDFLAGS    := -w -s -extldflags "-static"

GOENV   := GO111MODULE=on CGO_ENABLED=0
GO      := $(GOENV) go
GOBUILD := $(GO) build $(BUILDFLAGS) -ldflags '$(LDFLAGS)'

default: check all

all: linux windows osx

linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/qbtchangetracker-linux-amd64
	GOOS=linux GOARCH=386 $(GOBUILD) -o bin/qbtchangetracker-linux-386
	GOOS=linux GOARCH=arm $(GOBUILD) -o bin/qbtchangetracker-linux-arm
	GOOS=linux GOARCH=arm64 $(GOBUILD) -o bin/qbtchangetracker-linux-arm64

windows:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -o bin/qbtchangetracker-windows-amd64.exe
	GOOS=windows GOARCH=386 $(GOBUILD) -o bin/qbtchangetracker-windows-386.exe

osx:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o bin/qbtchangetracker-darwin-amd64

vet:
	$(GO) vet ./...

check: vet

clean:
	@rm -rf bin

