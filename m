From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.0-rc3
Date: Tue, 10 Mar 2015 13:42:20 -0500
Message-ID: <20150310184219.GA17319@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.0-rc3

for you to fetch changes up to d05321ecfd77b6204b28e5d98fb75befabf62b53:

  iommu/io-pgtable-arm: Add built time dependency (2015-03-03 14:04:12 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.0-rc3

The patches contain:

	* Fix multiple ARM IOMMU drivers to behave well when the
	  hardware is not present

	* Mark MSM driver as broken

	* Fix build errors with the new ARM generic io-page-table code

----------------------------------------------------------------
Jean Delvare (1):
      iommu/io-pgtable-arm: Add built time dependency

Thierry Reding (4):
      iommu/exynos: Play nice in multi-platform builds
      iommu/omap: Play nice in multi-platform builds
      iommu/rockchip: Play nice in multi-platform builds
      iommu/msm: Mark driver BROKEN

Will Deacon (1):
      iommu/io-pgtable-arm: Fix self-test WARNs on i386

 drivers/iommu/Kconfig          | 2 ++
 drivers/iommu/exynos-iommu.c   | 7 +++++++
 drivers/iommu/io-pgtable-arm.c | 5 +++--
 drivers/iommu/omap-iommu.c     | 7 +++++++
 drivers/iommu/rockchip-iommu.c | 7 +++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJU/zsLAAoJECvwRC2XARrjKFcQANpHun9NbytucnR++/l0malB
JaTtKUG/hV06fy4REl3FApFNqsgT71RcrvkPMu8lTPsIDieBzs67qWMOcYjxrw8s
Ci2OgbwsOq9QWtldrFjalFLw96xXr9we7GQUOIaVLgty+PhZk1UOJ7ffcsOzkq5X
kxU1BMCO6fzIwnXYJ0imHfVO7XHN47SLyygcALN/m7CvOoTPrc+Q+WS2mRZeKzcn
QKGVVWC8hV19FW14hM/qAsjIMJ2eKK9yx2wJKdnCMX7sfmmEA/DGFiqOgyx9AOu9
ZCwQq7SGSOFUzgxUFcfxfP7bKIfBsG2IfZxrE70NK+OWJ8trcRA/blX4aVRufrYN
DRWN93RxtWdaaBCXzwTBAVvf+XhcZwVKwpeli8DC8iXbk9e2xsp9JAwB8K37f3gs
wXPuFVgaHSLmhBPk1VNHe5xKqMMV265idJcArgX2Pq366Wizf7X6cN7RQYsCFtb8
JEPM1Rji2c/nwkBwjiFBXqVVA6RCdLqSkPGdfwvdm94NWB4yJ04OjJwAww+0dLOp
8qk3YSoOUTh9Ht0nAjvZgrE7S4btAWYLnN6DLRAwnLqWSWp1+0pw8KNPitBmic17
muPtyVJeUvd40XDDFDJ/zZaJst9eXHKmkB+bDQp0iP7FFK125hPeEFC5TUdOHnKm
KmZlzhHuLfSkekrhGo2L
=sQ8B
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
