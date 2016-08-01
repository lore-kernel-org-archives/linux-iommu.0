From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.8
Date: Mon, 1 Aug 2016 10:59:16 +0200
Message-ID: <20160801085908.GA4105@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5508049342788403946=="
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


--===============5508049342788403946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.8

for you to fetch changes up to f360d3241f5557f241d55b959e6e65070e77992e:

  Merge branches 'x86/amd', 'x86/vt-d', 'arm/exynos', 'arm/mediatek', 'arm/msm', 'arm/rockchip', 'arm/smmu' and 'core' into next (2016-07-26 16:02:37 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.8

In the updates:

	* Big endian support and preparation for defered probing for the
	  Exynos IOMMU driver

	* Simplifications in iommu-group id handling

	* Support for Mediatek generation one IOMMU hardware

	* Conversion of the AMD IOMMU driver to use the generic IOVA
	  allocator. This driver now also benefits from the recent
	  scalability improvements in the IOVA code.

	* Preparations to use generic DMA mapping code in the Rockchip
	  IOMMU driver

	* Device tree adaption and conversion to use generic page-table
	  code for the MSM IOMMU driver

	* An iova_to_phys optimization in the ARM-SMMU driver to greatly
	  improve page-table teardown performance with VFIO

	* Various other small fixes and conversions

----------------------------------------------------------------
Andrea Gelmini (1):
      iommu/arm-smmu: Fix typo in devicetree binding introductory text

Ben Dooks (1):
      iommu/exynos: update to use iommu big-endian

Bhaktipriya Shridhar (1):
      iommu/amd: Remove create_workqueue

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for iommu device tree bindings

Heiner Kallweit (2):
      iommu: Simplify init function
      iommu: Simplify and fix ida handling

Honghui Zhang (5):
      iommu/mediatek: Do not call of_node_put in mtk_iommu_of_xlate
      dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and smi
      iommu/mediatek: move the common struct into header file
      memory/mediatek: add support for mt2701
      iommu/mediatek: add support for mtk iommu generation one HW

Joerg Roedel (26):
      iommu/mediatek: Make mtk_iommu_pm_ops static
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/amd: Init unity mappings only for dma_ops domains
      iommu: Add apply_dm_region call-back to iommu-ops
      iommu/amd: Select IOMMU_IOVA for AMD IOMMU
      iommu/amd: Allocate iova_domain for dma_ops_domain
      iommu/amd: Create a list of reserved iova addresses
      iommu/amd: Implement apply_dm_region call-back
      iommu/amd: Pass gfp-flags to iommu_map_page()
      iommu/amd: Remove special mapping code for dma_ops path
      iommu/amd: Make use of the generic IOVA allocator
      iommu/amd: Remove other remains of old address allocator
      iommu/amd: Remove align-parameter from __map_single()
      iommu/amd: Set up data structures for flush queue
      iommu/amd: Allow NULL pointer parameter for domain_flush_complete()
      iommu/amd: Implement flush queue
      iommu/amd: Implement timeout to flush unmap queues
      iommu/amd: Introduce dir2prot() helper
      iommu/amd: Optimize map_sg and unmap_sg
      iommu/amd: Use dev_data->domain in get_domain()
      iommu/amd: Handle IOMMU_DOMAIN_DMA in ops->domain_free call-back
      iommu/amd: Flush iova queue before releasing dma_ops_domain
      iommu/amd: Use container_of to get dma_ops_domain
      iommu/amd: Update Alias-DTE in update_device_table()
      iommu/amd: Initialize dma-ops domains with 3-level page-table
      Merge branches 'x86/amd', 'x86/vt-d', 'arm/exynos', 'arm/mediatek', 'arm/msm', 'arm/rockchip', 'arm/smmu' and 'core' into next

Marek Szyprowski (5):
      iommu/exynos: Suppress unbinding to prevent system failure
      iommu/exynos: Return proper errors from getting clocks
      iommu/exynos: Fix master clock management for inactive SYSMMU
      iommu/exynos: Prepare clocks when needed, not in driver probe
      iommu/exynos: Prepare for deferred probe support

Nadav Amit (1):
      iommu/vt-d: Remove unnecassary qi clflushes

Peng Fan (1):
      iommu/arm-smmu: Use devm_request_irq and devm_free_irq

Roland Dreier (1):
      iommu/vt-d: Don't reject NTB devices due to scope mismatch

Shunqian Zheng (3):
      iommu/rockchip: Fix allocation of bases array in driver probe
      iommu/rockchip: Use DMA API to manage coherency
      iommu/rockchip: Prepare to support generic DMA mapping

Simon Xue (2):
      iommu/rockchip: Fix devm_{request,free}_irq parameter
      iommu/rockchip: Add map_sg callback for rk_iommu_ops

Sricharan R (6):
      iommu/msm: Add DT adaptation
      documentation: iommu: Add bindings for msm,iommu-v0 ip
      iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
      iommu/msm: Add support for generic master bindings
      iommu/msm: use generic ARMV7S short descriptor pagetable ops
      iommu/msm: Remove driver BROKEN

Wan Zongshun (1):
      iommu/amd: Set AMD iommu callbacks for platform bus driver

Wei Chen (1):
      iommu/arm-smmu: request pcie devices to enable ACS

Wei Yang (2):
      iommu/vt-d: Reduce extra first level entry in iommu->domains
      iommu/vt-d: Return error code in domain_context_mapping_one()

Will Deacon (1):
      iommu/io-pgtable-arm: Fix iova_to_phys for block entries

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    2 +-
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   13 +-
 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |   64 ++
 .../memory-controllers/mediatek,smi-common.txt     |   21 +-
 .../memory-controllers/mediatek,smi-larb.txt       |    4 +-
 MAINTAINERS                                        |    1 +
 drivers/iommu/Kconfig                              |   21 +-
 drivers/iommu/Makefile                             |    3 +-
 drivers/iommu/amd_iommu.c                          | 1032 ++++++++------------
 drivers/iommu/amd_iommu_types.h                    |    1 -
 drivers/iommu/amd_iommu_v2.c                       |    2 +-
 drivers/iommu/arm-smmu-v3.c                        |    2 +
 drivers/iommu/arm-smmu.c                           |   28 +-
 drivers/iommu/dmar.c                               |   21 +-
 drivers/iommu/exynos-iommu.c                       |  107 +-
 drivers/iommu/intel-iommu.c                        |    6 +-
 drivers/iommu/io-pgtable-arm.c                     |    2 +-
 drivers/iommu/iommu.c                              |   32 +-
 drivers/iommu/msm_iommu.c                          |  870 +++++++++--------
 drivers/iommu/msm_iommu.h                          |   73 +-
 drivers/iommu/msm_iommu_dev.c                      |  381 --------
 drivers/iommu/mtk_iommu.c                          |   49 +-
 drivers/iommu/mtk_iommu.h                          |   77 ++
 drivers/iommu/mtk_iommu_v1.c                       |  727 ++++++++++++++
 drivers/iommu/rockchip-iommu.c                     |  181 +++-
 drivers/memory/mtk-smi.c                           |  167 +++-
 include/dt-bindings/memory/mt2701-larb-port.h      |   85 ++
 include/linux/iommu.h                              |    3 +
 28 files changed, 2316 insertions(+), 1659 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c
 create mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 drivers/iommu/mtk_iommu_v1.c
 create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h

Please pull.

Thanks,

	Joerg

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXnw9cAAoJECvwRC2XARrjFQ0QAJRg3VjgN4xWEHYGh2zJZTri
mW2N1uYzUjjDp93E5gYpIfm7vXrwPuTW8Cif3hYOoatjReqFSVL9bzt/xuw8Znzw
2hdPjegGSDUEdUc/Gz1Dwo0bHMgnmVBFmnsZxetzVRIRFQ7t+/fJn1+ddNggdgBg
RvUT9EUM+1XrOIs06Fw+P0qGPNW8jShHYjhjxE54oBb9RRrNV7IHkud3CNJMah04
AUyP4utj9Hv9Wuj8kkgv+x9hPmXOrqOPgTuHqXmW34nSFx1snwAmZy21HB4AaagC
CqLaO4fFaG1ctLYx/dAFwz+b1YQ7boY2nvsDfv4JMG8x5IAo1EyHB8iwEfle/lz+
eeQNUDQTgZS4WUm9NPoDCth/CySyZtYOWQ/cHkksqIeIduDx1Yuh8ja1VM686TkE
b3aJPKVdbAYtDJc0TUpehiDSnRsNhKZh/1Khvg3Ue7GagrHzm70SWMFOyLHp/QM2
JE/667MzGfvn+PkBSKjMNvD/S918S4G5a/VcsO+2fJJA67DIFVIwtTxZIe4ouWib
DtweYMzjJP9Ia9VzdkVq9L6w4osb38P8s/Ru1SdZRkXJqcr58SWmxZRL6S/KAOFv
7w6t4ueZKTW0fsuG4vmors3zirv/qqhR9e0CUH08hyWRl2yTjWE6v3qH27KtnsbX
pSjLnDPu+7fDaTNxRHPn
=e+th
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--===============5508049342788403946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5508049342788403946==--
