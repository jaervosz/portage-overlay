# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_BUILD="82143"
DESCRIPTION="The search engine for IT data"
HOMEPAGE="http://www.splunk.com"
REL_URI="http://download.splunk.com/releases/${PV}/"
SRC_URI="x86? ( ${REL_URI}/linux/${P}-${MY_BUILD}-Linux-i686.tgz )
    amd64? ( ${REL_URI}/linux/${P}-${MY_BUILD}-Linux-x86_64.tgz )"

LICENSE="splunk-eula"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

src_install() {
	insinto /opt/${PN}
	doins -r ${PN}/. || die "Install failed!"

	# Install init script
	doinitd "${FILESDIR}"/splunkd || die "doinitd failed"

	# Adjust permissions on executables
	cd "${D}/opt/${PN}/bin"
	for b in `ls .`; do
		fperms 755 "${b}" || die "fperms failed on ${b}"
	done
}

pkg_postinst() {
	einfo "Creating default configuration to monitor /var/log"
	# Need to start splunk to accept the license and build database
	/opt/${PN}/bin/splunk start --accept-license
	/opt/${PN}/bin/splunk stop

	elog "A default configuration has been created to monitor /var/log."
	elog ""
	elog "For more information about Splunk, please visit"
	elog "${HOMEPAGE}/doc/latest"
	elog ""
	elog "To add splunk to your startup scripts"
	elog "run 'rc-update add splunkd default'"
}
