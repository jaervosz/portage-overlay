# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/pim"
inherit kde4-base

DESCRIPTION="Google contacts and calendar akonadi resource"
HOMEPAGE="http://kde.org/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=">=dev-util/cmake-2.6.0
	>=dev-libs/libgcal-0.9.0"
