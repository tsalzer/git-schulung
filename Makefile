#! /usr/bin/make -f
#
# Build the presentation

GOPATH = $(shell pwd)
PRESENT_BIN = bin/present
PRESENT = golang.org/x/tools/cmd/present

RUN_PRESENT = run_present
RUN_PRESENT_BIN = bin/$(RUN_PRESENT)

all: $(PRESENT_BIN)
	GOPATH=$(GOPATH) $(PRESENT_BIN)

$(PRESENT_BIN):
	mkdir -p src bin pkg
	GOPATH=$(GOPATH) go get $(PRESENT)
	GOPATH=$(GOPATH) go install $(PRESENT)
	test -f $(PRESENT_BIN)

$(RUN_PRESENT_BIN):
	GOPATH=$(GOPATH) go install $(RUN_PRESENT)

docker: $(RUN_PRESENT_BIN)
	docker build -t git-schulung .

.PHONY: docker $(RUN_PRESENT_BIN)
