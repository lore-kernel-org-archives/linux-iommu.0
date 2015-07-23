From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.2-rc3
Date: Thu, 23 Jul 2015 18:50:52 +0200
Message-ID: <20150723165052.GA20881@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.2-rc3

for you to fetch changes up to 46ebb7af7b93792de65e124e1ab8b89a108a41f2:

  iommu/vt-d: Fix VM domain ID leak (2015-07-23 14:17:39 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.2-rc3

The fixes include:

	* A couple of fixes for the new ARM-SMMUv3 driver to fix issues found
	  on the first real implementation of that hardware.

	* A patch for the Intel VT-d driver to fix a domain-id leak.

----------------------------------------------------------------
Alex Williamson (1):
      iommu/vt-d: Fix VM domain ID leak

Will Deacon (1):
      iommu/arm-smmu: Fix LOG2SIZE setting for 2-level stream tables

Zhen Lei (4):
      iommu/arm-smmu: Fix the index calculation of strtab
      iommu/arm-smmu: Fix the values of ARM64_TCR_{I,O}RGN0_SHIFT
      iommu/arm-smmu: Enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
      iommu/arm-smmu: Skip the execution of CMD_PREFETCH_CONFIG

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  3 ++
 drivers/iommu/arm-smmu-v3.c                        | 60 +++++++++++++++++-----
 drivers/iommu/intel-iommu.c                        |  9 ++--
 3 files changed, 55 insertions(+), 17 deletions(-)

Please pull.

Thanks,

	Joerg


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVsRtsAAoJECvwRC2XARrj10UQAOGoyTfhlK3FjKallTjCVgLu
yuVSQf59ONVXzr4e7czlw3T69hl/2dWqQsnQ7S+OK1ZxEQZzki9U54OTsuSl0lzz
DeBRm0xFN7cAM4siTOTduPkbeiL52XkYLwcNejQmAT1qdTs/Fp6I1/8AWzP9GrSd
QxVU61DJz1JrXd61ulbcq5/UTYnIEV7FW+aNmSug87zYXpaXbK5tJosGt5pELX5f
yqynL1swIk5FXdIq8tBNDeySpLxc05lWHu4/CD/Aw1L+SZiPp1SXCL0/zv/uZaeq
4rBaK6yC/6MbmuPGCUP8cL7rrP0dKkmCHknrbKAQlIXICbdbTFNlKd68eENeUZm8
HHzfvInFAEz2kGqsTD6K/MEroMiUStmEoMricP6QgJkESlwJiQFc9zJ1Fzw8COrv
Bkm6ZkLAzv/23uIPG6hCtz7Kze1fJHZ4e7WgvqIEtzerVJtUoVszk22vpWeJ6xvq
aBvInQjuiggzH6bTDcgA/xeyqUdd/3WGiknceBXkqrQPJEgG8W22U5YyFogQiv2G
fO7Kndmn9OWTpAlrNVqv9aZtJHnjjmXx4MnS6YJy3OWiQ2EHOFxpHXKnd/6Bd3fx
4tBdJoOHXgl5bKEWdaQOdOACLtwiQbSidmVTovq7dgGYp9iZa71UvIww9Uf83ewe
xNoABzM1D5oH7jU5z5tJ
=xnRW
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
