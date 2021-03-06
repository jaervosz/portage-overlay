# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/b2evolution/b2evolution-2.4.0_rc2.ebuild,v 1.3 2008/02/22 15:43:09 hollow Exp $

inherit webapp eutils depend.php

MY_EXT="stable-2011-03-23"
MY_PV=${PV/_/-}

DESCRIPTION="Multilingual multiuser multi-blog engine"
HOMEPAGE="http://www.b2evolution.net"
SRC_URI="mirror://sourceforge/evocms/${PN}-${MY_PV}-${MY_EXT}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/${PN}"

pkg_setup() {
	webapp_pkg_setup
	has_php
	if [[ ${PHP_VERSION} == "4" ]]; then
		require_php_with_use expat tokenizer mysql
	else
		require_php_with_use curl ctype xml tokenizer mysql
	fi
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r blogs/*

	rm doc/*.*-*.html doc/*.src.html
	dohtml doc/*.html

	webapp_serverowned "${MY_HTDOCSDIR}"
	webapp_serverowned "${MY_HTDOCSDIR}"/conf/_basic_config.template.php
	webapp_configfile "${MY_HTDOCSDIR}"/conf/_{basic_config.template,advanced,locales,formatting,admin,stats,application}.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}
