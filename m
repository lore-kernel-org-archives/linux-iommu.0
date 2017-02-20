From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.11
Date: Mon, 20 Feb 2017 16:46:40 +0100
Message-ID: <20170220154630.GA4800@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7658366993930607164=="
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


--===============7658366993930607164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.11

for you to fetch changes up to 8d2932dd0634ebeb0a42df896976772bdb569bfe:

  Merge branches 'iommu/fixes', 'arm/exynos', 'arm/renesas', 'arm/smmu', 'arm/mediatek', 'arm/core', 'x86/vt-d' and 'core' into next (2017-02-10 15:13:10 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v4.11

The changes include:

	* KVM PCIe/MSI passthrough support on ARM/ARM64

	* Introduction of a core representation for individual hardware
	  iommus

	* Support for IOMMU privileged mappings as supported by some
	  ARM IOMMUS

	* 16-bit SID support for ARM-SMMUv2

	* Stream table optimization for ARM-SMMUv3

	* Various fixes and other small improvements

----------------------------------------------------------------
Aleksey Makarov (1):
      iommu/arm-smmu: Support for Extended Stream ID (16 bit)

Arnd Bergmann (1):
      iommu/mediatek: Remove bogus 'select' statements

Ashok Raj (1):
      iommu/vt-d: Tylersburg isoch identity map check is done too late.

CQ Tang (1):
      iommu/vt-d: Fix some macros that are incorrectly specified in intel-iommu

David Dillow (1):
      iommu/vt-d: Don't over-free page table directories

Eric Auger (18):
      iommu: Rename iommu_dm_regions into iommu_resv_regions
      iommu: Add a new type field in iommu_resv_region
      iommu: iommu_alloc_resv_region
      iommu: Only map direct mapped regions
      iommu: iommu_get_group_resv_regions
      iommu: Implement reserved_regions iommu-group sysfs file
      iommu/vt-d: Implement reserved region get/put callbacks
      iommu/amd: Declare MSI and HT regions as reserved IOVA regions
      iommu/arm-smmu: Implement reserved region get/put callbacks
      iommu/arm-smmu-v3: Implement reserved region get/put callbacks
      irqdomain: Add irq domain MSI and MSI_REMAP flags
      genirq/msi: Set IRQ_DOMAIN_FLAG_MSI on MSI domain creation
      irqdomain: irq_domain_check_msi_remap
      irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
      vfio/type1: Allow transparent MSI IOVA allocation
      vfio/type1: Check MSI remapping at irq domain level
      iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore
      iommu: Fix static checker warning in iommu_insert_device_resv_regions

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to 32-bit address space

Geliang Tang (1):
      iommu/iova: Use rb_entry()

Jeremy Gebben (1):
      iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag

Joerg Roedel (15):
      Merge branch 'iommu/guest-msi' of git://git.kernel.org/.../will/linux into arm/core
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'iommu/iommu-priv' of git://git.kernel.org/.../will/linux into arm/core
      iommu: Rename iommu_get_instance()
      iommu: Rename struct iommu_device
      iommu: Introduce new 'struct iommu_device'
      iommu: Add sysfs bindings for struct iommu_device
      iommu: Make iommu_device_link/unlink take a struct iommu_device
      iommu: Add iommu_device_set_fwnode() interface
      iommu/arm-smmu: Make use of the iommu_register interface
      iommu/msm: Make use of iommu_device_register interface
      iommu/mediatek: Make use of iommu_device_register interface
      iommu/exynos: Make use of iommu_device_register interface
      iommu: Remove iommu_register_instance interface
      Merge branches 'iommu/fixes', 'arm/exynos', 'arm/renesas', 'arm/smmu', 'arm/mediatek', 'arm/core', 'x86/vt-d' and 'core' into next

Lorenzo Pieralisi (1):
      iommu: Drop the of_iommu_{set/get}_ops() interface

Marek Szyprowski (4):
      iommu/exynos: Improve page fault debug message
      iommu/exynos: Fix warnings from DMA-debug
      iommu/exynos: Ensure that SYSMMU is added only once to its master device
      iommu/exynos: Properly release device from the default domain in ->remove

Mitchel Humpherys (4):
      iommu: add IOMMU_PRIV attribute
      common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
      arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
      dmaengine: pl330: Make sure microcode is privileged

Nate Watterson (2):
      iommu/arm-smmu-v3: Clear prior settings when updating STEs
      iommu/arm-smmu-v3: limit use of 2-level stream tables

Rafael J. Wysocki (1):
      iommu/amd: Fix error code path in early_amd_iommu_init()

Robin Murphy (7):
      iommu: Handle default domain attach failure
      iommu/io-pgtable-arm-v7s: Add support for the IOMMU_PRIV flag
      Revert "iommu/arm-smmu: Set PRIVCFG in stage 1 STEs"
      iommu/dma: Allow MSI-only cookies
      iommu/dma: Stop getting dma_32bit_pfn wrong
      iommu/dma: Implement PCI allocation optimisation
      iommu/dma: Remove bogus dma_supported() implementation

Sricharan R (2):
      arm/dma-mapping: Implement DMA_ATTR_PRIVILEGED
      iommu/arm-smmu: Set privileged attribute to 'default' instead of 'unprivileged'

Tomasz Nowicki (1):
      iommu/arm-smmu: Fix for ThunderX erratum #27704

Wei Yongjun (1):
      vfio/type1: Fix error return code in vfio_iommu_type1_attach_group()

Zhen Lei (1):
      iommu: Avoid unnecessary assignment of dev->iommu_fwspec

 .../ABI/testing/sysfs-kernel-iommu_groups          |  12 +
 Documentation/DMA-attributes.txt                   |  10 +
 arch/arm/mm/dma-mapping.c                          |  60 ++---
 arch/arm64/mm/dma-mapping.c                        |   7 +-
 drivers/acpi/arm64/iort.c                          |   2 +-
 drivers/dma/pl330.c                                |   5 +-
 drivers/iommu/Kconfig                              |   3 -
 drivers/iommu/amd_iommu.c                          |  72 ++++--
 drivers/iommu/amd_iommu_init.c                     |  11 +-
 drivers/iommu/amd_iommu_types.h                    |   4 +-
 drivers/iommu/arm-smmu-v3.c                        |  90 ++++---
 drivers/iommu/arm-smmu.c                           | 135 ++++++++--
 drivers/iommu/dma-iommu.c                          | 183 +++++++++----
 drivers/iommu/dmar.c                               |  20 +-
 drivers/iommu/exynos-iommu.c                       |  55 +++-
 drivers/iommu/intel-iommu.c                        | 116 +++++++--
 drivers/iommu/io-pgtable-arm-v7s.c                 |   6 +-
 drivers/iommu/io-pgtable-arm.c                     |   5 +-
 drivers/iommu/iommu-sysfs.c                        |  61 ++---
 drivers/iommu/iommu.c                              | 285 ++++++++++++++++-----
 drivers/iommu/iova.c                               |  23 +-
 drivers/iommu/ipmmu-vmsa.c                         |   2 +
 drivers/iommu/msm_iommu.c                          |  73 +++++-
 drivers/iommu/msm_iommu.h                          |   3 +
 drivers/iommu/mtk_iommu.c                          |  27 +-
 drivers/iommu/mtk_iommu.h                          |   2 +
 drivers/iommu/of_iommu.c                           |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   1 +
 drivers/vfio/vfio_iommu_type1.c                    |  40 ++-
 include/linux/dma-iommu.h                          |  10 +-
 include/linux/dma-mapping.h                        |   7 +
 include/linux/intel-iommu.h                        |  17 +-
 include/linux/iommu.h                              | 138 +++++++---
 include/linux/irqdomain.h                          |  36 +++
 include/linux/of_iommu.h                           |  11 -
 kernel/irq/irqdomain.c                             |  39 +++
 kernel/irq/msi.c                                   |   4 +-
 37 files changed, 1189 insertions(+), 390 deletions(-)

Please pull.

Thanks,

	Joerg

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYqw9WAAoJECvwRC2XARrjZmkQALrcwUL8jEqZzE6T82OtI2Ly
bWx2T5M7CCnH9w/MqZnpuE384MCdU0Xj35jVBVcHeBFgvW1axL9MZczFEcURCmfU
qg6Yoj5O8QEpuzZUB+5hPXroBKcV3hGT9L0DkeHcRxsaEFnoiVsNhYvrm72X+b6A
SumBDGld14gbdIAH5C1i2qtA4U18iZd4kXTR6K5EtriE3skgjFbyCZsFSilo0Ndz
BnRt25ZmECFSIAVUJgpS6twi2YHy6s6qDlJyBfjsFwCRaMUAXFDXjRQSmCXoE5Lo
eund83Bk5jrnjFG5221As43TBSKaOtO8veTFuZbu6lPm4/Z+MBR8flbNf8hQUjDT
FoXkEqXZc0jc8LcFzp9Pd5ww5AhIjnSy9jxUC03k3krk3Ube3gITdHniTOfSBG0B
tMYyoxskI29HJbIbVXAyv5IyKPWjikCayyzZA4Oq0F/PXtqFTL26ls0RkkHT35is
3XntfkfmT/0qhnLu51SKweIUvS+lzFDPOgAq27J2eEMrSwKjWF9oXKipuhyLFYTK
aa6DNEACR4kn/hmm3AgAuiYtXcWajJRlVOWyKzsJ1SQ8FOhjTvGKVv1WwzJCOnwL
eFFBpCIKMOcsGU3wwqbMAl/KD4Hzwlh0sKHeEtDhLeFFEJMjEZcWnL46qDGRTQKQ
+nQOCL0YB5g8cxsq7u7A
=09XI
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============7658366993930607164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7658366993930607164==--
