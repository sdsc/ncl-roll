PKGROOT            = /opt/ncl
NAME               = ncl
VERSION            = 6.1.2
RELEASE            = 0
TARBALL_POSTFIX    = tgz

SRC_SUBDIR         = ncl

SOURCE_NAME        = ncl_ncarg
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

SZIP_NAME          = szip
SZIP_VERSION       = 2.1
SZIP_SUFFIX        = tar.gz
SZIP_PKG           = $(SZIP_NAME)-$(SZIP_VERSION).$(SZIP_SUFFIX)
SZIP_DIR           = $(SZIP_PKG:%.$(SZIP_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG) $(SZIP_PKG)