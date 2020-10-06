export OPENWRT_VARS=1

ifeq ($(SDK),1)
  include $(TOPDIR)/include/version.mk
else
  REVISION:=$(shell $(TOPDIR)/scripts/getver.sh)
  SOURCE_DATE_EPOCH:=$(shell $(TOPDIR)/scripts/get_source_date_epoch.sh)
endif

HOSTCC ?= $(CC)
export REVISION
export SOURCE_DATE_EPOCH
export GIT_CONFIG_PARAMETERS='core.autocrlf=false'
export GIT_ASKPASS:=/bin/true
export MAKE_JOBSERVER=$(filter --jobserver%,$(MAKEFLAGS))
export GNU_HOST_NAME:=$(shell $(TOPDIR)/scripts/config.guess)
export HOST_OS:=$(shell uname)
export HOST_ARCH:=$(shell uname -m)

# prevent perforce from messing with the patch utility
unexport P4PORT P4USER P4CONFIG P4CLIENT

# prevent user defaults for quilt from interfering
unexport QUILT_PATCHES QUILT_PATCH_OPTS

unexport C_INCLUDE_PATH CROSS_COMPILE ARCH

# prevent distro default LPATH from interfering
unexport LPATH

# make sure that a predefined CFLAGS variable does not disturb packages
export CFLAGS=
export LDFLAGS=

empty:=
space:= $(empty) $(empty)
path:=$(subst :,$(space),$(PATH))
path:=$(filter-out .%,$(path))
path:=$(subst $(space),:,$(path))
export PATH:=$(path)

unexport TAR_OPTIONS

ifneq ($(shell $(HOSTCC) 2>&1 | grep clang),)
  export HOSTCC_REAL?=$(HOSTCC)
  export HOSTCC_WRAPPER:=$(TOPDIR)/scripts/clang-gcc-wrapper
else
  export HOSTCC_WRAPPER:=$(HOSTCC)
endif

SCAN_COOKIE?=$(shell echo $$$$)
export SCAN_COOKIE
