From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Updates for Linux v4.18
Date: Fri, 8 Jun 2018 17:03:14 +0200
Message-ID: <20180608150309.esh35cutnhpf5ry4@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p6fvj5zx4uwog74f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--p6fvj5zx4uwog74f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

  Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.18

for you to fetch changes up to 1f568357117cafb48aafb10413cbd1567dc015b1:

  Merge branches 'arm/io-pgtable', 'arm/qcom', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next (2018-05-29 16:58:17 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.18

Nothing big this time. In particular:

	- Debugging code for Tegra-GART

	- Improvement in Intel VT-d fault printing to prevent
	  soft-lockups when on fault storms

	- Improvements in AMD IOMMU event reporting

	- NUMA aware allocation in io-pgtable code for ARM

	- Various other small fixes and cleanups all over the place

----------------------------------------------------------------
Andy Shevchenko (1):
      iommu: Remove extra NULL check when call strtobool()

Anna-Maria Gleixner (2):
      iommu/amd: Fix grammar of comments
      iommu/amd: Prevent possible null pointer dereference and infinite loop

Dmitry Osipenko (2):
      iommu/tegra: gart: Add debugging facility
      iommu/tegra: gart: Fix gart_iommu_unmap()

Dmitry Safonov (1):
      iommu/vt-d: Ratelimit each dmar fault printing

Gary R Hook (2):
      iommu/amd: Update the PASID information printed to the system log
      iommu/amd: Update logging information for new event type

Geert Uytterhoeven (1):
      iommu: Remove depends on HAS_DMA in case of platform dependency

Joerg Roedel (1):
      Merge branches 'arm/io-pgtable', 'arm/qcom', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next

Lu Baolu (4):
      iommu/vt-d: Clean up unused variable in find_or_alloc_domain
      iommu/vt-d: Clean up pasid quirk for pre-production devices
      iommu/vt-d: Remove unnecessary parentheses
      iommu: Clean up the comments for iommu_group_alloc

Peter Xu (2):
      iommu/vt-d: Introduce __mapping_notify_one()
      iommu/vt-d: Fix iotlb psi missing for mappings

Robin Murphy (1):
      iommu/io-pgtable-arm: Make allocations NUMA-aware

Wolfram Sang (1):
      iommu/qcom: Simplify getting .drvdata

YueHaibing (1):
      iommu/io-pgtable-arm: Use for_each_set_bit to simplify code

 drivers/iommu/Kconfig              |   5 +-
 drivers/iommu/amd_iommu.c          |  69 ++++++++++++-------------
 drivers/iommu/amd_iommu_types.h    |   1 +
 drivers/iommu/dmar.c               |   8 ++-
 drivers/iommu/intel-iommu.c        | 101 ++++++++++++++++++-------------------
 drivers/iommu/intel-svm.c          |   2 +-
 drivers/iommu/io-pgtable-arm-v7s.c |   5 +-
 drivers/iommu/io-pgtable-arm.c     |  18 ++++---
 drivers/iommu/iommu.c              |   7 +--
 drivers/iommu/qcom_iommu.c         |   6 +--
 drivers/iommu/tegra-gart.c         |  15 +++++-
 include/linux/intel-iommu.h        |   1 -
 12 files changed, 122 insertions(+), 116 deletions(-)

Please pull.

Thanks,

	Joerg

--p6fvj5zx4uwog74f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbGpqtAAoJECvwRC2XARrjD/IQANukc6nV57m4V1r1n3z0RSsE
h4hR2/vZdYDKOFVOVfP6x6fRaLTfcPOVYsFPAhzuT1I94QTN/pj5r1Xb+EbpUe7S
NvLPXez9m3oZWm+fReRma/szbymvq1kDham5S6UsVmSdi79pI++A+gDBq2aJymar
ovsj4tTmLo9lVa9orKfSGHrTVo6DC5FOJi6RYwSCbMVqgsO8a5FH7yWEIvVmTo0u
vGdq9WuCvXEFFcln0Um+ZQSWItJ9FUhjjF0VCkzReq4wdLcZqB8qBSu54xr8iBqA
aukdfzLmtlb26+/lCmrSIuYkArghSun20tezcmQZCNUSxEt4tn/bfPbvozpngiaG
ly9ruJoWTfSP/y8nwL1nq8qmHJRNtkkbQFYABFAXkaW6U8qM/6pt0htAKgEIucdz
+1Up6eHVk7TtP95cXK1Mz0M49TFc3cZjxRp+mWo9i9/6ksIHSLyitE240RoKKDbG
YHDYsjUFeea/MRNjYirvsKutV4IHdghbnYTL4Gj2AkqJqrMmi4H+IxOCq+NovioR
zCqZ+FQ8eUkhcIMBiA1V0vh6T2LW8vYJ7t8vJpwsPnB227lSe/0mwbq6NvoGMLwU
b4TpWAny67HwNkhqy5r/U+fyi2KsurZUBIs9xegBXa4YYDzq8SuSW7b9Gl7FarGx
xkGb6wDOk1Sbwr+9T9/g
=PuDY
-----END PGP SIGNATURE-----

--p6fvj5zx4uwog74f--
