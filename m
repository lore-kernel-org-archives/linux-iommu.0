From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.2
Date: Wed, 1 Jul 2015 18:42:42 +0200
Message-ID: <20150701164242.GA3274@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5ffde2f67181195d457b95df44b8f88e8d969d89:

  Merge branches 'arm/rockchip', 'arm/exynos', 'arm/smmu', 'x86/vt-d', 'x86/amd', 'default-domains' and 'core' into next (2015-06-19 17:17:47 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.2

for you to fetch changes up to 7a5a566eab48da7522f601f96aef3af102178046:

  iommu/amd: Introduce protection_domain_init() function (2015-07-01 08:43:07 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.2-rc0

Four fixes have queued up to fix regressions introduced after v4.1:

	* Don't fail IOMMU driver initialization when the add_device
	  call-back returns -ENODEV, as that just means that the device
	  is not translated by the IOMMU. This is pretty common on ARM.

	* Two fixes for the ARM-SMMU driver for a wrong feature check
	  and to remove a redundant NULL check.

	* A fix for the AMD IOMMU driver to fix a boot panic on systems
	  where the BIOS requests Unity Mappings in the IVRS table.

----------------------------------------------------------------
Joerg Roedel (2):
      iommu: Ignore -ENODEV errors from add_device call-back
      iommu/amd: Introduce protection_domain_init() function

Markus Elfring (1):
      iommu/arm-smmu: Delete an unnecessary check before the function call "free_io_pgtable_ops"

Will Deacon (1):
      iommu/arm-smmu: Fix broken ATOS check

 drivers/iommu/amd_iommu.c   | 26 ++++++++++++++++----------
 drivers/iommu/arm-smmu-v3.c |  3 +--
 drivers/iommu/arm-smmu.c    |  2 +-
 drivers/iommu/iommu.c       | 13 ++++++++++++-
 4 files changed, 30 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVlBiCAAoJECvwRC2XARrj6TIP/0C3DRCgNPRBTb7+pWtwR5nr
Yns5drgIcH/1a8yYZ7ma1pcJJr3aq69ah9zQjbwXuANxvmpmRA9mH9zF0DGBqHUw
gcKzI+zbQ5XgWdMYmKs6lnmhj2tXLYYSSTC2UuZ74JXOIX2AfcsHYMRWAr7SAxZJ
vgSLWEZbRh2TJKZkJlM234d7DUlgwjJnTDEkZewCjl+vXCJ23pJqid5dFLNPhzVf
azTPIhOA28FwEq/bwM39fXigdlkkSN49nNAOTn37pWLMZFVJspnG+7fdORslnKw8
Q22HHiYxBya+jrtvxgUIYgbApnEUJw+oHRNEuUHkHN72X61yR86HjoHjO+C/oEd8
P5a0HP0iQ9185S7GKWSKCCeZ4LpdA45bquyaQOTCudEOjMmQAJbmiA4LAgG/2iAc
WUTbcaKoxDBTTjSv3put4wWUsSJ2oeN2A2zwmn5yyVUuZlR7RMHghh/q6pBVZeRg
rjm927ooisfiRXZI2irS/JhbFjZVOof5v/GllCs3Tt92kHGB/C2x+/Cy2kGDniV/
M6nj0onzD2DDBBS4k0Ne+44s1RK+RKnrF/QpZv+tr19Sja1UWiM7TINdo7JbJkvA
JCyKQ0r+UpTKdj2bZ8s3JWhdfX5dPmfwZyDADgWbxIxjMdv08irRgOFhfg6iDOv/
bKEsXtOU2esK4GQMlIsn
=T20A
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
