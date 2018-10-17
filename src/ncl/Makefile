# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzanita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_MPI); \
	  $(DESCRIBE_HDF4); \
	  $(DESCRIBE_HDF5); \
	  $(DESCRIBE_NETCDF) \
	) > $@

LICENSE: $(SRC_DIRS)
	cp szip*/COPYING $(SOURCE_DIR)/szip-COPYING
	cp szip*/INSTALL $(SOURCE_DIR)/szip-INSTALL
	cp license-files/NCL_source_license.shtml $(SOURCE_DIR)/
	$(CHECK_LICENSE_FILES)
	echo NCL and others > $@

build: $(SRC_DIRS)
	patch $(SOURCE_DIR)/Configure patch-files/Configure.patch
	patch $(SOURCE_DIR)/config/LINUX patch-files/LINUX.patch
	perl -pi -e "s!ROLLNCL!$(PKGROOT)!g" $(SOURCE_DIR)/Configure
	perl -pi -e "s!ROLLSZIP!$(PWD)/szip!g" $(SOURCE_DIR)/config/LINUX
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MPI); \
	  $(MODULE_LOAD_HDF4); \
	  $(MODULE_LOAD_HDF5); \
	  $(MODULE_LOAD_NETCDF); \
	  perl -pi -e "s!ROLLNETCDF!$${NETCDFHOME}!g" $(SOURCE_DIR)/config/LINUX; \
	  perl -pi -e "s!ROLLNETCDF!$${NETCDFHOME}!g" $(SOURCE_DIR)/Configure; \
	  perl -pi -e "s!ROLLHDF4!$${HDF4HOME}!g" $(SOURCE_DIR)/Configure; \
	  perl -pi -e "s!ROLLHDF4!$${HDF4HOME}!g" $(SOURCE_DIR)/config/LINUX; \
	  perl -pi -e "s!ROLLHDF5!$${HDF5HOME}!g" $(SOURCE_DIR)/config/LINUX; \
	  perl -pi -e "s!ROLLMPI!$${MPIHOME}!g" $(SOURCE_DIR)/config/LINUX; \
	  mkdir szip; \
	  cd $(SZIP_DIR); \
	  ./configure --prefix=$(PWD)/szip; \
	  make; \
	  make install \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	$(PKGROOT_BIND_MOUNT)
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MPI); \
	  $(MODULE_LOAD_HDF4); \
	  $(MODULE_LOAD_HDF5); \
	  $(MODULE_LOAD_NETCDF); \
	  cd $(SOURCE_DIR); \
	  ./Configure; \
	  make Everything \
	)
	$(PKGROOT_BIND_UMOUNT)
	cp -r szip/* $(ROOT)/$(PKGROOT)/
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) $(SZIP_DIR) DESCRIPTION LICENSE
