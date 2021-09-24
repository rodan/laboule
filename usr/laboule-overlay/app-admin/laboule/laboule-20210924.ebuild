# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="the iptables chain manager for impolite IPs"
HOMEPAGE="https://github.com/rodan/laboule"
SRC_URI="https://github.com/rodan/${PN}/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	acct-user/laboule
	acct-group/laboule
	net-firewall/iptables
"
RESTRICT="strip mirror"

LABOULE_HOME="/usr/share/laboule"

src_install() {
	keepdir /var/lib/laboule
	keepdir /var/log/laboule
	keepdir /var/log/laboule-tarpit

	dodir /var/service
	cp -R "${S}/service/laboule/" "${D}/var/service/"
	cp -R "${S}/service/laboule-tarpit/" "${D}/var/service/"

	dodir /etc/laboule
	insinto /etc/laboule
	newins usr/doc/jail.ignore.template jail.ignore
	newins usr/doc/laboule.conf.template laboule.conf
	newins usr/doc/tarpit.ignore.template tarpit.ignore
	newins usr/doc/laboule-tarpit.conf.template laboule-tarpit.conf

	insinto "${LABOULE_HOME}"
	doins usr/doc/*
	newins README README

	exeinto /usr/bin
	newexe bin/laboule laboule
	newexe bin/laboule-tarpit laboule-tarpit
}
