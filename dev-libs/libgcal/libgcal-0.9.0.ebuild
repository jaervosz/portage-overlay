# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI=0

inherit eutils cmake-utils

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
SRC_URI="http://libgcal.googlecode.com/files/${PN}-${PV}.tar.gz"
LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64"
IUSE=""
DEPEND=">=dev-libs/libxml-1.8.17-r2
	>=net-misc/curl-7.18.2"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-${PV}"

src_configure() {
cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
