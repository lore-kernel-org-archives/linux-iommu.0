From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.12
Date: Tue, 9 May 2017 11:45:45 +0200
Message-ID: <20170509094539.GA6614@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0872210057761341541=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0872210057761341541==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.12

for you to fetch changes up to 2c0248d68880fc0e783af1048b3367ee5d4412f0:

  Merge branches 'arm/exynos', 'arm/omap', 'arm/rockchip', 'arm/mediatek', 'arm/smmu', 'arm/core', 'x86/vt-d', 'x86/amd' and 'core' into next (2017-05-04 18:06:17 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.12

This includes:

	* Some code optimizations for the Intel VT-d driver

	* Code to switch off a previously enabled Intel IOMMU

	* Support for 'struct iommu_device' for OMAP, Rockchip and
	  Mediatek IOMMUs

	* Some header optimizations for IOMMU core code headers and a
	  few fixes that became necessary in other parts of the kernel
	  because of that

	* ACPI/IORT updates and fixes

	* Some Exynos IOMMU optimizations

	* Code updates for the IOMMU dma-api code to bring it closer to
	  use per-cpu iova caches

	* New command-line option to set default domain type allocated
	  by the iommu core code

	* Another command line option to allow the Intel IOMMU switched
	  off in a tboot environment

	* ARM/SMMU: TLB sync optimisations for SMMUv2, Support for using
	  an IDENTITY domain in conjunction with DMA ops, Support for
	  SMR masking, Support for 16-bit ASIDs (was previously broken)

	* Various other small fixes and improvements

----------------------------------------------------------------
Andy Shevchenko (5):
      iommu/dmar: Rectify return code handling in detect_intel_iommu()
      iommu/dmar: Return directly from a loop in dmar_dev_scope_status()
      iommu/dmar: Remove redundant assignment of ret
      iommu/dmar: Remove redundant ' != 0' when check return code
      iommu/vt-d: Use lo_hi_readq() / lo_hi_writeq()

Joerg Roedel (14):
      iommu/iova: Fix compile error with CONFIG_IOMMU_IOVA=m
      iommu/vt-d: Make sure IOMMUs are off when intel_iommu=off
      iommu/rockchip: Make use of 'struct iommu_device'
      iommu/mediatek: Teach MTK-IOMMUv1 about 'struct iommu_device'
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/omap: Move data structures to omap-iommu.h
      iommu/omap: Store iommu_dev pointer in arch_data
      iommu/omap: Make use of 'struct iommu_device'
      iommu/omap: Add iommu-group support
      iommu: Include device.h in iommu.h
      iommu: Move report_iommu_fault() to iommu.c
      iommu: Remove pci.h include from trace/events/iommu.h
      iommu: Remove trace-events include from iommu.h
      Merge branches 'arm/exynos', 'arm/omap', 'arm/rockchip', 'arm/mediatek', 'arm/smmu', 'arm/core', 'x86/vt-d', 'x86/amd' and 'core' into next

Laurent Pinchart (3):
      of: dma: Make of_dma_deconfigure() public
      iommu: of: Handle IOMMU lookup failure with deferred probing or error
      arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()

Lorenzo Pieralisi (3):
      ACPI/IORT: Add function to check SMMUs drivers presence
      ACPI/IORT: Remove linker section for IORT entries probing
      ACPI/IORT: Fix CONFIG_IOMMU_API dependency

Marek Szyprowski (3):
      iommu/iova: Consolidate code for adding new node to iovad domain rbtree
      iommu/exynos: Don't open-code loop unrolling
      iommu/exynos: Use smarter TLB flush method for v5 SYSMMU

Nate Watterson (1):
      iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

Pan Bian (1):
      iommu/amd: Fix incorrect error handling in amd_iommu_bind_pasid()

Paul Gortmaker (2):
      soc/qbman: Fix implicit header dependency now causing build fails
      soc/qbman: Move dma-mapping.h include to qman_priv.h

Peng Fan (1):
      iommu/arm-smmu: Correct sid to mask

Qiuxu Zhuo (1):
      iommu/vt-d: Don't print the failure message when booting non-kdump kernel

Robert Richter (1):
      iommu/arm-smmu: Print message when Cavium erratum 27704 was detected

Robin Murphy (16):
      iommu/dma: Don't reserve PCI I/O windows
      iommu/dma: Handle IOMMU API reserved regions
      iommu/dma: Make PCI window reservation generic
      iommu/dma: Convert to address-based allocation
      iommu/dma: Clean up MSI IOVA allocation
      iommu/dma: Plumb in the per-CPU IOVA caches
      iommu: Better document the IOMMU_PRIV flag
      iommu/arm-smmu: Simplify ASID/VMID handling
      iommu/arm-smmu: Tidy up context bank indexing
      iommu/arm-smmu: Use per-context TLB sync as appropriate
      iommu/arm-smmu: Poll for TLB sync completion more effectively
      iommu/arm-smmu: Add global SMR masking property
      iommu/io-pgtable-arm: Avoid shift overflow in block size
      iommu/of: Refactor of_iommu_configure() for error handling
      iommu/of: Prepare for deferred IOMMU configuration
      iommu/arm-smmu: Clean up early-probing workarounds

Shaohua Li (1):
      x86, iommu/vt-d: Add an option to disable Intel IOMMU force on

Sricharan R (4):
      of: device: Fix overflow of coherent_dma_mask
      of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices
      drivers: acpi: Handle IOMMU lookup failure with deferred probing or error
      arm64: dma-mapping: Remove the notifier trick to handle early setting of dma_ops

Suman Anna (3):
      iommu/omap: Register driver before setting IOMMU ops
      iommu/omap: Drop legacy-style device support
      omap3isp: Remove iommu_group related code

Sunil Goutham (2):
      iommu/arm-smmu: Fix 16-bit ASID configuration
      iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is bypassed

Thierry Reding (2):
      MAINTAINERS: Add related headers to IOMMU section
      iommu: Add dummy implementations for !IOMMU_IOVA

Will Deacon (5):
      iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
      iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
      iommu/arm-smmu-v3: Make arm_smmu_install_ste_for_dev return void
      iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY domains
      iommu: Allow default domain type to be set on the kernel command line

zhichang.yuan (1):
      iommu: Make iommu_bus_notifier return NOTIFY_DONE rather than error code

 Documentation/admin-guide/kernel-parameters.txt    |  15 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |  28 ++
 MAINTAINERS                                        |   2 +
 arch/arm/mm/dma-mapping.c                          |   9 +
 arch/arm64/mm/dma-mapping.c                        | 143 ++------
 arch/x86/kernel/tboot.c                            |   3 +
 drivers/acpi/arm64/iort.c                          |  72 +++-
 drivers/acpi/glue.c                                |   5 -
 drivers/acpi/scan.c                                |  11 +-
 drivers/base/dd.c                                  |   9 +
 drivers/base/dma-mapping.c                         |  41 +++
 drivers/infiniband/hw/qedr/main.c                  |   1 +
 drivers/iommu/amd_iommu_v2.c                       |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 127 +++----
 drivers/iommu/arm-smmu.c                           | 376 ++++++++++++---------
 drivers/iommu/dma-iommu.c                          | 283 ++++++++++------
 drivers/iommu/dmar.c                               |  35 +-
 drivers/iommu/exynos-iommu.c                       |  32 +-
 drivers/iommu/fsl_pamu.h                           |   1 +
 drivers/iommu/intel-iommu.c                        |  36 +-
 drivers/iommu/intel_irq_remapping.c                |  15 +-
 drivers/iommu/io-pgtable-arm.c                     |   2 +-
 drivers/iommu/iommu.c                              |  78 ++++-
 drivers/iommu/iova.c                               |  89 ++---
 drivers/iommu/mtk_iommu_v1.c                       |  25 +-
 drivers/iommu/of_iommu.c                           | 126 +++++--
 drivers/iommu/omap-iommu.c                         | 190 +++++++----
 drivers/iommu/omap-iommu.h                         |  34 ++
 drivers/iommu/rockchip-iommu.c                     |  31 +-
 drivers/iommu/tegra-smmu.c                         |   1 +
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |   1 +
 drivers/media/platform/omap3isp/isp.c              |  17 -
 drivers/media/platform/omap3isp/isp.h              |   1 -
 drivers/of/device.c                                |  23 +-
 drivers/of/platform.c                              |  10 +-
 drivers/pci/probe.c                                |  28 --
 drivers/soc/fsl/qbman/qman_priv.h                  |   1 +
 include/acpi/acpi_bus.h                            |   2 +-
 include/asm-generic/vmlinux.lds.h                  |   1 -
 include/linux/acpi.h                               |   7 +-
 include/linux/acpi_iort.h                          |   3 -
 include/linux/dma-iommu.h                          |   6 +
 include/linux/dma-mapping.h                        |  12 +
 include/linux/dma_remapping.h                      |   1 +
 include/linux/intel-iommu.h                        |  18 +-
 include/linux/iommu.h                              |  58 +---
 include/linux/iova.h                               |  91 +++++
 include/linux/of_device.h                          |  10 +-
 include/linux/platform_data/iommu-omap.h           |  20 --
 include/trace/events/iommu.h                       |   1 -
 50 files changed, 1314 insertions(+), 819 deletions(-)

Please pull.

Thanks,

	Joerg

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZEY/DAAoJECvwRC2XARrj85cP/iFRem7qqo/AwHfF5PW7+gkW
ee/NrWV57t0aKpO5d6tUGaoB7LQWKLf4PAsThzgSmWgjE3BeoQz2iYwFpfxGCoQm
gXYxL4DKRooFJFnZqTMSDoqfiLvU6gaB0P8Mkb7CU5+np7XaG+3AdfzwSp1Sm5J2
tVsBU+fLqfIdtQBfOw+o5ihy9OpXtuY1s1eLBlXwDbWctadkRcnC8P8IDwOhe7bu
/2WtN/rtXuk3RmZijyOC0KwXZ+9fLgc1vFB2lC3V8M7Dt2yMZYtQZT4W5FpCpghX
A9BAxZYuKMtCGwNOx3Y17xO7BxxNlKjyeLYn/FxrHcLIV90p9j7hF0gCSqmx3BY3
Evr0oWskWltbaSOqfYn0wHy+vDQG06kCTA/CWIZi5L2qGP62nL7KB/iN6+ZXRuv5
Gb6D9nXxqAg+/WU4Mv6ZQkNGrPfSEILE2BKdzNV9HSHSmhfV16WDhT49/BqMkb2C
NJetbtYSApiebY0pNxDOfp3FgEGF9DQnLdIejaqI3yRJHWKSV3ROVcbkjwcWDWyE
hF+qnL7EEaYrhqc9x/aRXYs8uqcTiuxSHuG4AcrVx8mxGsR6PRp/V9slEqLVWORA
MXrsc4wC8wEon2tgzQIBgO+UMUxMt2GNPRtnFGSw2cDerpMo/fgR5i1U2psmKgUp
N2X69GUF8OyFvNpCf0RJ
=Ktwk
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--===============0872210057761341541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0872210057761341541==--
