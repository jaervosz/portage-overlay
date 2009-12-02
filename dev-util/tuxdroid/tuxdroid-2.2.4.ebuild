# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=0

inherit eutils
DESCRIPTION="Developer utilities for the Tux Droid"
HOMEPAGE="http://www.tuxisalive.com/"
SRC_URI="amd64? ( http://ftp.kysoh.com/apps/installers/unix/tuxsetup/unix64/tar/tuxsetup-${PV}-amd64.tar.gz )\
		x86? ( http://ftp.kysoh.com/apps/installers/unix/tuxsetup/unix32/tar/tuxsetup-${PV}-i386.tar.gz )\
		linguas_da? ( http://ftp.kysoh.com/apps/resources/tts_voices/tarball/tuxdroid-tts-voices.Danish.tar.gz )\
		linguas_en_GB? ( http://ftp.kysoh.com/apps/resources/tts_voices/tarball/tuxdroid-tts-voices.British.tar.gz )
		"
LICENSE="GPL-2 \
		linguas_da? ( ACAPELA Non commercial ) \
		linguas_en_GB? ( ACAPELA Non commercial )"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="binchecks strip"

DEPEND=">=dev-java/sun-jdk-1.6\
		dev-python/setuptools\
		dev-python/pyxml\
		dev-python/ctypes\
		media-libs/portaudio\
		media-sound/lame\
		media-sound/sox\
		sys-libs/libstdc++-v3"

RDEPEND="${DEPEND}"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.

LANGS="da en_GB"

for X in ${LANGS}; do
		IUSE="${IUSE} linguas_${X}"
done


pkg_setup() {
	use amd64 || use x86 || die
	if use amd64; then
		S="${WORKDIR}/tuxsetup-${PV}-amd64"
	elif use x86; then
		S="${WORKDIR}/tuxsetup-${PV}-i386"
	fi
}

src_unpack() {
	unpack ${A}
	rm ${S}/Makefile
}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install || die "emake install failed"

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die "emake install failed"
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die "einstall failed"
	dodir /etc/tuxdroid/
	insinto /etc/tuxdroid/
	insopts -m0640
	doins mirror/etc/tuxdroid/*
	insopts -m0644
	insinto /etc/udev/rules.d/
	doins mirror/etc/udev/rules.d/*
	insinto /opt/
	doins -r mirror/opt/*
	insinto /usr
	doins -r mirror/usr/*
	#Install pythons stuff
	cd ${S}/mirror/usr/lib/tuxdroid/python-api/
	python ./setup.py install --root="${D}" > /dev/null
	
	#Make a few files executeable and some other hacks
	chmod 0755 ${D}/usr/share/tuxdroid/tuxhttpserver/tuxhttpserver.py
	chmod 0755 ${D}/usr/share/tuxdroid/tux_updater/tux_updater
	chmod 0755 ${D}/usr/bin/tuxsh
	chmod 0755 ${D}/usr/bin/tux_wifi_channel

	newinitd "${FILESDIR}/tuxdroid.rc6" tuxdroid
	#Install language packs
	if use linguas_da ; then
		einfo "Note the special and non-commercial license of the TTS files."
		einfo "Please consult /opt/Acapela/TelecomTTS/babtts/engines/tuxdroid-tts-voices.Danish/eula"
		insinto /opt/Acapela/TelecomTTS/babtts/engines/
		doins -r ${WORKDIR}/tuxdroid-tts-voices.Danish/Danish/
	fi

}
