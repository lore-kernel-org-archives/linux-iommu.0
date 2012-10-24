From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for v3.7-rc2
Date: Wed, 24 Oct 2012 17:58:55 +0200
Message-ID: <20121024155854.GA7010@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.7-rc2

for you to fetch changes up to d0078e72314df2e5ede03f2102cddde06767c374:

  iommu/tegra: smmu: Fix deadly typo (2012-10-24 16:58:53 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux 3.7-rc2

Two fixes this time:

	1. Another fix for a broken BIOS to detect when AMD IOMMU
	   interrupt remapping can not work reliably
	2. Typo fix for NVidia IOMMU driver

----------------------------------------------------------------
Hiro Sugawara (1):
      iommu/tegra: smmu: Fix deadly typo

Joerg Roedel (1):
      iommu/amd: Work around wrong IOAPIC device-id in IVRS table

 drivers/iommu/amd_iommu_init.c |   39 ++++++++++++++++++++++++++++++++-------
 drivers/iommu/tegra-smmu.c     |    2 +-
 2 files changed, 33 insertions(+), 8 deletions(-)

Please pull.

Regards,

	Joerg


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQiBA+AAoJECvwRC2XARrjIzsQALWA5wN+w6mKMa0RimQMtoem
i7d4eJv2vdawtc7uC2aZxfb7p4c1AWJr4EZeB4qf2uW4kUKU4PASYjzI19nz8WHa
xSe56lbWgrrj0jsYKzgZ9mUlBkZZUP22hvw65QTBoVrETJhboJO2Hik5DhoerAze
3nSOFkYQ+fnt/4L/yARxpKQvDu34IvPSwabvGMF1Ha/F5DlDV+w3CvISUUNH13ic
+MfLb7EC8sgAMDr6OwXxXgjmdzAHpnjOYNQKC5U+W8+4azgMOBQfbF0YzTOIuVzn
FGWU6nfvRNt52sQxLSPSZMG6d3AngQZoysSS1hbEofjwq/eRSJc92/MDPKdqgRXo
IwjYTbpcI6LYbmfidQRnXYozkNpv0s7r3vKAJbT6K9h7G4USJlFQ+YJET/PBguG7
i+A6X0icUKZElI/mKQbO054I2lv+6TiIvrDGrS/W1ezjJJGbr1jtPROKKrH9qVoE
BJgBygLOL/nE70Opj3dTCzoM2UwJPqK01B5LcIJFYE9klIqLyg6EnciQL5QleWde
gPxrJlnp/uK8guG26C3tJkbVCUmZ8KMDUXqAfHC270JeZeDVJ9Uf2UgUR/UlHdFs
tdKKDSYklSdjxS6hF7H8LHizHPqjOm2Cn4E6sPLZ3a7J6jYJ6BxU9oYpyNTB9sjE
0jG1nb90b2WlRzV+vDfp
=it0i
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
