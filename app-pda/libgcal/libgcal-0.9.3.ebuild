# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/libgcal-0.9.1$

EAPI=2

inherit eutils cmake-utils

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
SRC_URI="http://libgcal.googlecode.com/files/$P.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+google test"
DEPEND="google? ( app-misc/ca-certificates )
		test? ( app-pda/libopensync )
		dev-libs/libxml2
		net-misc/curl"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_configure() {
	mycmakeargs="$(cmake-utils_use_enable test TESTS)"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
