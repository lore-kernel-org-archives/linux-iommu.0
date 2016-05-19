From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.7
Date: Thu, 19 May 2016 18:25:04 +0200
Message-ID: <20160519162456.GA6187@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6306169070796446894=="
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


--===============6306169070796446894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 44549e8f5eea4e0a41b487b63e616cb089922b99:

  Linux 4.6-rc7 (2016-05-08 14:38:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.7

for you to fetch changes up to 6c0b43df74f900e7f31a49d1844f166df0f8afc6:

  Merge branches 'arm/io-pgtable', 'arm/rockchip', 'arm/omap', 'x86/vt-d', 'ppc/pamu', 'core' and 'x86/amd' into next (2016-05-09 19:39:17 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.7

The updates include:

	* Rate limiting for the VT-d fault handler

	* Remove statistics code from the AMD IOMMU driver. It is unused
	  and should be replaced by something more generic if needed

	* Per-domain pagesize-bitmaps in IOMMU core code to support
	  systems with different types of IOMMUs

	* Support for ACPI devices in the AMD IOMMU driver

	* 4GB mode support for Mediatek IOMMU driver

	* ARM-SMMU updates from Will Deacon:

		- Support for 64k pages with SMMUv1 implementations
		  (e.g MMU-401)

		- Remove open-coded 64-bit MMIO accessors

		- Initial support for 16-bit VMIDs, as supported by some
		  ThunderX SMMU implementations

		- A couple of errata workarounds for silicon in the
		  field

	* Various fixes here and there

----------------------------------------------------------------
Alex Williamson (2):
      iommu/vt-d: Ratelimit fault handler
      iommu/vt-d: Improve fault handler error messages

Andy Fleming (1):
      powerpc: Fix incorrect PPC32 PAMU dependency

Cosmin-Gabriel Samoila (1):
      iommu/io-pgtable: Fix a brace coding style issue.

Dan Carpenter (1):
      iommu/amd: Signedness bug in acpihid_device_group()

Joerg Roedel (6):
      iommu/amd: Don't use IS_ERR_VALUE to check integer values
      iommu/amd: Move get_device_id() and friends to beginning of file
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'arm/smmu' into core
      iommu/amd: Remove statistics code
      Merge branches 'arm/io-pgtable', 'arm/rockchip', 'arm/omap', 'x86/vt-d', 'ppc/pamu', 'core' and 'x86/amd' into next

Michael S. Tsirkin (1):
      x86/vt-d: Fix comment for dma_pte_free_pagetable()

Peng Fan (1):
      iommu/arm-smmu: Clear cache lock bit of ACR

Robin Murphy (15):
      iommu: Add MMIO mapping type
      iommu/io-pgtable-arm: Support IOMMU_MMIO flag
      iommu/io-pgtable-arm-v7s: Support IOMMU_MMIO flag
      iommu/arm-smmu: Differentiate specific implementations
      iommu/arm-smmu: Convert ThunderX workaround to new method
      iommu/arm-smmu: Work around MMU-500 prefetch errata
      io-64-nonatomic: Add relaxed accessor variants
      iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
      iommu/arm-smmu: Decouple context format from kernel config
      iommu/arm-smmu: Support SMMUv1 64KB supplement
      iommu/dma: Implement scatterlist segment merging
      iommu: of: enforce const-ness of struct iommu_ops
      iommu: Allow selecting page sizes per domain
      iommu/dma: Finish optimising higher-order allocations
      iommu/arm-smmu: Use per-domain page sizes.

Suman Anna (4):
      iommu/omap: Remove iopgtable_clear_entry_all() from driver remove
      iommu/omap: Replace BUG() in iopgtable_store_entry_core()
      iommu/omap: Use WARN_ON for page table alignment check
      iommu/omap: Align code with open parenthesis

Suravee Suthikulpanit (4):
      iommu/amd: Adding Extended Feature Register check for PC support
      iommu/amd: Modify ivhd_header structure to support type 11h and 40h
      iommu/amd: Use the most comprehensive IVHD type that the driver can support
      iommu/amd: Introduces ivrs_acpihid kernel parameter

Tirumalesh Chalamarla (2):
      iommu/arm-smmu: Add support for 16 bit VMID
      iommu/arm-smmu: Workaround for ThunderX erratum #27704

Tomeu Vizoso (1):
      iommu/rockchip: Don't feed NULL res pointers to devres

Wan Zongshun (5):
      iommu/amd: Add new map for storing IVHD dev entry type HID
      iommu/amd: Make call-sites of get_device_id aware of its return value
      iommu/amd: Add iommu support for ACPI HID devices
      iommu/amd: Manage iommu_group for ACPI HID devices
      iommu/amd: Set AMD iommu callbacks for amba bus

Will Deacon (1):
      iommu: remove unused priv field from struct iommu_ops

Yong Wu (2):
      iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
      iommu/mediatek: Add 4GB mode support

 Documentation/arm64/silicon-errata.txt             |   2 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 Documentation/kernel-parameters.txt                |   7 +
 arch/arm/include/asm/dma-mapping.h                 |   2 +-
 arch/arm/mm/dma-mapping.c                          |   6 +-
 arch/arm64/include/asm/dma-mapping.h               |   2 +-
 arch/arm64/mm/dma-mapping.c                        |   8 +-
 drivers/iommu/Kconfig                              |  13 +-
 drivers/iommu/amd_iommu.c                          | 267 +++++++++--------
 drivers/iommu/amd_iommu_init.c                     | 329 ++++++++++++++++++---
 drivers/iommu/amd_iommu_types.h                    |  40 +--
 drivers/iommu/arm-smmu-v3.c                        |  19 +-
 drivers/iommu/arm-smmu.c                           | 308 +++++++++++++------
 drivers/iommu/dma-iommu.c                          | 146 ++++++---
 drivers/iommu/dmar.c                               |  47 +--
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  29 +-
 drivers/iommu/io-pgtable-arm.c                     |   9 +-
 drivers/iommu/io-pgtable.c                         |   3 +-
 drivers/iommu/io-pgtable.h                         |   6 +
 drivers/iommu/iommu.c                              |  22 +-
 drivers/iommu/mtk_iommu.c                          |  16 +-
 drivers/iommu/of_iommu.c                           |  14 +-
 drivers/iommu/omap-iommu-debug.c                   |   2 +-
 drivers/iommu/omap-iommu.c                         |  10 +-
 drivers/iommu/rockchip-iommu.c                     |   2 +
 drivers/of/device.c                                |   2 +-
 drivers/vfio/vfio_iommu_type1.c                    |   2 +-
 include/asm-generic/io.h                           |   4 +-
 include/linux/dma-iommu.h                          |   4 +-
 include/linux/dma-mapping.h                        |   2 +-
 include/linux/io-64-nonatomic-hi-lo.h              |  25 ++
 include/linux/io-64-nonatomic-lo-hi.h              |  25 ++
 include/linux/iommu.h                              |   6 +-
 include/linux/of_iommu.h                           |   8 +-
 35 files changed, 974 insertions(+), 416 deletions(-)

Please pull.

Thanks,

	Joerg

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXPejYAAoJECvwRC2XARrjkAYQALm2rh8L4ZtljfJKodEbTmjI
QjWZhYxIeAv3PF2QKlsokBu4wEfjtWcPpqfIAurW0PkIj4anxXtZZ2u2wtTP8hg5
zBqNfxdrQf5ltKZypCSCLQ5jAd374DhIaZy6+0PloK5A0UBFxswL22oxidmnW23M
+ayDXRuXH1bO3boV6eF3rgJH1UFOJCL1c6QDjD5mjr4Old19N63A/VdQjBSes5vN
beer2M4XtNs5wO3ss1H4qLn5jTDWL/ia6rMiNKpiqtEtBi+pSq9VySUWQmqihHvR
MJ3DNpo1Bx3f88cl3kSEst1YgpgpyJCgg5Dk2WKV4puDDjMJ9qwDvG4CN1zZwcuW
m/5JMDdngy4rJderjtLxhnhBZ/bv7H+FJO2CtevmGsiF0/83gW5QQkqdo4SI46al
JfkV/eZaVDN3gLa8Yjo2KeBIXrHX70SVZ5rfpg89YhAXqio0hS7mTkYlsjlN1Mar
4NbpPVoKqvRIMHPPU/onXv4XvDOBSS4jqLwvj61C6j+8RZRuHgp2r9vLUaFpNCih
WTTXTqc9Kv0Dq4y8Fw1/WiI50b8zh03mvE+Tq7yrm+rhkfUfnQLxiWIrsi7VrWYN
S8iY9ZtRub/obtUFXz+Z2FVIH5ftxqmy0yy5VP9tqjCX+K/9FrnlFHdjniDAsanK
G2x46Ov4qV1VKUOILZQw
=WauP
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============6306169070796446894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6306169070796446894==--
