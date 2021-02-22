Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CBC433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 16:17:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317B264EC3
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 16:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317B264EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D65AC85F09;
	Mon, 22 Feb 2021 16:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFqR7NJWWr7l; Mon, 22 Feb 2021 16:17:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8550B81A18;
	Mon, 22 Feb 2021 16:17:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5678CC000B;
	Mon, 22 Feb 2021 16:17:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CF5C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 16:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DB9D58723B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 16:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkoPjtgR72GL for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 16:17:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C69E98720E
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 16:17:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C7F432D5; Mon, 22 Feb 2021 17:17:36 +0100 (CET)
Date: Mon, 22 Feb 2021 17:17:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.12
Message-ID: <20210222161729.GA26068@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============2634752441476882918=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2634752441476882918==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.12

for you to fetch changes up to 45e606f2726926b04094e1c9bf809bca4884c57f:

  Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-02-12 15:27:17 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.12

Including:

	- ARM SMMU and Mediatek updates from Will Deacon:

		- Support for MT8192 IOMMU from Mediatek

		- Arm v7s io-pgtable extensions for MT8192

		- Removal of TLBI_ON_MAP quirk

		- New Qualcomm compatible strings

		- Allow SVA without hardware broadcast TLB maintenance
		  on SMMUv3

		- Virtualization Host Extension support for SMMUv3 (SVA)

		- Allow SMMUv3 PMU (perf) driver to be built
		  independently from IOMMU

	- Some tidy-up in IOVA and core code

	- Conversion of the AMD IOMMU code to use the generic
	  IO-page-table framework

	- Intel VT-d updates from Lu Baolu:

		- Audit capability consistency among different IOMMUs

		- Add SATC reporting structure support

		- Add iotlb_sync_map callback support

	- SDHI Support for Renesas IOMMU driver

	- Misc Cleanups and other small improvments

----------------------------------------------------------------
Adrian Huang (1):
      iommu/amd: Remove unnecessary assignment

Bjorn Andersson (2):
      dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
      iommu/arm-smmu-qcom: Add Qualcomm SC8180X impl

Bjorn Helgaas (1):
      iommu/vt-d: Fix 'physical' typos

Colin Ian King (1):
      iommu/mediatek: Fix unsigned domid comparison with less than zero

Dan Carpenter (1):
      iommu/mediatek: Fix error code in probe()

Douglas Anderson (1):
      iommu: Properly pass gfp_t in _iommu_map() to avoid atomic sleeping

Isaac J. Manjarres (1):
      iommu/arm-smmu-qcom: Fix mask extraction for bootloader programmed SMRs

Jean-Philippe Brucker (3):
      iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
      iommu/arm-smmu-v3: Make BTM optional for SVA
      iommu/arm-smmu-v3: Add support for VHE

Joerg Roedel (2):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next

John Garry (7):
      iova: Make has_iova_flush_queue() private
      iova: Delete copy_reserved_iova()
      iova: Stop exporting some more functions
      iommu: Stop exporting iommu_map_sg_atomic()
      iommu: Delete iommu_domain_window_disable()
      iommu: Delete iommu_dev_has_feature()
      driver/perf: Remove ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3

Kyung Min Park (2):
      iommu/vt-d: Audit IOMMU Capabilities and add helper functions
      iommu/vt-d: Move capability check code to cap_audit files

Lianbo Jiang (2):
      dma-iommu: use static-key to minimize the impact in the fast-path
      iommu: use the __iommu_attach_device() directly for deferred attach

Lu Baolu (7):
      iommu/vt-d: Consolidate duplicate cache invaliation code
      iommu/vt-d: Add qi_submit trace event
      iommu/vt-d: Preset Access/Dirty bits for IOVA over FL
      iommu/vt-d: Clear PRQ overflow only when PRQ is empty
      iommu/vt-d: Use INVALID response code instead of FAILURE
      iommu/vt-d: Fix compile error [-Werror=implicit-function-declaration]
      iommu/vt-d: Add iotlb_sync_map callback

Lukas Bulwahn (1):
      MAINTAINERS: repair file pattern in MEDIATEK IOMMU DRIVER

Robin Murphy (3):
      iommu/arm-smmu-v3: Remove the page 1 fixup
      iommu/msm: Hook up iotlb_sync_map
      iommu/io-pgtable: Remove TLBI_ON_MAP quirk

