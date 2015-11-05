From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.4
Date: Thu, 5 Nov 2015 12:41:25 +0100
Message-ID: <20151105114124.GA9155@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2617418590925292061=="
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


--===============2617418590925292061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v4.4

for you to fetch changes up to b67ad2f7c7514f94fe6bbd0cd86add445eb4e64a:

  Merge branches 'x86/vt-d', 'arm/omap', 'arm/smmu', 's390', 'core' and 'x8=
6/amd' into next (2015-11-02 20:03:34 +0900)

----------------------------------------------------------------

IOMMU Updates for Linux v4.4

This time including:

	* A new IOMMU driver for s390 pci devices

	* Common dma-ops support based on iommu-api for ARM64. The plan is to
	  use this as a basis for ARM32 and hopefully other architectures as
	  well in the future.

	* MSI support for ARM-SMMUv3

	* Cleanups and dead code removal in the AMD IOMMU driver

	* Better RMRR handling for the Intel VT-d driver

	* Various other cleanups and small fixes

----------------------------------------------------------------
Baoquan He (1):
      iommu/vt-d: Adjust the return value of the parse_ioapics_under_ir

Dan Williams (1):
      iommu/vt-d: Switch from ioremap_cache to memremap

Fabio Estevam (1):
      iommu/arm-smmu: Remove unneeded '0x' annotation

Feng Wu (1):
      iommu/vt-d: Use cmpxchg16b to update posted format IRTE atomically

Gerald Schaefer (1):
      iommu/s390: Add iommu api for s390 pci devices

Joerg Roedel (25):
      iommu/vt-d: Split iommu_prepare_identity_map
      iommu/vt-d: Create RMRR mappings in newly allocated domains
      iommu/amd: Do not BUG_ON in __detach_device()
      iommu/amd: Do not iterate over alias-list in __[attach|detach]_device
      iommu/amd: Don't disable IRQs in __detach_device
      iommu/amd: WARN when __[attach|detach]_device are called with irqs en=
abled
      iommu/amd: Set alias DTE in do_attach/do_detach
      iommu/amd: Remove old alias handling code
      iommu/amd: Align DTE flag definitions
      iommu/amd: Remove cmd_buf_size and evt_buf_size from struct amd_iommu
      iommu/amd: Cleanup buffer allocation
      iommu/amd: Initialize amd_iommu_last_bdf for DEV_ALL
      iommu/amd: Remove first/last_device handling
      iommu/amd: Remove find_last_devid_on_pci()
      iommu: Revive device_group iommu-ops call-back
      iommu: Export and rename iommu_group_get_for_pci_dev()
      iommu: Add generic_device_group() function
      iommu: Add device_group call-back to x86 iommu drivers
      iommu/fsl: Convert to device_group call-back
      iommu/arm-smmu: Switch to device_group call-back
      iommu: Remove is_pci_dev() fall-back from iommu_group_get_for_dev
      iommu: Move default domain allocation to iommu_group_get_for_dev()
      iommu/vt-d: Propagate error-value from ir_parse_ioapic_hpet_scope()
      iommu/vt-d: Fix return value check of parse_ioapics_under_ir()
      Merge branches 'x86/vt-d', 'arm/omap', 'arm/smmu', 's390', 'core' and=
 'x86/amd' into next

Julia Lawall (1):
      iommu/amd: Drop null test before destroy functions

J=E9r=F4me Glisse (1):
      iommu/amd: Return positive value in amd_iommu_detect()

Marc Zyngier (1):
      iommu/arm-smmu: Add support for MSI on SMMUv3

Robin Murphy (3):
      iommu: Implement common IOMMU ops for DMA mapping
      arm64: Add IOMMU dma_ops
      arm64: Hook up IOMMU dma_ops

Suman Anna (2):
      Documentation: dt: Update OMAP iommu bindings for DRA7 DSPs
      iommu/omap: Add support for configuring dsp iommus on DRA7xx

