# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-geoip/pecl-geoip-1.0.2.ebuild,v 1.2 2007/12/06 01:07:37 jokey Exp $

PHP_EXT_NAME="perl"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="This extension embeds Perl Interpreter into PHP. It allows execute Perl files, evaluate Perl code, access Perl variables and instantiate Perl objects"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

need_php_by_category
