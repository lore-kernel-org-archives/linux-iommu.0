Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A5C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 16:05:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183AD2063A
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 16:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183AD2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2A9B87B92;
	Mon,  8 Jun 2020 16:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJWYtY8pwiIq; Mon,  8 Jun 2020 16:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C68987B84;
	Mon,  8 Jun 2020 16:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D80BAC0863;
	Mon,  8 Jun 2020 16:05:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BF46C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3803D86101
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r6Ml1HPzulHU for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 16:05:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F35AF861F4
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:05:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3BC213D5; Mon,  8 Jun 2020 18:05:09 +0200 (CEST)
Date: Mon, 8 Jun 2020 18:05:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.8
Message-ID: <20200608160502.GA4491@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1154420933636883114=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1154420933636883114==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.8

for you to fetch changes up to 431275afdc7155415254aef4bd3816a1b8a2ead0:

  iommu: Check for deferred attach in iommu_group_do_dma_attach() (2020-06-04 11:38:17 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.8

Including:

	- A big part of this is a change in how devices get connected to
	  IOMMUs in the core code. It contains the change from the old
	  add_device()/remove_device() to the new
	  probe_device()/release_device() call-backs. As a result
	  functionality that was previously in the IOMMU drivers has
	  been moved to the IOMMU core code, including IOMMU group
	  allocation for each device.
	  The reason for this change was to get more robust allocation
	  of default domains for the iommu groups.
	  A couple of fixes were necessary after this was merged into
	  the IOMMU tree, but there are no known bugs left. The last fix
	  is applied on-top of the merge commit for the topic branches.

	- Removal of the driver private domain handling in the Intel
	  VT-d driver. This was fragile code and I am glad it is gone
	  now.

	- More Intel VT-d updates from Lu Baolu:

		- Nested Shared Virtual Addressing (SVA) support to the
		  Intel VT-d driver

		- Replacement of the Intel SVM interfaces to the common
		  IOMMU SVA API

		- SVA Page Request draining support

	- ARM-SMMU Updates from Will:

		- Avoid mapping reserved MMIO space on SMMUv3, so that
		  it can be claimed by the PMU driver

		- Use xarray to manage ASIDs on SMMUv3

		- Reword confusing shutdown message

		- DT compatible string updates

		- Allow implementations to override the default domain
		  type

	- A new IOMMU driver for the Allwinner Sun50i platform

	- Support for ATS gets disabled for untrusted devices (like
	  Thunderbolt devices). This includes a PCI patch, acked by
	  Bjorn.

	- Some cleanups to the AMD IOMMU driver to make more use of
	  IOMMU core features.

	- Unification of some printk formats in the Intel and AMD IOMMU
	  drivers and in the IOVA code.

	- Updates for DT bindings

	- A number of smaller fixes and cleanups.

----------------------------------------------------------------
Andre Przywara (1):
      dt-bindings: arm-smmu: Allow mmu-400, smmu-v1 compatible

Andy Shevchenko (3):
      iommu/iova: Unify format of the printed messages
      iommu/vt-d: Unify format of the printed messages
      iommu/amd: Unify format of the printed messages

Arnd Bergmann (1):
      iommu/renesas: Fix unused-function warning

Chen Zhou (1):
      iommu/arm-smmu-v3: remove set but not used variable 'smmu'

Jacob Pan (10):
      iommu/vt-d: Move domain helper to header
      iommu/vt-d: Use a helper function to skip agaw for SL
      iommu/vt-d: Add nested translation helper function
      iommu/vt-d: Add bind guest PASID support
      iommu/vt-d: Support flushing more translation cache types
      iommu/vt-d: Add svm/sva invalidate function
      iommu/vt-d: Add custom allocator for IOASID
      iommu/vt-d: Report SVA feature with generic flag
      iommu/vt-d: Replace intel SVM APIs with generic SVA APIs
      iommu/vt-d: Fix compile warning

Jean-Philippe Brucker (8):
      iommu/arm-smmu-v3: Don't reserve implementation defined register space
      iommu/arm-smmu-v3: Manage ASIDs with xarray
      PCI/ATS: Only enable ATS for trusted devices
      iommu/amd: Use pci_ats_supported()
      iommu/arm-smmu-v3: Use pci_ats_supported()
      iommu/vt-d: Use pci_ats_supported()
      uacce: Remove mm_exit() op
      iommu: Remove iommu_sva_ops::mm_exit()

Joerg Roedel (50):
      iommu: Move default domain allocation to separate function
      iommu/amd: Implement iommu_ops->def_domain_type call-back
      iommu/vt-d: Wire up iommu_ops->def_domain_type
      iommu/amd: Remove dma_mask check from check_device()
      iommu/amd: Return -ENODEV in add_device when device is not handled by IOMMU
      iommu: Add probe_device() and release_device() call-backs
      iommu: Move default domain allocation to iommu_probe_device()
      iommu: Keep a list of allocated groups in __iommu_probe_device()
      iommu: Move new probe_device path to separate function
      iommu: Split off default domain allocation from group assignment
      iommu: Move iommu_group_create_direct_mappings() out of iommu_group_add_device()
      iommu: Export bus_iommu_probe() and make is safe for re-probing
      iommu/amd: Remove dev_data->passthrough
      iommu/amd: Convert to probe/release_device() call-backs
      iommu/vt-d: Convert to probe/release_device() call-backs
      iommu/arm-smmu: Convert to probe/release_device() call-backs
      iommu/pamu: Convert to probe/release_device() call-backs
      iommu/s390: Convert to probe/release_device() call-backs
      iommu/virtio: Convert to probe/release_device() call-backs
      iommu/msm: Convert to probe/release_device() call-backs
      iommu/mediatek: Convert to probe/release_device() call-backs
      iommu/mediatek-v1 Convert to probe/release_device() call-backs
      iommu/qcom: Convert to probe/release_device() call-backs
      iommu/rockchip: Convert to probe/release_device() call-backs
      iommu/tegra: Convert to probe/release_device() call-backs
      iommu/renesas: Convert to probe/release_device() call-backs
      iommu/omap: Remove orphan_dev tracking
      iommu/omap: Convert to probe/release_device() call-backs
      iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
      iommu/exynos: Convert to probe/release_device() call-backs
      iommu: Remove add_device()/remove_device() code-paths
      iommu: Move more initialization to __iommu_probe_device()
      iommu: Unexport iommu_group_get_for_dev()
      Merge tag 'v5.7-rc4' into core
      iommu/sun50i: Fix compile warnings
      iommu/sun50i: Use __GFP_ZERO instead of memset()
      iommu: Don't call .probe_finalize() under group->mutex
      iommu: Don't take group reference in iommu_alloc_default_domain()
      Merge tag 'v5.7-rc7' into x86/amd
      iommu/amd: Unexport get_dev_data()
      iommu/amd: Let free_pagetable() not rely on domain->pt_root
      iommu/amd: Allocate page-table in protection_domain_init()
      iommu/amd: Free page-table in protection_domain_free()
      iommu/amd: Consolidate domain allocation/freeing
      iommu/amd: Remove PD_DMA_OPS_MASK
      iommu/amd: Merge private header files
      iommu/amd: Store dev_data as device iommu private data
      iommu/amd: Remove redundant devid checks
      Merge branches 'arm/msm', 'arm/allwinner', 'arm/smmu', 'x86/vt-d', 'hyper-v', 'core' and 'x86/amd' into next
      iommu: Check for deferred attach in iommu_group_do_dma_attach()

Jon Derrick (3):
      iommu/vt-d: Only clear real DMA device's context entries
      iommu/vt-d: Allocate domain info for real DMA sub-devices
      iommu/vt-d: Remove real DMA lookup in find_domain

Jordan Crouse (1):
      iommu/arm-smmu: Allow client devices to select direct mapping

Lu Baolu (12):
      iommu/vt-d: Allow 32bit devices to uses DMA domain
      iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
      iommu/vt-d: Apply per-device dma_ops
      iommu/vt-d: Enlightened PASID allocation
      iommu/vt-d: Add get_domain_info() helper
      iommu/vt-d: Multiple descriptors per qi_submit_sync()
      iommu/vt-d: debugfs: Add support to show inv queue internals
      iommu/vt-d: Disable non-recoverable fault processing before unbind
      iommu/vt-d: Add page request draining support
      iommu/vt-d: Remove redundant IOTLB flush
      iommu/vt-d: Remove duplicated check in intel_svm_bind_mm()
      iommu/vt-d: Fix pointer cast warnings on 32 bit

Maxime Ripard (2):
      dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
      iommu: Add Allwinner H6 IOMMU driver

Qian Cai (2):
      iommu/amd: Fix variable "iommu" set but not used
      iommu/vt-d: fix a GCC warning

Rikard Falkeborn (2):
      iommu/hyper-v: Constify hyperv_ir_domain_ops
      iommu/sun50i: Constify sun50i_iommu_ops

Sai Prakash Ranjan (3):
      iommu/arm-smmu: Make remove callback message more informative
      iommu: arm-smmu-impl: Convert to a generic reset implementation
      iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back

Sai Praneeth Prakhya (2):
      iommu: Add def_domain_type() callback in iommu_ops
      iommu: Remove functions that support private domain

Samuel Zou (1):
      iommu/msm: Make msm_iommu_lock static

Sibi Sankar (3):
      dt-bindings: remoteproc: qcom: Add iommus property
      arm64: dts: qcom: sdm845-cheza: Add iommus property
      iommu/arm-smmu-qcom: Request direct mapping for modem device

Tero Kristo via iommu (2):
      iommu/omap: Add check for iommu group when no IOMMU in use
      iommu/omap: Add registration for DT fwnode pointer

Thierry Reding (1):
      iommu: Do not probe devices on IOMMU-less busses

Tom Murphy (1):
      iommu/vt-d: Remove IOVA handling code from the non-dma_ops path

Wei Yongjun (1):
      iommu/sun50i: Fix return value check in sun50i_iommu_probe()

Yong Wu (2):
      iommu/mediatek-v1: Add def_domain_type
      iommu/mediatek-v1: Fix a build warning for a unused variable 'data'

 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml  |   61 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    4 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |    3 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |    5 +
 drivers/iommu/Kconfig                              |    9 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/amd_iommu.c                          |  369 +++----
 drivers/iommu/amd_iommu.h                          |   96 +-
 drivers/iommu/amd_iommu_debugfs.c                  |    5 +-
 drivers/iommu/amd_iommu_init.c                     |    4 +-
 drivers/iommu/amd_iommu_proto.h                    |   96 --
 drivers/iommu/amd_iommu_types.h                    |    9 +-
 drivers/iommu/amd_iommu_v2.c                       |   14 +-
 drivers/iommu/arm-smmu-impl.c                      |    8 +-
 drivers/iommu/arm-smmu-qcom.c                      |   37 +-
 drivers/iommu/arm-smmu-v3.c                        |  122 +--
 drivers/iommu/arm-smmu.c                           |   53 +-
 drivers/iommu/arm-smmu.h                           |    1 +
 drivers/iommu/dmar.c                               |   99 +-
 drivers/iommu/exynos-iommu.c                       |   24 +-
 drivers/iommu/fsl_pamu_domain.c                    |   22 +-
 drivers/iommu/hyperv-iommu.c                       |    2 +-
 drivers/iommu/intel-iommu-debugfs.c                |   62 ++
 drivers/iommu/intel-iommu.c                        |  952 ++++++++----------
 drivers/iommu/intel-pasid.c                        |  309 +++++-
 drivers/iommu/intel-pasid.h                        |   27 +-
 drivers/iommu/intel-svm.c                          |  448 +++++++--
 drivers/iommu/intel_irq_remapping.c                |    2 +-
 drivers/iommu/iommu.c                              |  470 ++++++---
 drivers/iommu/iova.c                               |    6 +-
 drivers/iommu/ipmmu-vmsa.c                         |   59 +-
 drivers/iommu/msm_iommu.c                          |   36 +-
 drivers/iommu/mtk_iommu.c                          |   24 +-
 drivers/iommu/mtk_iommu_v1.c                       |   68 +-
 drivers/iommu/omap-iommu.c                         |  103 +-
 drivers/iommu/qcom_iommu.c                         |   24 +-
 drivers/iommu/rockchip-iommu.c                     |   26 +-
 drivers/iommu/s390-iommu.c                         |   22 +-
 drivers/iommu/sun50i-iommu.c                       | 1023 ++++++++++++++++++++
 drivers/iommu/tegra-gart.c                         |   24 +-
 drivers/iommu/tegra-smmu.c                         |   31 +-
 drivers/iommu/virtio-iommu.c                       |   41 +-
 drivers/misc/uacce/uacce.c                         |  172 +---
 drivers/pci/ats.c                                  |   18 +-
 include/linux/intel-iommu.h                        |   82 +-
 include/linux/intel-svm.h                          |   94 +-
 include/linux/iommu.h                              |   63 +-
 include/linux/pci-ats.h                            |    3 +
 include/linux/uacce.h                              |   34 +-
 include/uapi/linux/iommu.h                         |    5 +
 50 files changed, 3345 insertions(+), 1927 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
 delete mode 100644 drivers/iommu/amd_iommu_proto.h
 create mode 100644 drivers/iommu/sun50i-iommu.c

Please pull.

Thanks,

	Joerg

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7eYa4ACgkQK/BELZcB
GuMJ3BAAq64NLMM+Q/arBlmr/L/EjGywMiX2etocW/bhapS22do+lctsXDfUqTxc
BKcFXJrBzaobZN3On55YSrmIpG3wCdRdXS2XP0oRYbvqMqrTJI2XTUo70GtMgrIg
jOmi+TTpE+OEfY2hwSPAlFLd5lG4CguLHch/08x65HoV/j1whekGTjpt66o55XxQ
4JAApE0IrwFGTNmjri0zYFGVK3JX6p6pzgzTM18uZ4mueDZVfEN7pbwg6UalXoFd
SbQiGUfEKm4zR2WYLUCMaF4kMyg/CXUeu5rSS14kuLkzJLbPCnCW3VEbxVXVlRjN
oQlVOiNrohr3ViLDm1+XNoMLQyu7TOrZj9XkxwtvlLaG4cMmOejSAbXJ84sNWcv2
fV/cBy4cl1hqOjHdtiBQIsTZEuuhbDFjcKBN0p963f1m8I2yuGrKUx1M1ynNOn8C
mYiZgohMzE4oPdb2xI+U6XHgHQikCqM61jPOLHyOsOSNHrPbhTmBnY9tW/3FoiiH
u7CbTBfMJfB8ZPMs+8DWnMiPxkNcbmdvUXDX/u40Z4xzvwfrPQiSJHvhn8Ci5Wbu
QqeCd2E9RtjWKyx0FA4TDhDADgO//jex4IcON8BuZzb14pXHWsjTXhXl6i09TW5B
fT+MLONx1arbgn7BU/U4IYl5LyND48qQed1hXLR6oae+QE7++DM=
=GyJw
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============1154420933636883114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1154420933636883114==--
