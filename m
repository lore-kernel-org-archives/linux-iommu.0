From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.18-rc5
Date: Fri, 20 Jul 2018 16:44:55 +0200
Message-ID: <20180720144451.n25pzfucez6rfmyd@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lnh6mbxoijw4e3o6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--lnh6mbxoijw4e3o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.18-rc5

for you to fetch changes up to 2db1581e1f432ac6b4efe152c57fdfb4de85c154:

  Revert "iommu/vt-d: Clean up pasid quirk for pre-production devices" (2018-07-20 13:55:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.18-rc5:

Only one revert:

	* Revert an Intel VT-d patch that caused issues with the i915 GPU
	  driver

----------------------------------------------------------------
Lu Baolu (1):
      Revert "iommu/vt-d: Clean up pasid quirk for pre-production devices"

 drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--lnh6mbxoijw4e3o6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbUfVjAAoJECvwRC2XARrjBbsP/iTyqKYOYV6j4TPdLyvReM5V
XbuwFovvm1B95yv87+VHhUDu3VfYvYVpB/bTus8PAClyZAVQPnNwmiZ3WiM6032F
BcZATK3/i7vFNFwjNgIaqffq338R4E7FBYRjJtoS2P/BV8AyO1rSjgBlNpqTjxAc
YtmLRAzJCEb/b9A2CRj86r+V0gWwCgRLqOzU1X04S741n39mNURvgKa1D9fRX1xR
0oERS9N5F6NyxiZHYss/803TWYGfVat1+5imYMSICMC9rlFw7EW6lYnxRJ31Pl2c
W8BIHJKNtt9vvb1qy3wJNoO/aLx6lQno+EM2rAf3mHnPoM2fNCSHrB1Xq6MK9/y9
lSeENgml+zlXtJPD3NnuQzKpK+wqmNCY67Bi6G0p4un1qcAmbRNCMXrI+WeepvU0
RVbbXXL7hghi74BBH1n9VcCOwr1VvAFY4VupmoQZf6BQdtXf90O30lQHoYCEdcSp
TOq7AmtCh5IybPJDl/L89E/g/yd84+9VSnkbV/Mg/9Fw6cWwbphIzrC3yB338mz0
5snFyJ4dAbjvZmUE9OHlgYelDVB4xSNDybsYCoPnpc7KdgUPOtU8PfArv/Uujcne
QUdo2Pmr26XLpS+Khl4edgwX25wIiQFIqSbVST7gs7Xlk4CHswoLsvaE9yyqQnKq
yiMLGHBbEl0BA1qOLqF+
=QMVG
-----END PGP SIGNATURE-----

--lnh6mbxoijw4e3o6--