Suravee Suthikulpanit (14):
      iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
      iommu/amd: Prepare for generic IO page table framework
      iommu/amd: Move pt_root to struct amd_io_pgtable
      iommu/amd: Convert to using amd_io_pgtable
      iommu/amd: Declare functions as extern
      iommu/amd: Move IO page table related functions
      iommu/amd: Restructure code for freeing page table
      iommu/amd: Remove amd_iommu_domain_get_pgtable
      iommu/amd: Rename variables to be consistent with struct io_pgtable_ops
      iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
      iommu/amd: Introduce iommu_v1_iova_to_phys
      iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
      iommu/amd: Adopt IO page table framework for AMD IOMMU v1 page table
      iommu/amd: Fix performance counter initialization

Tom Rix (1):
      iommu/amd: remove h from printk format specifier

Vinod Koul (2):
      dt-bindings: arm-smmu: Add sm8350 compatible string
      iommu: arm-smmu-impl: Add SM8350 qcom iommu implementation

Will Deacon (1):
      Merge branch 'for-joerg/mtk' into for-joerg/arm-smmu/updates

Yian Chen (2):
      iommu/vt-d: Add new enum value and structure for SATC
      iommu/vt-d: Parse SATC reporting structure

Yong Wu (38):
      iommu: Move iotlb_sync_map out from __iommu_map
      iommu: Add iova and size as parameters in iotlb_sync_map
      iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
      iommu: Switch gather->end to the inclusive end
      iommu/io-pgtable: Allow io_pgtable_tlb ops optional
      iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
      iommu/mediatek: Remove the tlb-ops for v7s
      dt-bindings: iommu: mediatek: Convert IOMMU to DT schema
      dt-bindings: memory: mediatek: Add a common memory header file
      dt-bindings: memory: mediatek: Extend LARB_NR_MAX to 32
      dt-bindings: memory: mediatek: Rename header guard for SMI header file
      dt-bindings: mediatek: Add binding for mt8192 IOMMU
      iommu/mediatek: Use the common mtk-memory-port.h
      iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
      iommu/io-pgtable-arm-v7s: Extend PA34 for MediaTek
      iommu/io-pgtable-arm-v7s: Clarify LVL_SHIFT/BITS macro
      iommu/io-pgtable-arm-v7s: Add cfg as a param in some macros
      iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
      iommu/mediatek: Add a flag for iova 34bits case
      iommu/mediatek: Update oas for v7s
      iommu/mediatek: Move hw_init into attach_device
      iommu/mediatek: Add error handle for mtk_iommu_probe
      iommu/mediatek: Add device link for smi-common and m4u
      iommu/mediatek: Add pm runtime callback
      iommu/mediatek: Add power-domain operation
      iommu/mediatek: Support up to 34bit iova in tlb flush
      iommu/mediatek: Support report iova 34bit translation fault in ISR
      iommu/mediatek: Adjust the structure
      iommu/mediatek: Move domain_finalise into attach_device
      iommu/mediatek: Move geometry.aperture updating into domain_finalise
      iommu/mediatek: Add iova_region structure
      iommu/mediatek: Add get_domain_id from dev->dma_range_map
      iommu/mediatek: Support for multi domains
      iommu/mediatek: Add iova reserved function
      iommu/mediatek: Support master use iova over 32bit
      iommu/mediatek: Remove unnecessary check in attach_device
      iommu/mediatek: Add mt8192 support
      MAINTAINERS: Add entry for MediaTek IOMMU

Yoshihiro Shimoda (2):
      iommu/ipmmu-vmsa: Refactor ipmmu_of_xlate()
      iommu/ipmmu-vmsa: Allow SDHI devices

Zhen Lei (1):
      iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify code