Tirumalesh Chalamarla (1):
      iommu/arm-smmu: ThunderX mis-extends 64bit registers

Will Deacon (3):
      iommu/arm-smmu: Use drvdata instead of maintaining smmu_devices list
      iommu/arm-smmu: Fix error checking for ASID and VMID allocation
      iommu/arm-smmu: Remove redundant calculation of gr0 base address

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  19 +
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  27 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/dma-mapping.h               |  15 +-
 arch/arm64/mm/dma-mapping.c                        | 457 ++++++++++++++++++
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/pci.h                        |   4 +
 arch/s390/include/asm/pci_dma.h                    |   5 +-
 arch/s390/pci/pci_dma.c                            |  37 +-
 drivers/iommu/Kconfig                              |  15 +
 drivers/iommu/Makefile                             |   2 +
 drivers/iommu/amd_iommu.c                          | 173 ++-----
 drivers/iommu/amd_iommu_init.c                     | 120 ++---
 drivers/iommu/amd_iommu_types.h                    |  13 +-
 drivers/iommu/arm-smmu-v3.c                        | 155 ++++--
 drivers/iommu/arm-smmu.c                           | 132 +++---
 drivers/iommu/dma-iommu.c                          | 524 +++++++++++++++++=
++++
 drivers/iommu/fsl_pamu_domain.c                    |  41 +-
 drivers/iommu/intel-iommu.c                        |  83 ++--
 drivers/iommu/intel_irq_remapping.c                |  64 ++-
 drivers/iommu/iommu.c                              |  46 +-
 drivers/iommu/omap-iommu.c                         |  58 +++
 drivers/iommu/omap-iommu.h                         |   9 +
 drivers/iommu/s390-iommu.c                         | 337 +++++++++++++
 include/linux/dma-iommu.h                          |  85 ++++
 include/linux/iommu.h                              |   8 +-
 27 files changed, 1995 insertions(+), 443 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 drivers/iommu/s390-iommu.c
 create mode 100644 include/linux/dma-iommu.h

Please pull.

Thanks,

	Joerg


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWO0BkAAoJECvwRC2XARrjs/0QALRlhcjwJy5bPb7AHP7Bc779
SaZLj9FsMhpwzX87AZEQoCXCwqIqBKaxZNkG9pjt7t5gnCfKSFcEm+JFSzpITTJL
YXqopA/Rjzj8XqMtvg5iwSCdwefUuI+WQmyyeQ3T9YHBSvN7TA+sEfRucrsilYPv
KaxlKdJYiROwkiFrBTz8C04Kq3fnlc3ZCLp2bvTuQiJCeSxofgzOPPo3HHwrHfp7
mGH/RkY9T9CcGSvTzkaP0rGV/ZpJgn/Q/xFi1+y8PFM450SKalu/4+yywm6ZGt4v
tGVee2VIyTRXEPX7LvUabkafBLw/+8O6w0mD3LwFU5VMf5laZ3JFiPE58NTEWKnf
kRS+P151gAZUYrwYumDAaFD1urzh+1EgSSdOg2R0cP0gK+JWfTAJJq2cwmS6vu87
D6or0fTW3BQxeXqzAWV6gJn1iXfJ9tZzPimtlqEv3LHODa2HxlIi8V846UCS9yGz
KjqQuwZ8aqzpXpzwRLNnFsD5SouLhioGw5ejCXYFA/PQ02dVAy+BY7G8a5ptiWqW
CbfJ27WElwcaFCn2lADp+ohlIBdTDWi4icolyU8E02is19JXA1YpuRivMncKDE6o
XDyi/FM/Rury2//6PMCVVgx2iJdtUHZDbF4JrfB8Y2Su2H+pTBYE6fOC+zSmP45L
krRHFfAi61yu5ckFTiTL
=IT3g
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--===============2617418590925292061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2617418590925292061==--
