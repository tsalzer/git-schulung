#! /usr/bin/make -f
#
# Build the presentation

GOPATH = $(shell pwd)
PRESENT_BIN = bin/present
PRESENT = golang.org/x/tools/cmd/present

all: $(PRESENT_BIN)
	GOPATH=$(GOPATH) $(PRESENT_BIN)

$(PRESENT_BIN):
	mkdir -p src bin pkg
	GOPATH=$(GOPATH) go get $(PRESENT)
	GOPATH=$(GOPATH) go install $(PRESENT)
	test -f $(PRESENT_BIN)

docker:
	docker build -t git-schulung .
