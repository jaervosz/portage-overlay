# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

# The EAPI variable tells the ebuild format in use.
# Defaults to 0 if not specified. The current PMS draft contains details on
# a proposed EAPI=0 definition but is not finalized yet.
# Eclasses will test for this variable if they need to use EAPI > 0 features.
# Ebuilds should not define EAPI > 0 unless they absolutely need to use
# features added in that version.
EAPI=1

# inherit lists eclasses to inherit functions from. Almost all ebuilds should
# inherit eutils, as a large amount of important functionality has been
# moved there. For example, the epatch call mentioned below wont work
# without the following line:
inherit eutils
# A well-used example of an eclass function that needs eutils is epatch. If
# your source needs patches applied, it's suggested to put your patch in the
# 'files' directory and use:
#
#   epatch "${FILESDIR}"/patch-name-here
#
# eclasses tend to list descriptions of how to use their functions properly.
# take a look at /usr/portage/eclasses/ for more examples.

# Short one-line description of this package.
DESCRIPTION="Common elements of the Marionette Collective management suite."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://code.google.com/p/mcollective"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="http://puppetlabs.com/downloads/mcollective/${P}.tgz"

# License of the package.  This must match the name of file(s) in
# /usr/portage/licenses/.  For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="Apache-2.0"

# The SLOT variable is used to tell Portage if it's OK to keep multiple
# versions of the same package installed at the same time.  For example,
# if we have a libfoo-1.2.2 and libfoo-1.3.2 (which is not compatible
# with 1.2.2), it would be optimal to instruct Portage to not remove
# libfoo-1.2.2 if we decide to upgrade to libfoo-1.3.2.  To do this,
# we specify SLOT="1.2" in libfoo-1.2.2 and SLOT="1.3" in libfoo-1.3.2.
# emerge clean understands SLOTs, and will keep the most recent version
# of each SLOT and remove everything else.
# Note that normal applications should use SLOT="0" if possible, since
# there should only be exactly one version installed at a time.
# DO NOT USE SLOT=""! This tells Portage to disable SLOTs for this package.
SLOT="0"

# Using KEYWORDS, we can record masking information *inside* an ebuild
# instead of relying on an external package.mask file.  Right now, you should
# set the KEYWORDS variable for every ebuild so that it contains the names of
# all the architectures with which the ebuild works.  All of the official
# architectures can be found in the keywords.desc file which is in
# /usr/portage/profiles/.  Usually you should just set this to "~x86".  The ~
# in front of the architecture indicates that the package is new and should be
# considered unstable until testing proves its stability.  So, if you've
# confirmed that your ebuild works on x86 and ppc, you'd specify:
# KEYWORDS="~x86 ~ppc"
# Once packages go stable, the ~ prefix is removed.
# For binary packages, use -* and then list the archs the bin package
# exists for.  If the package was for an x86 binary package, then
# KEYWORDS would be set like this: KEYWORDS="-* x86"
# DO NOT USE KEYWORDS="*".  This is deprecated and only for backward
# compatibility reasons.
KEYWORDS="~x86 ~amd64"

# Comprehensive list of any and all USE flags leveraged in the ebuild,
# with the exception of any ARCH specific flags, i.e. "ppc", "sparc",
# "x86" and "alpha".  This is a required variable.  If the ebuild doesn't
# use any USE flags, set to "".
IUSE="-client +server"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

# Build-time dependencies, such as
#    ssl? ( >=dev-libs/openssl-0.9.6b )
#    >=dev-lang/perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="server? ( || ( =dev-ruby/stomp-1.1 >=dev-ruby/stomp-1.1.6 ) )
        >=dev-lang/ruby-1.8"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND}"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"


# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need a different behaviour.

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}.patch

	if has_version "<sys-apps/baselayout-2.0.0"; then
		# change /usr/bin/env back to /usr/bin/ruby
		einfo "Baselayout-1 detected - patching mcollectived"
		sed -i -e 's@#!/usr/bin/env ruby@#!/usr/bin/ruby@' mcollectived.rb
	fi
}

src_install() {
	if ! use server && ! use client; then
		die "Please specify one or both of client and server USE flag."
	fi

	dodir /etc/mcollective
	fperms 755 /etc/mcollective

	siteruby=$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')
	dodir ${siteruby}/mcollective
	dodir ${siteruby}/mcollective/connector
	dodir ${siteruby}/mcollective/facts
	dodir ${siteruby}/mcollective/registration
	dodir ${siteruby}/mcollective/rpc
	dodir ${siteruby}/mcollective/security
	dodir ${siteruby}/mcollective/logger
	
	insinto ${siteruby}
	cd ${S}/lib
	doins *.rb
	
	insinto ${siteruby}/mcollective
	cd ${S}/lib/mcollective
	doins *.rb
	
	insinto ${siteruby}/mcollective/connector
	cd ${S}/lib/mcollective/connector
	doins *.rb
	
	insinto ${siteruby}/mcollective/facts
	cd ${S}/lib/mcollective/facts
	doins *.rb
	
	insinto ${siteruby}/mcollective/registration
	cd ${S}/lib/mcollective/registration
	doins *.rb
	
	insinto ${siteruby}/mcollective/rpc
	cd ${S}/lib/mcollective/rpc
	doins *.rb
	
	insinto ${siteruby}/mcollective/logger
	cd ${S}/lib/mcollective/logger
	doins *.rb
	
	insinto ${siteruby}/mcollective/security
	cd ${S}/lib/mcollective/security
	doins *.rb

	dodir /usr/share/mcollective
	dodir /usr/share/mcollective/mcollective
	dodir /usr/share/mcollective/mcollective/agent
	dodir /usr/share/mcollective/mcollective/audit
	dodir /usr/share/mcollective/mcollective/connector
	dodir /usr/share/mcollective/mcollective/facts
	dodir /usr/share/mcollective/mcollective/registration
	dodir /usr/share/mcollective/mcollective/security

	insinto /usr/share/mcollective/mcollective/agent
	cd ${S}/plugins/mcollective/agent
	doins *.rb
	doins *.ddl

	insinto /usr/share/mcollective/mcollective/audit
	cd ${S}/plugins/mcollective/audit
	doins *.rb

	insinto /usr/share/mcollective/mcollective/connector
	cd ${S}/plugins/mcollective/connector
	doins *.rb

	insinto /usr/share/mcollective/mcollective/facts
	cd ${S}/plugins/mcollective/facts
	doins *.rb

	insinto /usr/share/mcollective/mcollective/registration
	cd ${S}/plugins/mcollective/registration
	doins *.rb

	insinto /usr/share/mcollective/mcollective/security
	cd ${S}/plugins/mcollective/security
	doins *.rb

	cd ${S}
	dodoc COPYING
	
	insinto /etc/mcollective
	doins etc/facts.yaml.dist

	if use server; then
		insinto /etc/mcollective
		doins etc/server.cfg.dist
		fperms 0640 /etc/mcollective/server.cfg.dist
		doins etc/facts.yaml.dist
		newsbin mcollectived.rb mcollectived
		newinitd ${FILESDIR}/mcollectived.init mcollectived
		newconfd ${FILESDIR}/mcollectived.conf mcollectived
	fi

	if use client; then
		insinto /etc/mcollective
		doins etc/client.cfg.dist
		dosbin mc-call-agent
		dosbin mc-controller
		dosbin mc-facts
		dosbin mc-find-hosts
		dosbin mc-inventory
		dosbin mc-ping
		dosbin mc-rpc
	fi
}
