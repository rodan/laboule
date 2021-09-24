# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for laboule"
ACCT_USER_ID=106
ACCT_USER_GROUPS=( laboule )
ACCT_USER_HOME=/var/log/laboule
ACCT_USER_HOME_PERMS=0700

acct-user_add_deps
