# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kwebkitpart/kwebkitpart-0.9.6.ebuild,v 1.1 2010/07/25 23:45:06 reavertm Exp $

#http://www.gentoo.org/proj/en/desktop/qt/qt4-based-ebuild-howto.xml
EAPI="2"

inherit qt4-r2

SLOT="1"
DESCRIPTION="Utility to provide Linux/Mac OS X support for the MobileAction i-gotU USB GPS travel loggers"
HOMEPAGE="https://launchpad.net/igotu2gpx"
#SRC_URI="http://launchpad.net/igotu2gpx/0.3/0.3.0/+download/igotu2gpx-0.3.0.tar.gz"
SRC_URI="http://launchpad.net/igotu2gpx/${PV:0:3}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/qt-gui:4
		dev-libs/boost
		>=dev-libs/libusb-0.1
		dev-libs/openssl"

src_configure() {
	conf_pch="CLEBS"
    eqmake4 \
	"${conf_pch}"
}
