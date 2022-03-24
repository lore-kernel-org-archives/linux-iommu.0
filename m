Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7AAC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 10:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8336084235;
	Thu, 24 Mar 2022 10:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ1w3oUKnU5H; Thu, 24 Mar 2022 10:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12FDA813CE;
	Thu, 24 Mar 2022 10:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9484C0012;
	Thu, 24 Mar 2022 10:04:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 647B3C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4997C400BF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fNs91NBsCk_I for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:04:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF8F94102C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:04:26 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D7CB450C; Thu, 24 Mar 2022 11:04:22 +0100 (CET)
Date: Thu, 24 Mar 2022 11:04:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.18
Message-ID: <YjxCJKNbtfcyV/6A@8bytes.org>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3351828193951744048=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3351828193951744048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wf2zxYnOXxQkTonL"
Content-Disposition: inline


--wf2zxYnOXxQkTonL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there is a conflict this time when merging the IOMMU tree updates. It is
in drivers/iommu/intel/iommu.c and comes from the fact that the tip-tree
patched functions in that file which get removed with these updates. So
the merge resolution is to use the changes from the IOMMU tree. With
that in mind, here are the IOMMU changes for v5.18:

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.18

for you to fetch changes up to e17c6debd4b2d2d474074f83946f8c6522587566:

  Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next (2022-03-08 12:21:31 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.18

Including:

	- IOMMU Core changes:
	  - Removal of aux domain related code as it is basically dead
	    and will be replaced by iommu-fd framework
	  - Split of iommu_ops to carry domain-specific call-backs
	    separatly
	  - Cleanup to remove useless ops->capable implementations
	  - Improve 32-bit free space estimate in iova allocator

	- Intel VT-d updates:
	  - Various cleanups of the driver
	  - Support for ATS of SoC-integrated devices listed in
	    ACPI/SATC table

	- ARM SMMU updates:
	  - Fix SMMUv3 soft lockup during continuous stream of events
	  - Fix error path for Qualcomm SMMU probe()
	  - Rework SMMU IRQ setup to prepare the ground for PMU support
	  - Minor cleanups and refactoring

	- AMD IOMMU driver:
	  - Some minor cleanups and error-handling fixes

	- Rockchip IOMMU driver:
	  - Use standard driver registration

	- MSM IOMMU driver:
	  - Minor cleanup and change to standard driver registration

	- Mediatek IOMMU driver:
	  - Fixes for IOTLB flushing logic

----------------------------------------------------------------
Andy Shevchenko (2):
      perf/smmuv3: Don't cast parameter in bit operations
      iommu/vt-d: Move intel_iommu_ops to header file

Christophe JAILLET (2):
      iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      iommu/arm-smmu-v3: Simplify memory allocation

David Heidelberg (1):
      iommu/msm: Simplify with dev_err_probe()

Jiasheng Jiang (1):
      iommu/ipmmu-vmsa: Check for error num after setting mask

Joerg Roedel (3):
      Merge branch 'core' into x86/vt-d
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next

John Garry (1):
      iommu/iova: Separate out rcache init

Lu Baolu (17):
      iommu/vt-d: Remove guest pasid related callbacks
      iommu: Remove guest pasid related interfaces and definitions
      iommu/vt-d: Remove aux-domain related callbacks
      iommu: Remove aux-domain related interfaces and iommu_ops
      iommu: Remove apply_resv_region
      drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
      iommu: Use right way to retrieve iommu_ops
      iommu: Remove unused argument in is_attach_deferred
      iommu: Split struct iommu_ops
      iommu/vt-d: Remove intel_iommu::domains
      iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
      iommu/vt-d: Remove iova_cache_get/put()
      iommu/vt-d: Remove domain and devinfo mempool
      iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
      iommu/vt-d: Remove unnecessary includes
      iommu/vt-d: Remove unnecessary prototypes
      iommu/vt-d: Fix indentation of goto labels

Marco Bonelli (1):
      iommu/vt-d: Add missing "__init" for rmrr_sanity_check()

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Rafael J. Wysocki (1):
      iommu/vtd: Replace acpi_bus_get_device()

Robin Murphy (5):
      iommu: Remove trivial ops->capable implementations
      iommu/rockchip: : Use standard driver registration
      iommu/msm: Use standard driver registration
      iommu/iova: Improve 32-bit free space estimate
      iommu/arm-smmu: Account for PMU interrupts

Sebastian Reichel (1):
      iommu/mediatek: Always check runtime PM status in tlb flush range callback

Suravee Suthikulpanit (2):
      iommu/amd: Improve error handling for amd_iommu_init_pci
      iommu/amd: Improve amd_iommu_v2_exit()

Vasant Hegde (3):
      iommu/amd: Call memunmap in error path
      iommu/amd: Clean up function declarations
      iommu/amd: Remove unused struct fault.devid

Yian Chen (1):
      iommu/vt-d: Enable ATS for the devices in SATC table

Yong Wu (4):
      iommu/mediatek: Remove for_each_m4u in tlb_sync_all
      iommu/mediatek: Remove the power status checking in tlb flush all
      iommu/mediatek: Add tlb_lock in tlb_flush_all
      iommu/mediatek: Always tlb_flush_all when each PM resume

Yoshihiro Shimoda (2):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779f0 support
      iommu/ipmmu-vmsa: Add support for R-Car Gen4

YueHaibing (1):
      iommu/vt-d: Remove unused function intel_svm_capable()

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   4 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |   4 +-
 drivers/iommu/amd/init.c                           |  18 +-
 drivers/iommu/amd/iommu.c                          |  23 +-
 drivers/iommu/amd/iommu_v2.c                       |  37 +-
 drivers/iommu/apple-dart.c                         |  20 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  45 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 113 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  28 +-
 drivers/iommu/dma-iommu.c                          |   4 +
 drivers/iommu/exynos-iommu.c                       |  14 +-
 drivers/iommu/fsl_pamu_domain.c                    |  10 +-
 drivers/iommu/intel/debugfs.c                      |   6 +-
 drivers/iommu/intel/dmar.c                         |   5 +-
 drivers/iommu/intel/iommu.c                        | 999 +++------------------
 drivers/iommu/intel/pasid.c                        | 173 +---
 drivers/iommu/intel/pasid.h                        |   4 -
 drivers/iommu/intel/svm.c                          | 220 +----
 drivers/iommu/iommu.c                              | 339 +------
 drivers/iommu/iova.c                               |  78 +-
 drivers/iommu/ipmmu-vmsa.c                         |  32 +-
 drivers/iommu/msm_iommu.c                          |  74 +-
 drivers/iommu/mtk_iommu.c                          |  62 +-
 drivers/iommu/mtk_iommu_v1.c                       |  14 +-
 drivers/iommu/omap-iommu.c                         |  14 +-
 drivers/iommu/rockchip-iommu.c                     |  21 +-
 drivers/iommu/s390-iommu.c                         |  14 +-
 drivers/iommu/sprd-iommu.c                         |  18 +-
 drivers/iommu/sun50i-iommu.c                       |  18 +-
 drivers/iommu/tegra-gart.c                         |  24 +-
 drivers/iommu/tegra-smmu.c                         |  20 +-
 drivers/iommu/virtio-iommu.c                       |  14 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   4 +-
 drivers/vdpa/vdpa_user/iova_domain.c               |  11 +
 include/linux/intel-iommu.h                        |  33 +-
 include/linux/intel-svm.h                          |  12 -
 include/linux/iommu.h                              | 181 ++--
 include/linux/iova.h                               |  15 +-
 include/uapi/linux/iommu.h                         | 181 ----
 41 files changed, 662 insertions(+), 2251 deletions(-)

Please pull.

Thanks,

	Joerg

--wf2zxYnOXxQkTonL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmI8QiAACgkQK/BELZcB
GuMstBAA2gx8tQIji33zBo7JG6ws1Fr6Lno5nXQkONomfRFl1rdcS7fCyHgC/3l9
Vk856uIGOdUBbv4zTtUUDSpftCx/aFkEDU8jfCLNVCZN163k2cLlfQNhqUdThGTg
Hm/lxXaId38+lg/mfBuhEAYeYi2+7SeKlQgkIZc8JXUvu+9xTnxpy3bGpyatcwGF
Wh8aZWVP0t9y9CJXxDaqF4SiIpq8Eu1CyWHy8FhHTVRDU6qTDAkCupxR9kPJ/HDg
0nEjryneZdtXXaI7/Nj/m8JNuENLoFra9sQtV2d26d6foYg19L5C1vuoIBNEds/Z
0odDSBBWv2gAHeoZMw5GiNOKYMbayECSQH7ip5BpLognxlGUS4/DTAw73jIuJdz3
F0cKt+oynNZyTcOo/QOPtsrr+ILtAb8jFyI2hnrcs/D2zqRqBDsmlWTD7zugR4iE
u9yDhHHsFJ5ZNrilBjDypyBVY2a8yxpxtOKc0Pk9IH1RDpegFq6Ha59CD9q4XFJ9
eDDWso131drIJXSsXRTJ9WYdz5GrruD0nPjZV+cOoD+iVb/rotA3/1elhdgKXkL6
fq3i2hiayRk1hjevuUeu1MQNxW0US/ZD44Lgltn4SDBXHrEVAtbyYHAgYVkfa9ZE
hPP4citd3hDpdip6Ejw+dHzNlmDxue1cPoGcdSNd9PGKQDP2sKM=
=cgDP
-----END PGP SIGNATURE-----

--wf2zxYnOXxQkTonL--

--===============3351828193951744048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3351828193951744048==--
