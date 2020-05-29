BETAFLIGHT_VERSION = 4.2.0-RC3
BAYLANDS_RELEASE = 1
TARGETS = STM32F405 STM32F7X2
REVISION = $(shell git log -1 --format="%h")
EXPECTED_VERSION_CHANGES = " 2 files changed, 4 insertions(+), 4 deletions(-)"

ifneq ($(OS),Windows_NT)
    UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		OPEN_AFTER_BUILD = true
	endif
endif

betaflight/.git:
	@echo ... Initializing git submodule
	@git submodule init
	@echo ... ... ✅

.PHONY:clean
clean:
	@echo ... Resetting submodule
	@git submodule update
	@cd betaflight && git restore .
	@echo ... ... ✅

.PHONY:sdk_install
sdk_install:
	@echo ... Installing SDK if necessary
	@cd betaflight && $(MAKE) arm_sdk_install
	@echo ... ... ✅

.PHONY:prepare
prepare: betaflight/.git clean sdk_install

.PHONY:patch
patch:
	@echo ... Applying patches
	@cd betaflight && for patch in ../patches/$(BETAFLIGHT_VERSION)/*; do \
		git am $${patch}; \
	done
	@echo ... ... ✅

.PHONY:version
version:
	@echo ... Patching version
	@cd betaflight && sed -i '' "s/^\(FC_VER :=.*FC_VER_PATCH.\)$$/\1-BAYLANDS$(BAYLANDS_RELEASE)/g" Makefile; \
	sed -i '' "s/^\(#define FC_VERSION_STRING .*FC_VERSION_PATCH_LEVEL.\)$$/\1 \"-BAYLANDS$(BAYLANDS_RELEASE)\"/g" src/main/build/version.h; \
	sed -i '' "s/^REVISION \:=.*/REVISION := $(REVISION)/g" Makefile; \
	[[ "$$(git diff --shortstat)" == $(EXPECTED_VERSION_CHANGES) ]] || (echo "... ... failed"; exit 1)
	@echo ... ... ✅

.PHONY:build
build:
	@echo Making $(TARGETS)
	@cd betaflight && make $(TARGETS)

ifeq ($(OPEN_AFTER_BUILD),true)
	@open betaflight/obj/
endif

	@echo ... ... ✅

.PHONY:release
release: prepare patch version build
