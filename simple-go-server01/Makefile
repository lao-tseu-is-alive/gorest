DOCKER_REGISTRY   ?= docker.io
IMAGE_PREFIX      ?= laotseu
SHORT_NAME        ?= simple-go-server01

# build options
GO        ?= go
TAGS      :=
LDFLAGS   := -w -s
GOFLAGS   :=
BINDIR    := $(CURDIR)/bin

.PHONY: all
all: build

.PHONY: build
build:
	GOBIN=$(BINDIR) $(GO) install $(GOFLAGS) -tags '$(TAGS)' -ldflags '$(LDFLAGS)'

.PHONY: clean
clean:
	@rm -rf $(BINDIR)

include versioning.mk