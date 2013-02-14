# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit eutils user

DESCRIPTION="the iptables chain manager for impolite IPs"
HOMEPAGE="http://github.com/rodan/laboule"
SRC_URI="http://mirrors.bu.avira.com/gentoo/distfiles/${P}.tar.bz2"
S="${WORKDIR}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}"
RESTRICT="strip mirror"

src_install() {
	dodir /local/adm
	keepdir /local/adm/laboule
	keepdir /var/lib/laboule
	keepdir /var/log/laboule
	keepdir /var/log/laboule-tarpit

	cp -R "${S}/" "${D}/local/adm/" || die "Install failed"

	dodir /var/service
	cp -R "${S}/service/laboule/" "${D}/var/service/"
	cp -R "${S}/service/laboule-tarpit/" "${D}/var/service/"

	dodir /etc/laboule
	insinto /etc/laboule
	newins usr/doc/jail.ignore.template jail.ignore
	newins usr/doc/laboule.conf.template laboule.conf
	newins usr/doc/tarpit.ignore.template tarpit.ignore
	newins usr/doc/laboule-tarpit.conf.template laboule-tarpit.conf

	dodir /opt/bin
	dosym /local/adm/laboule/bin/laboule /opt/bin/laboule
	dosym /local/adm/laboule/bin/laboule-tarpit /opt/bin/laboule-tarpit
}

pkg_setup() {
	enewgroup laboule
	enewuser laboule -1 -1 /var/log/laboule laboule
}
