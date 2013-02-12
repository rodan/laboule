# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

DESCRIPTION="tool to easily ban/tarpit unpolite IPs via iptables/ip6tables"
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

	cp -R "${S}/" "${D}/local/adm/" || die "Install failed"

	dodir /var/service/laboule
	exeinto /var/service/laboule
	doexe service/laboule/run || die "fail"
	dodir /var/service/laboule/log
	exeinto /var/service/laboule/log
	doexe service/laboule/log/run

	dodir /var/service/laboule-tarpit
	exeinto /var/service/laboule-tarpit
	doexe service/laboule-tarpit/run || die "fail"
	dodir /var/service/laboule-tarpit/log
	exeinto /var/service/laboule-tarpit/log
	doexe service/laboule-tarpit/log/run

	dodir /etc/laboule
	insinto /etc/laboule
	newins usr/doc/jail.ignore.template jail.ignore
	newins usr/doc/laboule.conf.template laboule.conf
	newins usr/doc/tarpit.ignore.template tarpit.ignore
	newins usr/doc/laboule-tarpit.conf.template laboule-tarpit.conf

	dodir /local/bin
	dosym /local/adm/laboule/bin/laboule /local/bin/laboule
}
