# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ekeyd/ekeyd-1.1.3-r1.ebuild,v 1.1 2010/09/29 23:54:46 flameeyes Exp $

EAPI=2

inherit multilib 

MY_P="ekeyd"
MY_PV="1.1.3"
DESCRIPTION="EGD client from Entropy Key"
HOMEPAGE="http://www.entropykey.co.uk/"
SRC_URI="http://www.entropykey.co.uk/res/download/${MY_P}-${MY_PV}.tar.gz"

LICENSE="as-is" # yes, truly

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	dev-libs/luasocket"

S="${WORKDIR}/${MY_P}-${MY_PV}" 

src_prepare() {
	# - avoid using -Werror;
	# - don't gzip the man pages, this will also stop it from
	#   installing them, so we'll do it by hand.
	sed -i \
		-e 's:-Werror::' \
		-e '/gzip/d' \
		daemon/Makefile || die
}

src_compile() {
	local osname

	# Override automatic detection: upstream provides this with uname,
	# we don't like using uname.
	case ${CHOST} in
		*-linux-*)
			osname=linux;;
		*-freebsd*)
			osname=freebsd;;
		*-kfrebsd-gnu)
			osname=gnukfreebsd;;
		*-openbsd*)
			osname=openbsd;;
		*)
			die "Unsupported operating system!"
			;;
	esac

	# We don't slot LUA so we don't really need to have the variables
	# set at all.
	emake -C daemon \
		LUA_V= LUA_INC= \
		OSNAME=${osname} \
		OPT="${CFLAGS}" \
		BUILD_ULUSBD=$(use usb && echo yes || echo no) \
		egd-linux|| die "emake failed"
}

src_install() {
	dodir /usr/libexec
	cp "${S}/daemon/egd-linux" "${D}"/usr/libexec || die "Install failed!"
	# Install them manually because we don't want them gzipped
	doman daemon/${PN}.8 || die

	newconfd "${FILESDIR}"/${PN}.conf ${PN} || die
	newinitd "${FILESDIR}"/${PN}.init ${PN} || die
}

pkg_postinst() {
	elog "Sysctl write support have to be enabled in order for the init script to run:"
	elog "sysctl kernel.random.write_wakeup_threshold=$WATERMARK >/dev/null 2>&1"
}
