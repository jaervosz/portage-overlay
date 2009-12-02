# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI=0

inherit eutils git

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
EGIT_REPO_URI="git://repo.or.cz/libgcal.git"
LICENSE="BSD"
SLOT="live"
KEYWORDS=""
IUSE=""
DEPEND=">=dev-libs/libxml-1.8.17-r2
	>=net-misc/curl-7.18.2"
RDEPEND="${DEPEND}"
#S="${WORKDIR}/libgcal-0.8"

src_unpack() {
        git_src_unpack
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
