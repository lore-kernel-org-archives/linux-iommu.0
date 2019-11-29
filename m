Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB0C432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7599C2086A
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 12:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7599C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3715E88560;
	Fri, 29 Nov 2019 12:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWfhcHFQnhwB; Fri, 29 Nov 2019 12:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 438908855E;
	Fri, 29 Nov 2019 12:10:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FDC6C1DD5;
	Fri, 29 Nov 2019 12:10:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7E12C0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B149B20387
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QvXfFL9xda8J for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 12:10:08 +0000 (UTC)
X-Greylist: delayed 00:07:12 by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 743C920373
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:10:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6F2CC3AA; Fri, 29 Nov 2019 13:02:53 +0100 (CET)
Date: Fri, 29 Nov 2019 13:02:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.5
Message-ID: <20191129120247.GA6874@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============5050399561676079865=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5050399561676079865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.5

for you to fetch changes up to 9b3a713feef8db41d4bcccb3b97e86ee906690c8:

  Merge branches 'iommu/fixes', 'arm/qcom', 'arm/renesas', 'arm/rockchip', 'arm/mediatek', 'arm/tegra', 'arm/smmu', 'x86/amd', 'x86/vt-d', 'virtio' and 'core' into next (2019-11-12 17:11:25 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.5

Including:

	- Conversion of the AMD IOMMU driver to use the dma-iommu code
	  for imlementing the DMA-API. This gets rid of quite some code
	  in the driver itself, but also has some potential for
	  regressions (non are known at the moment).

	- Support for the Qualcomm SMMUv2 implementation in the SDM845
	  SoC.  This also includes some firmware interface changes, but
	  those are acked by the respective maintainers.

	- Preparatory work to support two distinct page-tables per
	  domain in the ARM-SMMU driver

	- Power management improvements for the ARM SMMUv2

	- Custom PASID allocator support

	- Multiple PCI DMA alias support for the AMD IOMMU driver

	- Adaption of the Mediatek driver to the changed IO/TLB flush
	  interface of the IOMMU core code.

	- Preparatory patches for the Renesas IOMMU driver to support
	  future hardware.

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: iommu: ipmmu-vmsa: Add r8a774b1 support
      iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code

Christophe JAILLET (3):
      iommu/io-pgtable: Move some initialization data to .init.rodata
      iommu/arm-smmu: Axe a useless test in 'arm_smmu_master_alloc_smes()'
      iommu/qcom: Simplify a test in 'qcom_iommu_add_device()'

Cristiane Naves (1):
      iommu/virtio: Remove unused variable

Deepa Dinamani (1):
      iommu/vt-d: Turn off translations at shutdown

Denys Vlasenko (1):
      iommu/amd: Do not re-fetch iommu->cmd_buf_tail

Eric Auger (1):
      iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and QI_DEV_EIOTLB_PFSID macros

Ezequiel Garcia (1):
      iommu: rockchip: Free domain on .domain_free

Jacob Pan (2):
      iommu/ioasid: Add custom allocators
      iommu: Introduce guest PASID bind function

Jean-Philippe Brucker (3):
      iommu: Add I/O ASID allocator
      iommu/arm-smmu-v3: Don't display an error when IRQ lines are missing
      iommu/arm-smmu: Remove duplicate error message

Joerg Roedel (3):
      iommu/amd: Pass gfp flags to iommu_map_page() in amd_iommu_map()
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'iommu/fixes', 'arm/qcom', 'arm/renesas', 'arm/rockchip', 'arm/mediatek', 'arm/tegra', 'arm/smmu', 'x86/amd', 'x86/vt-d', 'virtio' and 'core' into next

Logan Gunthorpe (2):
      iommu/amd: Support multiple PCI DMA aliases in device table
      iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping

Lu Baolu (2):
      iommu/vt-d: Refactor find_domain() helper
      MAINTAINERS: Update for INTEL IOMMU (VT-d) entry

Navneet Kumar (2):
      iommu/tegra-smmu: Use non-secure register for flushing
      iommu/tegra-smmu: Fix client enablement order

Rob Clark (1):
      iommu/arm-smmu: Avoid pathological RPM behaviour for unmaps

Robin Murphy (13):
      iommu/arm-smmu: Remove .tlb_inv_range indirection
      iommu/arm-smmu: Remove "leaf" indirection
      iommu/arm-smmu: Move .tlb_sync method to implementation
      iommu/arm-smmu: Remove arm_smmu_flush_ops
      iommu/arm-smmu: Report USF more clearly
      iommu/io-pgtable: Make selftest gubbins consistently __init
      iommu/io-pgtable-arm: Rationalise size check
      iommu/io-pgtable-arm: Simplify bounds checks
      iommu/io-pgtable-arm: Simplify start level lookup
      iommu/io-pgtable-arm: Simplify PGD size handling
      iommu/io-pgtable-arm: Simplify level indexing
      iommu/io-pgtable-arm: Rationalise MAIR handling
      iommu/rockchip: Don't provoke WARN for harmless IRQs

Suthikulpanit, Suravee (1):
      iommu/amd: Simpify decoding logic for INVALID_PPR_REQUEST event

Thierry Reding (1):
      iommu/tegra-smmu: Fix page tables in > 4 GiB memory

Tom Murphy (5):
      iommu/amd: Remove unnecessary locking from AMD iommu driver
      iommu: Add gfp parameter to iommu_ops::map
      iommu/dma-iommu: Handle deferred devices
      iommu/dma-iommu: Use the dev->coherent_dma_mask
      iommu/amd: Convert AMD iommu driver to the dma-iommu api

Vivek Gautam (3):
      firmware: qcom_scm-64: Add atomic version of qcom_scm_call
      firmware/qcom_scm: Add scm call to handle smmu errata
      iommu: arm-smmu-impl: Add sdm845 implementation hook

Will Deacon (3):
      firmware: qcom: scm: Ensure 'a0' status code is treated as signed
      Merge branch 'for-joerg/arm-smmu/fixes' into for-joerg/arm-smmu/updates
      iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve doc

Yi L Liu (1):
      iommu: Introduce cache_invalidate API

Yian Chen (1):
      iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved

Yong Wu (8):
      memory: mtk-smi: Add PM suspend and resume ops
      iommu/mediatek: Correct the flush_iotlb_all callback
      iommu/mediatek: Add a new tlb_lock for tlb_flush
      iommu/mediatek: Use gather to achieve the tlb range flush
      iommu/mediatek: Delete the leaf in the tlb_flush
      iommu/mediatek: Move the tlb_sync into tlb_flush
      iommu/mediatek: Get rid of the pgtlock
      iommu/mediatek: Reduce the tlb flush timeout value

Yoshihiro Shimoda (6):
      iommu/ipmmu-vmsa: Remove all unused register definitions
      iommu/ipmmu-vmsa: tidyup register definitions
      iommu/ipmmu-vmsa: Add helper functions for MMU "context" registers
      iommu/ipmmu-vmsa: Calculate context registers' offset instead of a macro
      iommu/ipmmu-vmsa: Add helper functions for "uTLB" registers
      iommu/ipmmu-vmsa: Add utlb_offset_base

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   1 +
 MAINTAINERS                                        |   7 +-
 arch/ia64/include/asm/iommu.h                      |   5 +
 arch/x86/include/asm/iommu.h                       |  18 +
 drivers/firmware/qcom_scm-32.c                     |   5 +
 drivers/firmware/qcom_scm-64.c                     | 153 ++--
 drivers/firmware/qcom_scm.c                        |   6 +
 drivers/firmware/qcom_scm.h                        |   5 +
 drivers/iommu/Kconfig                              |   5 +
 drivers/iommu/Makefile                             |   3 +-
 drivers/iommu/amd_iommu.c                          | 893 ++++-----------------
 drivers/iommu/amd_iommu_types.h                    |   3 +-
 drivers/iommu/arm-smmu-impl.c                      |   5 +-
 drivers/iommu/arm-smmu-qcom.c                      |  51 ++
 drivers/iommu/arm-smmu-v3.c                        |  12 +-
 drivers/iommu/arm-smmu.c                           | 223 ++---
 drivers/iommu/arm-smmu.h                           |  16 +-
 drivers/iommu/dma-iommu.c                          |  43 +-
 drivers/iommu/dmar.c                               |   5 +-
 drivers/iommu/exynos-iommu.c                       |   2 +-
 drivers/iommu/intel-iommu.c                        |  61 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  15 +-
 drivers/iommu/io-pgtable-arm.c                     | 130 +--
 drivers/iommu/ioasid.c                             | 422 ++++++++++
 drivers/iommu/iommu.c                              |  73 +-
 drivers/iommu/ipmmu-vmsa.c                         | 223 +++--
 drivers/iommu/msm_iommu.c                          |   2 +-
 drivers/iommu/mtk_iommu.c                          |  90 +--
 drivers/iommu/mtk_iommu.h                          |   2 +-
 drivers/iommu/mtk_iommu_v1.c                       |   2 +-
 drivers/iommu/omap-iommu.c                         |   2 +-
 drivers/iommu/qcom_iommu.c                         |  10 +-
 drivers/iommu/rockchip-iommu.c                     |  11 +-
 drivers/iommu/s390-iommu.c                         |   2 +-
 drivers/iommu/tegra-gart.c                         |   2 +-
 drivers/iommu/tegra-smmu.c                         |  38 +-
 drivers/iommu/virtio-iommu.c                       |   5 +-
 drivers/memory/mtk-smi.c                           |   4 +
 include/linux/dmar.h                               |   2 +
 include/linux/intel-iommu.h                        |   6 +-
 include/linux/io-pgtable.h                         |   2 +-
 include/linux/ioasid.h                             |  76 ++
 include/linux/iommu.h                              |  65 +-
 include/linux/qcom_scm.h                           |   2 +
 include/uapi/linux/iommu.h                         | 169 ++++
 45 files changed, 1660 insertions(+), 1217 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-qcom.c
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

Please pull.

Thanks,

	Joerg

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl3hCOcACgkQK/BELZcB
GuO9FA//cYhLGHPQ8ReY/bOvxYLmALu42P6FvUpENmmFo7blIl6KZbKQG6ZzO1lY
LcmmOqgxLyoBaanxC5WupCqicytYx2odkeDnbHn/TLe7ySpZ8nrrW2+8lw0zm4Mp
HmX4i7ZqmAwGUxlnNe8eN2I3/iFf4hkRMu41SGWrZwJ3q+S988ZRZeXP5h9dtvag
lPQ8m4GH/GHubdwH0oD+dKKvjmMggVFhGH14XKr6+uTp9TnqNkncY4WTdYkVYl8t
6X1x7darSfQ03IgmaKdlrUL9kdz765wTDQb5T/vx9rSoatgCjNNPKI3oqVejD8gn
O77BeC8vC64UasMXoCvv70zIZXZPhhgugsfrXA166LKvDTVk7O/syqL2ofp9e8i/
gkLkMDG7BO3Fntlof1sKzvQm9KQ/j28Vnhb2GHFf8mPMEZfoXRfkriLAkS4EeXbR
Laj++0sGCzhwx4ghcIar9+6goePyHgXFVcRMn6Cris/B2o7zDHei973uV8TAEVWg
P2TLU+Qc3/CeJECdaKWEQ8m4udSPxdlg4xD5TQU+0JKqQN3buxHPVPKUf1DC8fwj
jNVBiW7iouIaqgC0Vnt8TYmPbIaLfQdnUqJr2g32QUDXKv9DTQowNeopcpOKM8Fe
jG1GkZDJ9NU6/G6sZOddrcYopFlcea+th7lURQuYqpp2j4UKIh8=
=S48G
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============5050399561676079865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5050399561676079865==--