Zheng Yongjun (1):
      iommu/amd: Use DEFINE_SPINLOCK() for spinlock

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 105 ----
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  | 183 ++++++
 MAINTAINERS                                        |   9 +
 drivers/iommu/amd/Kconfig                          |   1 +
 drivers/iommu/amd/Makefile                         |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |  22 +
 drivers/iommu/amd/amd_iommu_types.h                |  43 +-
 drivers/iommu/amd/init.c                           |  54 +-
 drivers/iommu/amd/io_pgtable.c                     | 558 +++++++++++++++++
 drivers/iommu/amd/iommu.c                          | 672 +++------------------
 drivers/iommu/amd/iommu_v2.c                       |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 154 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  14 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   5 +
 drivers/iommu/dma-iommu.c                          |  29 +-
 drivers/iommu/intel/Makefile                       |   2 +-
 drivers/iommu/intel/cap_audit.c                    | 205 +++++++
 drivers/iommu/intel/cap_audit.h                    | 130 ++++
 drivers/iommu/intel/dmar.c                         |  11 +
 drivers/iommu/intel/iommu.c                        | 279 +++++----
 drivers/iommu/intel/irq_remapping.c                |   8 +
 drivers/iommu/intel/pasid.c                        |  18 +-
 drivers/iommu/intel/svm.c                          |  73 +--
 drivers/iommu/io-pgtable-arm-v7s.c                 |  65 +-
 drivers/iommu/io-pgtable.c                         |   3 +
 drivers/iommu/iommu.c                              |  54 +-
 drivers/iommu/iova.c                               |  35 +-
 drivers/iommu/ipmmu-vmsa.c                         |  53 +-
 drivers/iommu/msm_iommu.c                          |  10 +-
 drivers/iommu/mtk_iommu.c                          | 410 +++++++++----
 drivers/iommu/mtk_iommu.h                          |  12 +-
 drivers/iommu/tegra-gart.c                         |   7 +-
 drivers/memory/mtk-smi.c                           |   8 +
 drivers/perf/Kconfig                               |   2 +-
 include/acpi/actbl1.h                              |  11 +-
 include/dt-bindings/memory/mt2701-larb-port.h      |   4 +-
 include/dt-bindings/memory/mt2712-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt6779-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8167-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8183-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8192-larb-port.h      | 243 ++++++++
 include/dt-bindings/memory/mtk-memory-port.h       |  15 +
 include/linux/dmar.h                               |   2 +
 include/linux/intel-iommu.h                        |  43 +-
 include/linux/io-pgtable.h                         |  19 +-
 include/linux/iommu.h                              |  21 +-
 include/linux/iova.h                               |  12 -
 include/soc/mediatek/smi.h                         |   3 +-
 include/trace/events/intel_iommu.h                 |  39 +-
 52 files changed, 2389 insertions(+), 1305 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
 create mode 100644 drivers/iommu/amd/io_pgtable.c
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h
 create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
 create mode 100644 include/dt-bindings/memory/mtk-memory-port.h

Please pull.

Thanks,

	Joerg

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmAz2RkACgkQK/BELZcB
GuOcxQ/8DUZqhE7p8cwhN0OAibSCihVltr6N8pPfA2X3lCNCPrIRAAtOSzvgxhbu
bhLGyFHsPmJPu2lG6Or07Hwb2zzTCATC9Sg26x5YhiqokJnDRymCyYqvU93PaLGd
3OWTSXYPvWYNGmviA9hHNA1strdANa3uF4Yo+O+ksX/KpvXOppLJ6Wxyzest5LYp
Yecom8UJBPXZdRenkBabWxCpB+MZRLwuriythHLfJNjhtHwaHvETB6rP/A+HxRJP
aeRlJuS/yr20Ne/kb5cGTfa6ja5m86A5SE4Vg4mGvjniHkm6oA3UNqAGlsjyuPg4
1vECoorPO+lTh7UqEXZelsqkOYVCHMIIPF+wiYVF9t4myPn6r6rhGxsIW9CwVwRb
e4xZAjG5xkAHndozAKypOkBDNR6iEKTx63Lg3dUUyv23ugdnY9elKOILm9s5Cuo+
NFSnREG2+30Y+E3hOCwn3g3Qaqf2XPPxJ5w4go1+lRmy3PPHw+Lnn1f8eLiKFRQe
+0mYLFrzixlm2CetB9WstB9Toij9tbw3AoI2vfQgKdjPXjUy74IWsmxBNZsw9sU4
7wL/CzIoXHUcSa7w92oGEo+KfQV0fk083peXA880C6LYcKonOzJ43OCPTIcMva7A
GgyhupU1xwcfPdlOrJHz5hlPcVWGmdk08AxgYUaud3GaDscdVzQ=
=j+2K
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

--===============2634752441476882918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2634752441476882918==--
