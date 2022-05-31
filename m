Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58AC433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 12:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 421B882690;
	Tue, 31 May 2022 12:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUIktuJD-_RG; Tue, 31 May 2022 12:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6179F8266A;
	Tue, 31 May 2022 12:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3162BC0039;
	Tue, 31 May 2022 12:37:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36996C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E9168266A
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdGL8N0GHD2s for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:37:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA3AB82668
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:37:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 212264FE; Tue, 31 May 2022 14:37:45 +0200 (CEST)
Date: Tue, 31 May 2022 14:37:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.19
Message-ID: <YpYMFlGhQQOt914S@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============7786400906505991297=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7786400906505991297==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zPPHnwUiWBRWLSRR"
Content-Disposition: inline


--zPPHnwUiWBRWLSRR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Apologies for the late pull request, I know you prefer the main stuff in
the first week. Some vacation and a public holiday came in between here.

So here are the IOMMU updates for 5.19. Some patches are probably
arleady merged via the VFIO tree, namely everyting from the
vfio-notifier-fix topic branch.

Also, there will be a merge conflict in MAINTAINERS and
drivers/iommu/amd/iommu.c. The latter one is resolved by removing the
function in question, for the former I attached my resolution.

With that in mind:

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.19

for you to fetch changes up to b0dacee202efbf1a5d9f5cdfd82049e8b5b085d2:

  Merge branches 'apple/dart', 'arm/mediatek', 'arm/msm', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'vfio-notifier-fix' into next (2022-05-20 12:27:17 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.19

Including:

	- Intel VT-d driver updates
	  - Domain force snooping improvement.
	  - Cleanups, no intentional functional changes.

	- ARM SMMU driver updates
	  - Add new Qualcomm device-tree compatible strings
	  - Add new Nvidia device-tree compatible string for Tegra234
	  - Fix UAF in SMMUv3 shared virtual addressing code
	  - Force identity-mapped domains for users of ye olde SMMU
	    legacy binding
	  - Minor cleanups

	- Patches to fix a BUG_ON in the vfio_iommu_group_notifier
	  - Groundwork for upcoming iommufd framework
	  - Introduction of DMA ownership so that an entire IOMMU group
	    is either controlled by the kernel or by user-space

	- MT8195 and MT8186 support in the Mediatek IOMMU driver

	- Patches to make forcing of cache-coherent DMA more coherent
	  between IOMMU drivers

	- Fixes for thunderbolt device DMA protection

	- Various smaller fixes and cleanups

----------------------------------------------------------------
Bjorn Andersson (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
      iommu/arm-smmu-qcom: Add SC8280XP support

Christophe Leroy (1):
      iommu/fsl_pamu: Prepare cleanup of powerpc's asm/prom.h

Jason Gunthorpe (5):
      vfio: Delete the unbound_list
      iommu: Introduce the domain op enforce_cache_coherency()
      vfio: Move the Intel no-snoop control off of IOMMU_CACHE
      iommu: Redefine IOMMU_CAP_CACHE_COHERENCY as the cap flag for IOMMU_CACHE
      vfio: Require that devices support DMA cache coherence

Jason Gunthorpe via iommu (1):
      iommu: iommu_group_claim_dma_owner() must always assign a domain

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3-sva: Fix mm use-after-free

Joerg Roedel (4):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      iommu/amd: Increase timeout waiting for GA log enablement
      Merge tag 'v5.18-rc7' into arm/smmu
      Merge branches 'apple/dart', 'arm/mediatek', 'arm/msm', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'vfio-notifier-fix' into next

Lu Baolu (17):
      iommu: Add DMA ownership management interfaces
      driver core: Add dma_cleanup callback in bus_type
      amba: Stop sharing platform_dma_configure()
      bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
      PCI: pci_stub: Set driver_managed_dma
      PCI: portdrv: Set driver_managed_dma
      vfio: Set DMA ownership for VFIO devices
      vfio: Remove use of vfio_group_viable()
      vfio: Remove iommu group notifier
      iommu: Remove iommu group changes notifier
      iommu/vt-d: Change return type of dmar_insert_one_dev_info()
      iommu/vt-d: Fold dmar_insert_one_dev_info() into its caller
      iommu/vt-d: Size Page Request Queue to avoid overflow condition
      iommu/vt-d: Block force-snoop domain attaching if no SC support
      iommu/vt-d: Check domain force_snooping against attached devices
      iommu/vt-d: Remove domain_update_iommu_snooping()
      iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

Mario Limonciello (3):
      iommu/amd: Enable swiotlb in all cases
      dma-iommu: Check that swiotlb is active before trying to use it
      iommu/amd: Indicate whether DMA remap support is enabled

Matthew Rosato (1):
      iommu/s390: Tolerate repeat attach_dev calls

Miles Chen (1):
      iommu/mediatek: Fix NULL pointer dereference when printing dev_name

Muhammad Usama Anjum (1):
      iommu/vt-d: Remove unneeded validity check on dev

Rob Herring (1):
      dt-bindings: iommu: Drop client node in examples

Robin Murphy (5):
      iommu: Introduce device_iommu_capable()
      iommu: Add capability for pre-boot DMA protection
      thunderbolt: Make iommu_dma_protection more accurate
      iommu/arm-smmu: Force identity domains for legacy binding
      iommu/dma: Explicitly sort PCI DMA windows

Rohit Agarwal (1):
      dt-bindings: arm-smmu: Add binding for SDX65 SMMU

Suravee Suthikulpanit (1):
      iommu/amd: Do not call sleep while holding spinlock

Sven Peter (1):
      MAINTAINERS: Merge DART into ARM/APPLE MACHINE

Thierry Reding (3):
      dt-bindings: arm-smmu: Document nvidia,memory-controller property
      dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
      iommu/arm-smmu: Support Tegra234 SMMU

Vasant Hegde via iommu (1):
      iommu/amd: Remove redundant check

Xiaoke Wang (1):
      iommu/msm: Add a check for the return of kzalloc()

Xiaomeng Tong (1):
      iommu/msm: Fix an incorrect NULL check on list iterator

Yang Yingliang (2):
      iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      iommu/arm-smmu-v3: check return value after calling platform_get_resource()

Yong Wu (36):
      dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
      dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
      dt-bindings: mediatek: mt8186: Add binding for MM iommu
      iommu/mediatek: Fix 2 HW sharing pgtable issue
      iommu/mediatek: Add list_del in mtk_iommu_remove
      iommu/mediatek: Remove clk_disable in mtk_iommu_remove
      iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
      iommu/mediatek: Add mutex for data in the mtk_iommu_domain
      iommu/mediatek: Adapt sharing and non-sharing pgtable case
      iommu/mediatek: Add 12G~16G support for multi domains
      iommu/mediatek: Add a flag DCM_DISABLE
      iommu/mediatek: Add a flag STD_AXI_MODE
      iommu/mediatek: Remove the granule in the tlb flush
      iommu/mediatek: Always enable output PA over 32bits in isr
      iommu/mediatek: Add SUB_COMMON_3BITS flag
      iommu/mediatek: Add IOMMU_TYPE flag
      iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
      iommu/mediatek: Adjust device link when it is sub-common
      iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
      iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
      iommu/mediatek: Add infra iommu support
      iommu/mediatek: Add PCIe support
      iommu/mediatek: Add mt8195 support
      iommu/mediatek: Only adjust code about register base
      iommu/mediatek: Just move code position in hw_init
      iommu/mediatek: Separate mtk_iommu_data for v1 and v2
      iommu/mediatek: Remove mtk_iommu.h
      iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
      iommu/mediatek: Add mtk_iommu_bank_data structure
      iommu/mediatek: Initialise bank HW for each a bank
      iommu/mediatek: Change the domid to iova_region_id
      iommu/mediatek: Get the proper bankid for multi banks
      iommu/mediatek: Initialise/Remove for multi bank dev
      iommu/mediatek: Backup/restore regsiters for multi banks
      iommu/mediatek: mt8195: Enable multi banks for infra iommu
      iommu/mediatek: Add mt8186 iommu support

Yunfei Wang (1):
      iommu/dma: Fix iova map result check bug

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  25 +-
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  34 +-
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml  |  10 -
 MAINTAINERS                                        |  10 +-
 drivers/amba/bus.c                                 |  37 +-
 drivers/base/dd.c                                  |   5 +
 drivers/base/platform.c                            |  21 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  24 +-
 drivers/iommu/amd/amd_iommu_types.h                |   4 +
 drivers/iommu/amd/init.c                           |   8 +-
 drivers/iommu/amd/iommu.c                          |  16 +-
 drivers/iommu/amd/iommu_v2.c                       |  12 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  13 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   8 +-
 drivers/iommu/dma-iommu.c                          |  25 +-
 drivers/iommu/fsl_pamu.c                           |   3 +
 drivers/iommu/fsl_pamu_domain.c                    |   1 +
 drivers/iommu/intel/iommu.c                        | 216 ++---
 drivers/iommu/intel/pasid.c                        |  45 +-
 drivers/iommu/intel/pasid.h                        |   2 +
 drivers/iommu/iommu.c                              | 354 +++++---
 drivers/iommu/msm_iommu.c                          |  22 +-
 drivers/iommu/mtk_iommu.c                          | 980 +++++++++++++++------
 drivers/iommu/mtk_iommu.h                          | 101 ---
 drivers/iommu/mtk_iommu_v1.c                       | 242 ++---
 drivers/iommu/s390-iommu.c                         |  15 +-
 drivers/pci/of.c                                   |   8 +-
 drivers/pci/pci-driver.c                           |  18 +
 drivers/pci/pci-stub.c                             |   1 +
 drivers/pci/pcie/portdrv_pci.c                     |   2 +
 drivers/thunderbolt/domain.c                       |  12 +-
 drivers/thunderbolt/nhi.c                          |  44 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |   1 +
 drivers/vfio/pci/vfio_pci.c                        |   1 +
 drivers/vfio/platform/vfio_amba.c                  |   1 +
 drivers/vfio/platform/vfio_platform.c              |   1 +
 drivers/vfio/vfio.c                                | 252 +-----
 drivers/vfio/vfio_iommu_type1.c                    |  30 +-
 include/dt-bindings/memory/mt8186-memory-port.h    | 217 +++++
 include/dt-bindings/memory/mt8195-memory-port.h    | 408 +++++++++
 include/dt-bindings/memory/mtk-memory-port.h       |   2 +
 include/linux/amba/bus.h                           |   8 +
 include/linux/device/bus.h                         |   3 +
 include/linux/fsl/mc.h                             |   8 +
 include/linux/intel-iommu.h                        |   3 +-
 include/linux/intel-svm.h                          |   2 +-
 include/linux/iommu.h                              |  69 +-
 include/linux/pci.h                                |   8 +
 include/linux/platform_device.h                    |  10 +-
 include/linux/thunderbolt.h                        |   2 +
 53 files changed, 2317 insertions(+), 1033 deletions(-)
 delete mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
 create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h

Please pull.

Thanks,

	Joerg

diff --cc MAINTAINERS
index b85ee59e808b,1f4f4ba84c2e..f1b4b77daa5f
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1834,9 -1829,8 +1826,10 @@@ F:	Documentation/devicetree/bindings/ar
  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
+ F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 +F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 +F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
  F:	Documentation/devicetree/bindings/power/apple*
@@@ -1845,9 -1839,9 +1838,10 @@@ F:	arch/arm64/boot/dts/apple
  F:	drivers/clk/clk-apple-nco.c
  F:	drivers/i2c/busses/i2c-pasemi-core.c
  F:	drivers/i2c/busses/i2c-pasemi-platform.c
+ F:	drivers/iommu/apple-dart.c
  F:	drivers/irqchip/irq-apple-aic.c
  F:	drivers/mailbox/apple-mailbox.c
 +F:	drivers/nvme/host/apple.c
  F:	drivers/pinctrl/pinctrl-apple-gpio.c
  F:	drivers/soc/apple/*
  F:	drivers/watchdog/apple_wdt.c

--zPPHnwUiWBRWLSRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmKWDBMACgkQK/BELZcB
GuP9QhAAziT3t/hlzTkHEK9gwHYXCjl8j6WBSIgBivtFiby/kdCF1jFxkHEptI8p
IaK946Obu8ccyBpZebH+82xQeZn0B7mBQs4oa/HYdI7dWZgvrQ0gv1hf4U9ThA3O
sqqrSTQkuKpt17+99gvkJbazf0mceqdlRasnOzclAhH431aXKQMtZYPCha4Jzno6
EXPf4IGtQX8Myq/7iV2A8NvibH8jXGi+UEKfugichh5wdh11goS/kHsq52SVzuco
PJS498c0vfFldwegMr4gBoiPdFkc/DIhMe8i+juXO0CRclLkSOft4zgAfdwC++ZX
Bp/RvCI+1Hom2UWTLvJP460qwZZcEhl5VU/dQjyXnO6B4D+inpgEYrqWzY9fPBXm
xZq8fPQYZixZ59/+cx64hOBn1b4qhQmCTl66wBukutNM6zpv38pJj86drJiN/1Hi
88d95qWuOPj1Jnr4xH/LqYX/DQhthD0VvllOzBofqUjyogn1WDhoHYOslOHAFyS1
VMjUfCz++ey9zZ+q1vVUFCR1009W+k0PyLa9k20DziAUCeJGAuzUIIPwew+Gv2sd
BA3G2gId6L9Di9wSL3c/cSwfp1jLOagqBVdA9HeHYm6BWwOh5IZFPb4PFRn7UGI3
ftKoDbCdExbY1CjpHoxQVo5MCgbJejDpI2DL0TVGjLfkRIZu18c=
=i1nP
-----END PGP SIGNATURE-----

--zPPHnwUiWBRWLSRR--

--===============7786400906505991297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7786400906505991297==--
