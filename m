From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.14
Date: Sat, 9 Sep 2017 19:32:51 +0200
Message-ID: <20170909173245.hwxbeicmdfmeevmm@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2589067445164355351=="
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


--===============2589067445164355351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hc22srj24x7ps2ns"
Content-Disposition: inline


--hc22srj24x7ps2ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There are some conflicts this time between this pull-request and the SME
support patches that came from the tip-tree, which also touch the
AMD IOMMU driver. Please see my attached resolution of the conflict.

The following changes since commit cc4a41fe5541a73019a864883297bd5043aa6d98:

  Linux 4.13-rc7 (2017-08-27 17:20:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v4.14

for you to fetch changes up to 47b59d8e40850a05370ee9198ea5e505d89489f1:

  Merge branches 'arm/exynos', 'arm/renesas', 'arm/rockchip', 'arm/omap', '=
arm/mediatek', 'arm/tegra', 'arm/qcom', 'arm/smmu', 'ppc/pamu', 'x86/vt-d',=
 'x86/amd', 's390' and 'core' into next (2017-09-01 11:31:42 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.14

Slightly more changes than usual this time:

	- KDump Kernel IOMMU take-over code for AMD IOMMU. The code now
	  tries to preserve the mappings of the kernel so that master
	  aborts for devices are avoided. Master aborts cause some
	  devices to fail in the kdump kernel, so this code makes the
	  dump more likely to succeed when AMD IOMMU is enabled.

	- Common flush queue implementation for IOVA code users. The
	  code is still optional, but AMD and Intel IOMMU drivers had
	  their own implementation which is now unified.

	- Finish support for iommu-groups. All drivers implement this
	  feature now so that IOMMU core code can rely on it.

	- Finish support for 'struct iommu_device' in iommu drivers. All
	  drivers now use the interface.

	- New functions in the IOMMU-API for explicit IO/TLB flushing.
	  This will help to reduce the number of IO/TLB flushes when
	  IOMMU drivers support this interface.

	- Support for mt2712 in the Mediatek IOMMU driver

	- New IOMMU driver for QCOM hardware

	- System PM support for ARM-SMMU

	- Shutdown method for ARM-SMMU-v3

	- Some constification patches

	- Various other small improvements and fixes

----------------------------------------------------------------
Arnd Bergmann (2):
      iommu/exynos: prevent building on big-endian kernels
      iommu: qcom: annotate PM functions as __maybe_unused

Arvind Yadav (3):
      memory: mtk-smi: Handle return value of clk_prepare_enable
      iommu/exynos: Constify iommu_ops
      iommu/s390: Constify iommu_ops

Ashok Raj (2):
      iommu/vt-d: IOMMU Page Request needs to check if address is canonical.
      iommu/vt-d: Avoid calling virt_to_phys() on null pointer

Baoquan He (13):
      iommu/amd: Detect pre enabled translation
      iommu/amd: Add several helper functions
      Revert "iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel"
      iommu/amd: Define bit fields for DTE particularly
      iommu/amd: Add function copy_dev_tables()
      iommu/amd: Copy old trans table from old kernel
      iommu/amd: Do sanity check for address translation and irq remap of o=
ld dev table entry
      iommu: Add is_attach_deferred call-back to iommu-ops
      iommu/amd: Use is_attach_deferred call-back
      iommu/amd: Allocate memory below 4G for dev table if translation pre-=
enabled
      iommu/amd: Don't copy GCR3 table root pointer
      iommu/amd: Disable iommu only if amd_iommu=3Doff is specified
      iommu/amd: Check if domain is NULL in get_domain() and return -EBUSY

Bhumika Goyal (1):
      iommu/ipmmu-vmsa: Make ipmmu_gather_ops const

David Dillow (1):
      iommu/vt-d: Don't free parent pagetable of the PTE we're adding

Dmitry Osipenko (1):
      iommu: Correct iommu_map / iommu_unmap prototypes

Fernando Guzman Lugo (1):
      iommu/omap: Fix disabling of MMU upon a fault

Filippo Sironi (1):
      iommu/vt-d: Don't be too aggressive when clearing one context entry

Honghui Zhang (3):
      memory: mtk-smi: Use of_device_get_match_data helper
      memory: mtk-smi: add larbid handle routine
      dt-bindings: mediatek: add descriptions for larbid

Joerg Roedel (25):
      iommu/pamu: Let PAMU depend on PCI
      iommu/pamu: Make driver depend on CONFIG_PHYS_64BIT
      iommu/pamu: WARN when fsl_pamu_probe() is called more than once
      iommu/pamu: Add support for generic iommu-device
      iommu/s390: Add support for iommu_device handling
      iommu/iova: Add flush-queue data structures
      iommu/iova: Implement Flush-Queue ring buffer
      iommu/iova: Add flush counters to Flush-Queue implementation
      iommu/iova: Add locking to Flush-Queues
      iommu/iova: Add flush timer
      iommu/amd: Make use of iova queue flushing
      iommu/vt-d: Allow to flush more than 4GB of device TLBs
      iommu/vt-d: Make use of iova deferred flushing
      Merge branch 'core' into arm/tegra
      iommu/tegra: Add support for struct iommu_device
      iommu/tegra-gart: Add support for struct iommu_device
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/...=
/will/linux into arm/smmu
      iommu/amd: Fix compiler warning in copy_device_table()
      iommu/amd: Fix section mismatch warning
      Merge branch 'iommu/fixes' into arm/mediatek
      iommu/pamu: Fix PAMU boot crash
      iommu/amd: Rename a few flush functions
      arm/tegra: Call bus_set_iommu() after iommu_device_register()
      iommu: Introduce Interface for IOMMU TLB Flushing
      Merge branches 'arm/exynos', 'arm/renesas', 'arm/rockchip', 'arm/omap=
', 'arm/mediatek', 'arm/tegra', 'arm/qcom', 'arm/smmu', 'ppc/pamu', 'x86/vt=
-d', 'x86/amd', 's390' and 'core' into next

Josue Albarran (1):
      iommu/omap: Use DMA-API for performing cache flushes

Krzysztof Kozlowski (1):
      iommu/exynos: Replace non-existing big-endian Kconfig option

Magnus Damm (4):
      iommu/ipmmu-vmsa: Use iommu_device_register()/unregister()
      iommu/ipmmu-vmsa: Consistent ->of_xlate() handling
      iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids
      iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()

Marek Szyprowski (1):
      iommu/exynos: Remove custom platform device registration code

Nate Watterson (1):
      iommu/arm-smmu-v3: Implement shutdown method

Oleksandr Tyshchenko (1):
      iommu/ipmmu-vmsa: Rereserving a free context before setting up a page=
table

Rob Clark (4):
      Docs: dt: document qcom iommu bindings
      iommu/arm-smmu: Split out register defines
      iommu/qcom: Add qcom_iommu
      MAINTAINERS: Add entry for qcom_iommu

Rob Herring (1):
      iommu: Convert to using %pOF instead of full_name

Robin Murphy (11):
      iommu/of: Handle PCI aliases properly
      iommu/ipmmu-vmsa: Use fwspec on both 32 and 64-bit ARM
      iommu/ipmmu-vmsa: Clean up device tracking
      iommu/msm: Add iommu_group support
      iommu/tegra-smmu: Add iommu_group support
      iommu/tegra-gart: Add iommu_group support
      iommu: Finish making iommu_group support mandatory
      iommu/of: Fix of_iommu_configure() for disabled IOMMUs
      iommu/arm-smmu: Track context bank state
      iommu/arm-smmu: Add system PM support
      iommu: Avoid NULL group dereference

Simon Xue (3):
      Docs: dt: rockchip: add rockchip,disable-mmu-reset property
      iommu/rockchip: add multi irqs support
      iommu/rockchip: ignore isp mmu reset operation

Stanimir Varbanov (1):
      iommu/qcom: Initialize secure page table

Yong Wu (9):
      iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into mtk_iommu.c
      iommu/mediatek: Add mt2712 IOMMU support
      iommu/mediatek: Merge 2 M4U HWs into one iommu domain
      iommu/mediatek: Move pgtable allocation into domain_alloc
      iommu/mediatek: Disable iommu clock when system suspend
      iommu/mediatek: Enlarge the validate PA range for 4GB mode
      memory: mtk-smi: Degrade SMI init to module_init
      iommu/mediatek: Fix a build fail of m4u_type
      iommu/mediatek: Fix a build warning of BIT(32) in ARM

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++
 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   5 +
 .../memory-controllers/mediatek,smi-larb.txt       |  15 +
 MAINTAINERS                                        |   7 +
 arch/s390/include/asm/pci.h                        |   7 +
 arch/s390/pci/pci.c                                |   9 +-
 drivers/iommu/Kconfig                              |  13 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd_iommu.c                          | 313 ++-----
 drivers/iommu/amd_iommu_init.c                     | 223 ++++-
 drivers/iommu/amd_iommu_proto.h                    |   2 +
 drivers/iommu/amd_iommu_types.h                    |  55 +-
 drivers/iommu/amd_iommu_v2.c                       |  18 +-
 drivers/iommu/arm-smmu-regs.h                      | 220 +++++
 drivers/iommu/arm-smmu-v3.c                        |   7 +
 drivers/iommu/arm-smmu.c                           | 384 +++------
 drivers/iommu/dmar.c                               |   2 +-
 drivers/iommu/exynos-iommu.c                       |  44 +-
 drivers/iommu/fsl_pamu.c                           |  27 +-
 drivers/iommu/fsl_pamu_domain.c                    |  28 +-
 drivers/iommu/intel-iommu.c                        | 280 ++-----
 drivers/iommu/intel-svm.c                          |  14 +
 drivers/iommu/iommu.c                              |  59 +-
 drivers/iommu/iova.c                               | 183 ++++
 drivers/iommu/ipmmu-vmsa.c                         | 242 ++----
 drivers/iommu/msm_iommu.c                          |  15 +-
 drivers/iommu/mtk_iommu.c                          | 214 +++--
 drivers/iommu/mtk_iommu.h                          |   9 +
 drivers/iommu/of_iommu.c                           | 144 ++--
 drivers/iommu/omap-iommu.c                         | 125 ++-
 drivers/iommu/omap-iommu.h                         |   1 +
 drivers/iommu/qcom_iommu.c                         | 930 +++++++++++++++++=
++++
 drivers/iommu/rockchip-iommu.c                     |  52 +-
 drivers/iommu/s390-iommu.c                         |  37 +-
 drivers/iommu/tegra-gart.c                         |  45 +
 drivers/iommu/tegra-smmu.c                         |  39 +-
 drivers/memory/mtk-smi.c                           |  96 ++-
 include/dt-bindings/memory/mt8173-larb-port.h      |   4 -
 include/linux/iommu.h                              |  55 +-
 include/linux/iova.h                               |  67 ++
 include/soc/mediatek/smi.h                         |   2 +-
 41 files changed, 2881 insertions(+), 1233 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

Please pull.

Thanks,

	Joerg


My conflict resolution:

diff --cc drivers/iommu/amd_iommu.c
index 4ad7e5e31943,538c16f669f9..51f8215877f5
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@@ -1538,10 -1476,10 +1478,10 @@@ static int iommu_map_page(struct protec
  			return -EBUSY;
 =20
  	if (count > 1) {
 -		__pte =3D PAGE_SIZE_PTE(phys_addr, page_size);
 +		__pte =3D PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
- 		__pte |=3D PM_LEVEL_ENC(7) | IOMMU_PTE_P | IOMMU_PTE_FC;
+ 		__pte |=3D PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
  	} else
- 		__pte =3D __sme_set(phys_addr) | IOMMU_PTE_P | IOMMU_PTE_FC;
 -		__pte =3D phys_addr | IOMMU_PTE_PR | IOMMU_PTE_FC;
++		__pte =3D __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 =20
  	if (prot & IOMMU_PROT_IR)
  		__pte |=3D IOMMU_PTE_IR;
diff --cc drivers/iommu/amd_iommu_proto.h
index 3f12fb2338ea,90e62e9b01c5..b3dc7136d3e8
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@@ -87,14 -87,6 +87,17 @@@ static inline bool iommu_feature(struc
  	return !!(iommu->features & f);
  }
 =20
 +static inline u64 iommu_virt_to_phys(void *vaddr)
 +{
 +	return (u64)__sme_set(virt_to_phys(vaddr));
 +}
 +
 +static inline void *iommu_phys_to_virt(unsigned long paddr)
 +{
 +	return phys_to_virt(__sme_clr(paddr));
 +}
 +
+ extern bool translation_pre_enabled(struct amd_iommu *iommu);
+ extern struct iommu_dev_data *get_dev_data(struct device *dev);
++
  #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --cc drivers/iommu/amd_iommu_types.h
index 8e3a85759242,5f775fef341c..f6b24c7d8b70
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@@ -343,8 -361,8 +361,8 @@@
  #define GCR3_VALID		0x01ULL
 =20
  #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
- #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_P)
+ #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 -#define IOMMU_PTE_PAGE(pte) (phys_to_virt((pte) & IOMMU_PAGE_MASK))
 +#define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
  #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 =20
  #define IOMMU_PROT_MASK 0x03

--hc22srj24x7ps2ns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZtCW9AAoJECvwRC2XARrjzggQALr7B0WP9c3ADXMsSYYDnyaf
KjJYH4rISXZkWqC8CZh/SSaUq+vrb+nWCbwW4ds2XFAsPQ2ptm2VuO8B4EbSdEYh
tjNOpEZOPJb7KEdg3y6tAUXt4Q8iLKJVAXkKkw1jc6vatd0BxdDnH19A4Lq9wsGx
pFj2Bsn+4/Ccl4K46F6rLToe1fTcSCUyKq0j+lGs2JwArbzVTjxJIBwqTthwriVn
MqdHjqjtOMWxwJxaEhtR1jjOEpDQFrHQ90SF2kLdlfbGIMZz9Kcfrkm/sIYIwIIi
/dnntmWdJOED5qJT4D3r60MBlG3pEHIuPourUt+oqkBodrqyG2CGiCrpylIGZl0D
EhPnKPPAQeEJaH4igi+4Sbtde7FuBpjwFkisZHGuC6guif5rwgzqu/A0dL6Vm/lI
Ed0j/t4tLL9Byp0otY1esGIp5EidD3utB6iuAG+0IfFzo0XHqzzzy8kS4kz2/lJS
mNjN51B69Lp6AmxJX3aWEc2IRXJfSCCd2OQ4FqtXq1ppxQ3piNYM+x7c+X9U7qD8
xuzY/1TLJqNfx/jIBzufd4bNPTGd+OoM3YCCJ22sJyH41y2ck8iPIpzwRoDTarwc
LaGmlOsv553c4PvfG3/hqY4JEnoUOh0JZPzOdZD7K6UObr6AwYmdmrqLotpqQSkB
667dn9Hc7F+Gc6HfX0ML
=PW07
-----END PGP SIGNATURE-----

--hc22srj24x7ps2ns--

--===============2589067445164355351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2589067445164355351==--
