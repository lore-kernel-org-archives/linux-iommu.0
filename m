Return-Path: <SRS0=jbNj=BV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7438DC433DF
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 12:48:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD082075D
	for <iommu@archiver.kernel.org>; Tue, 11 Aug 2020 12:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD082075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC5F087CDA;
	Tue, 11 Aug 2020 12:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrqtFUOnLfV8; Tue, 11 Aug 2020 12:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4937F87C9C;
	Tue, 11 Aug 2020 12:48:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A31BC07FF;
	Tue, 11 Aug 2020 12:48:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FE7C004D
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 12:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 71E518764F
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 12:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZfIPO13WZJv6 for <iommu@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:47:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4EF187645
 for <iommu@lists.linux-foundation.org>; Tue, 11 Aug 2020 12:47:58 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2347233E; Tue, 11 Aug 2020 14:47:55 +0200 (CEST)
Date: Tue, 11 Aug 2020 14:47:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.9
Message-ID: <20200811124747.GA13876@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============3950051508485463120=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3950051508485463120==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

there is a tiny conflict with your tree because of the Kconfig changes
this time. Please see my attached resolution. With that in mind:

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v5.9

for you to fetch changes up to e46b3c0d011eab9933c183d5b47569db8e377281:

  Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel=
/git/will/linux into next (2020-07-29 14:47:37 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.9

Including:

	- Removal of the dev->archdata.iommu (or similar) pointers from
	  most architectures. Only Sparc is left, but this is private to
	  Sparc as their drivers don't use the IOMMU-API.

	- ARM-SMMU Updates from Will Deacon:

	  -  Support for SMMU-500 implementation in Marvell
	     Armada-AP806 SoC

	  - Support for SMMU-500 implementation in NVIDIA Tegra194 SoC

	  - DT compatible string updates

	  - Remove unused IOMMU_SYS_CACHE_ONLY flag

	  - Move ARM-SMMU drivers into their own subdirectory

	- Intel VT-d Updates from Lu Baolu:

	  - Misc tweaks and fixes for vSVA

	  - Report/response page request events

	  - Cleanups

	- Move the Kconfig and Makefile bits for the AMD and Intel
	  drivers into their respective subdirectory.

	- MT6779 IOMMU Support

	- Support for new chipsets in the Renesas IOMMU driver

	- Other misc cleanups and fixes (e.g. to improve compile test
	  coverage)

----------------------------------------------------------------
Alexander A. Klimov (1):
      iommu/omap: Replace HTTP links with HTTPS ones

Baolin Wang (2):
      iommu: Mark __iommu_map_sg() as static
      iommu: Add gfp parameter to io_pgtable_ops->map()

Chao Hao (10):
      dt-bindings: mediatek: Add bindings for MT6779
      iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_C=
TRL
      iommu/mediatek: Use a u32 flags to describe different HW features
      iommu/mediatek: Setting MISC_CTRL register
      iommu/mediatek: Move inv_sel_reg into the plat_data
      iommu/mediatek: Add sub_comm id in translation fault
      iommu/mediatek: Add REG_MMU_WR_LEN_CTRL register definition
      iommu/mediatek: Extend protect pa alignment value
      iommu/mediatek: Modify MMU_CTRL register setting
      iommu/mediatek: Add mt6779 basic support

Colin Ian King (1):
      iommu/omap: Check for failure of a call to omap_iommu_dump_ctx

Denis Efremov (1):
      iommu/pamu: Use kzfree() in fsl_pamu_probe()

Hanna Hawa (1):
      iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #5827=
43

Jacob Pan (4):
      iommu/vt-d: Remove global page support in devTLB flush
      iommu/vt-d: Fix PASID devTLB invalidation
      iommu/vt-d: Warn on out-of-range invalidation address
      iommu/vt-d: Disable multiple GPASID-dev bind

Jean-Philippe Brucker (1):
      iommu: Allow page responses without PASID

Jerry Snitselaar (3):
      iommu: Add include/uapi/linux/iommu.h to MAINTAINERS file
      iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
      iommu/amd: Move Kconfig and Makefile bits down into amd directory

Joe Perches (1):
      iommu/qcom: Change CONFIG_BIG_ENDIAN to CONFIG_CPU_BIG_ENDIAN

Joerg Roedel (19):
      Merge tag 'v5.8-rc3' into arm/qcom
      iommu/amd: Add helper functions to update domain->pt_root
      iommu/exynos: Use dev_iommu_priv_get/set()
      iommu/vt-d: Use dev_iommu_priv_get/set()
      iommu/msm: Use dev_iommu_priv_get/set()
      iommu/omap: Use dev_iommu_priv_get/set()
      iommu/rockchip: Use dev_iommu_priv_get/set()
      iommu/tegra: Use dev_iommu_priv_get/set()
      iommu/pamu: Use dev_iommu_priv_get/set()
      iommu/mediatek: Do no use dev->archdata.iommu
      x86: Remove dev->archdata.iommu pointer
      ia64: Remove dev->archdata.iommu pointer
      arm: Remove dev->archdata.iommu pointer
      arm64: Remove dev->archdata.iommu pointer
      powerpc/dma: Remove dev->archdata.iommu_domain
      iommu/mediatek: Include liunx/dma-mapping.h
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux i=
nto arm/smmu
      Merge branches 'arm/renesas', 'arm/qcom', 'arm/mediatek', 'arm/omap',=
 'arm/exynos', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' int=
o next
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux i=
nto next

John Garry (1):
      iommu/arm-smmu-v3: Fix trivial typo

Jonathan Marek (2):
      dt-bindings: arm-smmu: Add sm8150 and sm8250 compatible strings
      iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles

Krishna Reddy (5):
      iommu/arm-smmu: move TLB timeout and spin count macros
      iommu/arm-smmu: ioremap smmu mmio region before implementation init
      iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
      dt-bindings: arm-smmu: add binding for Tegra194 SMMU
      iommu/arm-smmu: Add global/context fault implementation hooks

Lad Prabhakar (1):
      iommu/ipmmu-vmsa: Add an entry for r8a77961 in soc_rcar_gen3[]

Libing Zhou (1):
      iommu/amd: Remove double zero check

Liu Yi L (3):
      iommu/vt-d: Enforce PASID devTLB field mask
      iommu/vt-d: Handle non-page aligned address
      iommu/vt-d: Fix devTLB flush for vSVA

Lu Baolu (6):
      iommu/vt-d: Refactor device_to_iommu() helper
      iommu/vt-d: Add a helper to get svm and sdev for pasid
      iommu/vt-d: Report page request faults for guest SVA
      iommu/vt-d: Add page response ops support
      iommu/vt-d: Rename intel-pasid.h to pasid.h
      iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu

Marek Szyprowski (1):
      iommu: Move sg_table wrapper out of CONFIG_IOMMU_SUPPORT

Marian-Cristian Rotariu (1):
      iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code

Ming-Fan Chen (2):
      dt-bindings: mediatek: Add binding for MT6779 SMI
      memory: mtk-smi: Add basic support for MT6779

Paul Menzel (1):
      iommu/amd: Print extended features in one line to fix divergent log l=
evels

Robin Murphy (5):
      iommu/iova: Don't BUG on invalid PFNs
      iommu/arm-smmu: Update impl quirks comment
      iommu: Tidy up Kconfig for SoC IOMMUs
      iommu/renesas: Expand COMPILE_TEST coverage
      iommu/exynos: Rename update_pte()

Shawn Guo (1):
      iommu/qcom: add optional 'tbu' clock for TLB invalidate

Tomasz Nowicki (2):
      iommu/arm-smmu: Call configuration impl hook before consuming features
      dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806=
 SMMU-500

Wei Yongjun (1):
      iommu: Make some functions static

Will Deacon (2):
      iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
      iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory

Yoshihiro Shimoda (2):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a77961 support
      iommu/renesas: Add support for r8a77961

 Documentation/arm64/silicon-errata.rst             |   3 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  31 +-
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   2 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 +
 .../memory-controllers/mediatek,smi-common.txt     |   5 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   3 +-
 MAINTAINERS                                        |   5 +-
 arch/arm/include/asm/device.h                      |   3 -
 arch/arm64/include/asm/device.h                    |   3 -
 arch/ia64/include/asm/device.h                     |   3 -
 arch/powerpc/include/asm/device.h                  |   3 -
 arch/x86/include/asm/device.h                      |   3 -
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |  10 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |   2 +-
 drivers/iommu/Kconfig                              | 145 +--------
 drivers/iommu/Makefile                             |  15 +-
 drivers/iommu/amd/Kconfig                          |  44 +++
 drivers/iommu/amd/Makefile                         |   4 +
 drivers/iommu/amd/init.c                           |  13 +-
 drivers/iommu/amd/iommu.c                          |  31 +-
 drivers/iommu/arm/Makefile                         |   2 +
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   2 +
 drivers/iommu/{ =3D> arm/arm-smmu-v3}/arm-smmu-v3.c  |   4 +-
 drivers/iommu/arm/arm-smmu/Makefile                |   4 +
 drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu-impl.c   |  60 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c       | 278 +++++++++++++++++
 drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu-qcom.c   |   0
 drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu.c        |  42 ++-
 drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu.h        |   6 +
 drivers/iommu/{ =3D> arm/arm-smmu}/qcom_iommu.c      |  66 ++--
 drivers/iommu/exynos-iommu.c                       |  32 +-
 drivers/iommu/fsl_pamu.c                           |   5 +-
 drivers/iommu/fsl_pamu_domain.c                    |   8 +-
 drivers/iommu/intel/Kconfig                        |  86 ++++++
 drivers/iommu/intel/Makefile                       |   7 +
 drivers/iommu/intel/debugfs.c                      |   2 +-
 drivers/iommu/intel/dmar.c                         |  26 +-
 drivers/iommu/intel/iommu.c                        | 141 +++++----
 drivers/iommu/intel/pasid.c                        |  13 +-
 drivers/iommu/intel/{intel-pasid.h =3D> pasid.h}     |   2 +-
 drivers/iommu/intel/svm.c                          | 335 ++++++++++++++++-=
----
 drivers/iommu/io-pgtable-arm-v7s.c                 |  18 +-
 drivers/iommu/io-pgtable-arm.c                     |  21 +-
 drivers/iommu/iommu.c                              |  37 ++-
 drivers/iommu/iova.c                               |   4 +-
 drivers/iommu/ipmmu-vmsa.c                         |  14 +-
 drivers/iommu/msm_iommu.c                          |   6 +-
 drivers/iommu/mtk_iommu.c                          | 112 +++++--
 drivers/iommu/mtk_iommu.h                          |  23 +-
 drivers/iommu/mtk_iommu_v1.c                       |  10 +-
 drivers/iommu/omap-iommu-debug.c                   |   3 +
 drivers/iommu/omap-iommu.c                         |  22 +-
 drivers/iommu/rockchip-iommu.c                     |   8 +-
 drivers/iommu/tegra-gart.c                         |   8 +-
 drivers/iommu/tegra-smmu.c                         |   8 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h     |   4 +-
 drivers/memory/mtk-smi.c                           |  22 ++
 include/dt-bindings/memory/mt6779-larb-port.h      | 206 +++++++++++++
 include/linux/dmar.h                               |   1 +
 include/linux/intel-iommu.h                        |  13 +-
 include/linux/io-pgtable.h                         |   2 +-
 include/linux/iommu.h                              |  38 +--
 include/uapi/linux/iommu.h                         |   6 +-
 63 files changed, 1465 insertions(+), 571 deletions(-)
 create mode 100644 drivers/iommu/amd/Kconfig
 create mode 100644 drivers/iommu/amd/Makefile
 create mode 100644 drivers/iommu/arm/Makefile
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/Makefile
 rename drivers/iommu/{ =3D> arm/arm-smmu-v3}/arm-smmu-v3.c (99%)
 create mode 100644 drivers/iommu/arm/arm-smmu/Makefile
 rename drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu-impl.c (72%)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
 rename drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu-qcom.c (100%)
 rename drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu.c (98%)
 rename drivers/iommu/{ =3D> arm/arm-smmu}/arm-smmu.h (98%)
 rename drivers/iommu/{ =3D> arm/arm-smmu}/qcom_iommu.c (95%)
 create mode 100644 drivers/iommu/intel/Kconfig
 create mode 100644 drivers/iommu/intel/Makefile
 rename drivers/iommu/intel/{intel-pasid.h =3D> pasid.h} (98%)
 create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h

Please pull.

Thanks,

	Joerg

diff --cc drivers/iommu/intel/Kconfig
index 000000000000,877beec9d987..5337ee1584b0
mode 000000,100644..100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@@ -1,0 -1,86 +1,87 @@@
+ # SPDX-License-Identifier: GPL-2.0-only
+ # Intel IOMMU support
+ config DMAR_TABLE
+ 	bool
+=20
+ config INTEL_IOMMU
+ 	bool "Support for Intel IOMMU using DMA Remapping Devices"
+ 	depends on PCI_MSI && ACPI && (X86 || IA64)
++	select DMA_OPS
+ 	select IOMMU_API
+ 	select IOMMU_IOVA
+ 	select NEED_DMA_MAP_STATE
+ 	select DMAR_TABLE
+ 	select SWIOTLB
+ 	select IOASID
+ 	help
+ 	  DMA remapping (DMAR) devices support enables independent address
+ 	  translations for Direct Memory Access (DMA) from devices.
+ 	  These DMA remapping devices are reported via ACPI tables
+ 	  and include PCI device scope covered by these DMA
+ 	  remapping devices.
+=20
+ config INTEL_IOMMU_DEBUGFS
+ 	bool "Export Intel IOMMU internals in Debugfs"
+ 	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+ 	help
+ 	  !!!WARNING!!!
+=20
+ 	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
+=20
+ 	  Expose Intel IOMMU internals in Debugfs.
+=20
+ 	  This option is -NOT- intended for production environments, and should
+ 	  only be enabled for debugging Intel IOMMU.
+=20
+ config INTEL_IOMMU_SVM
+ 	bool "Support for Shared Virtual Memory with Intel IOMMU"
+ 	depends on INTEL_IOMMU && X86_64
+ 	select PCI_PASID
+ 	select PCI_PRI
+ 	select MMU_NOTIFIER
+ 	select IOASID
+ 	help
+ 	  Shared Virtual Memory (SVM) provides a facility for devices
+ 	  to access DMA resources through process address space by
+ 	  means of a Process Address Space ID (PASID).
+=20
+ config INTEL_IOMMU_DEFAULT_ON
+ 	def_bool y
+ 	prompt "Enable Intel DMA Remapping Devices by default"
+ 	depends on INTEL_IOMMU
+ 	help
+ 	  Selecting this option will enable a DMAR device at boot time if
+ 	  one is found. If this option is not selected, DMAR support can
+ 	  be enabled by passing intel_iommu=3Don to the kernel.
+=20
+ config INTEL_IOMMU_BROKEN_GFX_WA
+ 	bool "Workaround broken graphics drivers (going away soon)"
+ 	depends on INTEL_IOMMU && BROKEN && X86
+ 	help
+ 	  Current Graphics drivers tend to use physical address
+ 	  for DMA and avoid using DMA APIs. Setting this config
+ 	  option permits the IOMMU driver to set a unity map for
+ 	  all the OS-visible memory. Hence the driver can continue
+ 	  to use physical addresses for DMA, at least until this
+ 	  option is removed in the 2.6.32 kernel.
+=20
+ config INTEL_IOMMU_FLOPPY_WA
+ 	def_bool y
+ 	depends on INTEL_IOMMU && X86
+ 	help
+ 	  Floppy disk drivers are known to bypass DMA API calls
+ 	  thereby failing to work when IOMMU is enabled. This
+ 	  workaround will setup a 1:1 mapping for the first
+ 	  16MiB to make floppy (an ISA device) work.
+=20
+ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+ 	bool "Enable Intel IOMMU scalable mode by default"
+ 	depends on INTEL_IOMMU
+ 	help
+ 	  Selecting this option will enable by default the scalable mode if
+ 	  hardware presents the capability. The scalable mode is defined in
+ 	  VT-d 3.0. The scalable mode capability could be checked by reading
+ 	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
+ 	  is not selected, scalable mode support could also be enabled by
+ 	  passing intel_iommu=3Dsm_on to the kernel. If not sure, please use
+ 	  the default value.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl8yk3AACgkQK/BELZcB
GuPpbA//ZiSP/LADgej3WpoNTAW1zA3wnYbLLwRT8mPEC/3sg2+SlnEwuxyd0CuF
y15c2iehejr4IXVrXyU4N3njf7kNxiy3cRpnQ75zl54B1gL35qnIEUA0BtSTyVXp
K3ReCkiQSVIKlulCuO/ZINeTOvDtC+RrzYr2LmqRC9T9vKwKVisqkOfGDi2ZXSEs
f+oR5IIr2n/5ohaIlDE/I1MfNq/XgI0iDLvSH/VUw9RHRCwNL9W6Zc8tdSMkG3oa
3HbZ8WRZTlmuLTKLGio6VXRghLYNjuAf/6ok9jcWHuNql06Wu1LDYJY5ffm2r+Dp
yky6vO3VHJqAPTv/hN3bWZ34Uxndwa2iYdpbhClnhfwJr8PvRTo9Tm9Cw1qFo5cp
1dGs0+pewKdIFTpy5kZ58P3+DJeIbE+RlVu/RnLOSrBO5Ziab4eWMAqDGs4paawv
ILvqQPgaIXyeR7PHyO1ZVaZ9cr11685d7khGkIRWdvzmuoltocLz+fmvCb6MXr7Y
yjj7xSMo1akjZUKnp9kZ5whaD2zg8I1vO+S0D0AZSOHYFbygXHmXik+TkXb46GUC
sHQoUINl5iasPnTLDAl6xgs+qJ+AJ7mD1u5eBRBYra4R1Vl6iwSHAAnOKUYoGUC/
nAYzhwtrQW7EMo/cmNHgOiPrXLX0GfiZXTQquLX40WOztpDK2ao=
=kro7
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============3950051508485463120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3950051508485463120==--
