# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: kde-misc/googledata-1.0 $

EAPI="3"

inherit kde4-base

MY_P="akonadi-${P}"
DESCRIPTION="Google contacts and calendar akonadi resource"

SRC_URI="http://libgcal.googlecode.com/files/${MY_P}.tar.bz2"
SLOT="4"
KEYWORDS="~amd64"

DEPEND=">=kde-base/akonadi-${KDE_MINIMAL}[kdeprefix=]
		>=app-pda/libgcal-0.9.6
		dev-libs/boost
		dev-libs/libxslt"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
