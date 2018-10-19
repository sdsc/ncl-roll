ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-ncl
VERSION        = 6.5.0
RELEASE        = 0
PKGROOT        = /opt/ncl

SRC_SUBDIR     = ncl

SOURCE_NAME    = ncl
SOURCE_SUFFIX  = zip
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

SZIP_NAME      = szip
SZIP_SUFFIX    = tar.gz
SZIP_VERSION   = 2.1.1
SZIP_PKG       = $(SZIP_NAME)-$(SZIP_VERSION).$(SZIP_SUFFIX)
SZIP_DIR       = $(SZIP_PKG:%.$(SZIP_SUFFIX)=%)

TRIANGLE_NAME      = triangle
TRIANGLE_SUFFIX    = zip
TRIANGLE_VERSION   = 1.6
TRIANGLE_PKG       = $(TRIANGLE_NAME)-$(TRIANGLE_VERSION).$(TRIANGLE_SUFFIX)
TRIANGLE_DIR       = $(TRIANGLE_PKG:%.$(TRIANGLE_SUFFIX)=%)

ZIP_PKGS       = $(SOURCE_PKG) $(TRIANGLE_PKG)
TAR_GZ_PKGS    = $(SZIP_PKG)

RPM.EXTRAS     = AutoReq:No\nAutoProv:No
RPM.PREFIX     = $(PKGROOT)
