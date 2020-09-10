
# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

# includes
include ./boilerplate/help.mk
include ./boilerplate/go.mk


# examples of how to override in root make file
override GO_FSPATH = $(PWD)
override GO_BUILD_OUT_FSPATH = $(GOPATH)/bin
override GO_BUILD_OUT_ALL_FSPATH = $(PWD)/targets
override BS_ROOT_FSPATH = XXX
override GO_ARCH=go-arch_override
override GO_BIN_NAME=bs

STATIK_DEST = $(PWD)/statiks

.PHONY: help this-statiks this-scan-statiks this-build

## Print all settings
this-print:
	$(MAKE) go-print


## Build this.
this-build: this-statiks
	$(MAKE) go-build

## Build for all arch and platforms
this-build-all: this-statiks
	$(MAKE) go-build-all

## Delete all of the builds
this-build-clean-all:
	$(MAKE) go-build-clean-all

## Delete the build.
this-build-clean:
	$(MAKE) go-build-clean
	# delete all generated stuff
	rm -rf $(PWD)/statiks

this-statiks:
	go run sdk/cmd/bp/main.go -t $(PWD)/.tmp -o $(PWD)/statiks


TEST_FSPATH=_testrepo

## Run Test 
this-test-run:
	mkdir -p $(TEST_FSPATH)

	## BS help
	bs -h

	## --- BS INFO --
	bs info -h
	bs info

	## --- BS INIT --
	bs init -h
	cd $(TEST_FSPATH) && bs init ./boilerplate

	## --- BS LIST --
	#  Lists tools installed on any OS mapped paths (e.g go bin or os level)
	bs list

	## --- BS PKG --
	#  Install and manage the tools
	bs pkg 
	bs pkg rigs -h

	
	bs pkg search lang
	#bs pkg search *

	bs pkg update all



## Clean Test
this-test-clean:
	rm -rf $(TEST_FSPATH)