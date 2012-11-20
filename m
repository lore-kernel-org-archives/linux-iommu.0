From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for v3.7-rc6
Date: Tue, 20 Nov 2012 15:16:43 +0100
Message-ID: <20121120141642.GA3708@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-f=
ixes-v3.7-rc6

for you to fetch changes up to 3da4af0affbb797e8ac4c2b4598da0c34b8cc52a:

  intel-iommu: Fix lookup in add device (2012-11-17 13:27:15 +0100)

----------------------------------------------------------------
IOMMU fixes for Linux 3.7-rc6

Some fixes and a MAINTAINERS update to remove my lost AMD email address
=66rom the file. The fixes take care of a resource leak and a problem on
VT-d with the new IOMMU group code.

----------------------------------------------------------------
Alex Williamson (1):
      intel-iommu: Fix lookup in add device

Cyril Roelandt (1):
      iommu/tegra-smmu.c: fix dentry reference leak in smmu_debugfs_stats_s=
how().

Joerg Roedel (1):
      iommu/amd: Update MAINTAINERS entry

 MAINTAINERS                 |    4 ++--
 drivers/iommu/intel-iommu.c |    4 ++--
 drivers/iommu/tegra-smmu.c  |    1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

Please pull.

Regards,

	Joerg


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQq5DKAAoJECvwRC2XARrjADkQANg2rbkRcKAO5+BdCbBgBPeH
70SMkDUdEFkD/hNlkSTy2rVBIubVMJvcRW1Cak3vbDGLiMxFR0wmD2G1IO94Nz/v
VlEXfRjF9yomcPqEACfuaHo+dBo5G1dW42mL0cDv/U4pJHPzNdgeU/S2JaG8Iqo1
rwGYXaO/uTgQ9nN38BrxTMsNG4fp9Py3Gko0A6K/WS6MGrhfwFpUUpI5mBYrZnPh
Pfng2MtNI0978CZKd6W8/ds4cPWWSzjTDTWoE0/uc04lFlPgamNynzcJ0KI33pl4
lTMVQJF9uIpfMRvJIlSjwz8UH4w7pETvLrpoRHc1tTXlg/wN2mP8VJB87XXK8aXp
J8FNkW8OU9qSKQDwu/mPlhgGE5pm+FfDBIXKHuoJa3XaEVoTDlZQZ3LGxAmuukTx
Jk49Umha4lZuXwWNlDYOeHi4i2ogeT1yqoMiKE1gYdBt1l6dZVYu5bufNur/Pdu2
24GI7wCkd9P0Q9BwV8zXHqyiatzVRhXvv3QTMAXmVa4FRmxiy/fvlYJ8CUzJItib
pbvEGr1te/sjOrrXQiNjvmDAMdF+GoeTGtXKtxUROQizeJJlB3UL1SFGm76/0B67
lS2oWYci5s3/7q88ua+SWntrG1hbkh5XcNg8+9um/BAk3+mOBgUfyPbQ5yGGooGt
4iRExK0F5G7QlqPjZTT2
=OiQG
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
