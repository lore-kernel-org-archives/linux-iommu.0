From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.9
Date: Tue, 11 Oct 2016 16:56:41 +0200
Message-ID: <20161011145631.GA14209@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3685016353421596644=="
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


--===============3685016353421596644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3be7988674ab33565700a37b210f502563d932e6:

  Linux 4.8-rc7 (2016-09-18 17:27:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.9

for you to fetch changes up to 13a08259187c5cd3f63d98efa159ab42976d85a4:

  Merge branches 'x86/amd', 'x86/vt-d', 'arm/exynos', 'arm/mediatek', 'arm/renesas' and 'arm/smmu' into next (2016-09-20 13:27:09 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.9

Including:

	* Support for interrupt virtualization in the AMD IOMMU driver.
	  These patches were shared with the KVM tree and are already
	  merged through that tree.

	* Generic DT-binding support for the ARM-SMMU driver. With this
	  the driver now makes use of the generic DMA-API code. This
	  also required some changes outside of the IOMMU code, but
	  these are acked by the respective maintainers.

	* More cleanups and fixes all over the place.

----------------------------------------------------------------
Amitoj Kaur Chawla (1):
      iommu/exynos: Fix error handling for of_platform_device_create

Baoquan He (4):
      iommu/amd: Clean up the cmpxchg64 invocation
      iommu/amd: Use standard bitmap operation to set bitmap
      iommu/amd: Free domain id when free a domain of struct dma_ops_domain
      iommu/amd: No need to wait iommu completion if no dte irq entry change

Fabian Frederick (1):
      iommu/amd: Remove AMD_IOMMU_STATS

Honghui Zhang (1):
      iommu/mediatek: dt-binding: Correct the larb port offset defines for mt2701

Jean-Philippe Brucker (2):
      iommu/arm-smmu: Fix event queues synchronization
      iommu/arm-smmu: Fix polling of command queue

Joerg Roedel (5):
      Merge branch 'x86/amd-avic' into x86/amd
      iommu/vt-d: Split up get_domain_for_dev function
      iommu/vt-d: Make sure RMRRs are mapped before domain goes public
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'x86/amd', 'x86/vt-d', 'arm/exynos', 'arm/mediatek', 'arm/renesas' and 'arm/smmu' into next

Mark Rutland (1):
      Docs: dt: add PCI IOMMU map bindings

Peng Fan (1):
      iommu/arm-smmu: Drop devm_free_irq when driver detach

Robin Murphy (23):
      iommu/arm-smmu: Support v7s context format
      of/irq: Break out msi-map lookup (again)
      iommu/of: Handle iommu-map property for PCI
      iommu: Introduce iommu_fwspec
      Docs: dt: document ARM SMMUv3 generic binding usage
      iommu/arm-smmu: Fall back to global bypass
      iommu/arm-smmu: Implement of_xlate() for SMMUv3
      iommu/arm-smmu: Support non-PCI devices with SMMUv3
      iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
      iommu/arm-smmu: Handle stream IDs more dynamically
      iommu/arm-smmu: Consolidate stream map entry state
      iommu/arm-smmu: Keep track of S2CR state
      iommu/arm-smmu: Refactor mmu-masters handling
      iommu/arm-smmu: Streamline SMMU data lookups
      iommu/arm-smmu: Add a stream map entry iterator
      iommu/arm-smmu: Intelligent SMR allocation
      iommu/arm-smmu: Convert to iommu_fwspec
      Docs: dt: document ARM SMMU generic binding usage
      iommu/arm-smmu: Wire up generic configuration support
      iommu/arm-smmu: Set domain geometry
      iommu/dma: Add support for mapping MSIs
      iommu/dma: Avoid PCI host bridge windows
      iommu/io-pgtable-arm: Check for v7s-incapable systems

Shawn Lin (1):
      iommu/ipmmu-vmsa: Fix wrong error handle of ipmmu_add_device

Suravee Suthikulpanit (9):
      iommu/amd: Detect and enable guest vAPIC support
      iommu/amd: Move and introduce new IRTE-related unions and structures
      iommu/amd: Introduce interrupt remapping ops structure
      iommu/amd: Add support for multiple IRTE formats
      iommu/amd: Detect and initialize guest vAPIC log
      iommu/amd: Adding GALOG interrupt handler
      iommu/amd: Introduce amd_iommu_update_ga()
      iommu/amd: Implements irq_set_vcpu_affinity() hook to setup vapic mode for pass-through devices
      iommu/amd: Enable vAPIC interrupt remapping mode by default

Wei Yongjun (2):
      iommu/amd: Fix non static symbol warning
      iommu/amd: Fix error return code in irq_remapping_alloc()

Will Deacon (1):
      iommu/arm-smmu: Disable interrupts whilst holding the cmdq lock

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |  61 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
 Documentation/kernel-parameters.txt                |   9 +
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 arch/x86/configs/x86_64_defconfig                  |   1 -
 drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/amd_iommu.c                          | 499 +++++++++--
 drivers/iommu/amd_iommu_init.c                     | 184 +++-
 drivers/iommu/amd_iommu_proto.h                    |   7 +-
 drivers/iommu/amd_iommu_types.h                    | 149 +++
 drivers/iommu/arm-smmu-v3.c                        | 561 ++++++------
 drivers/iommu/arm-smmu.c                           | 995 ++++++++++-----------
 drivers/iommu/dma-iommu.c                          | 161 +++-
 drivers/iommu/exynos-iommu.c                       |   4 +-
 drivers/iommu/intel-iommu.c                        | 103 ++-
 drivers/iommu/io-pgtable-arm-v7s.c                 |   4 +
 drivers/iommu/iommu.c                              |  58 ++
 drivers/iommu/ipmmu-vmsa.c                         |   2 +-
 drivers/iommu/of_iommu.c                           |  52 +-
 drivers/irqchip/irq-gic-v2m.c                      |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +
 drivers/of/irq.c                                   |  78 +-
 drivers/of/of_pci.c                                | 102 +++
 include/dt-bindings/memory/mt2701-larb-port.h      |   2 +-
 include/linux/amd-iommu.h                          |  43 +-
 include/linux/device.h                             |   3 +
 include/linux/dma-iommu.h                          |  12 +-
 include/linux/iommu.h                              |  39 +
 include/linux/of_pci.h                             |  10 +
 31 files changed, 2322 insertions(+), 1008 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

Please pull.

Thanks,

	Joerg

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJX/P2fAAoJECvwRC2XARrjTNMQAOAJslnaq7bdcWdkX3N11sQn
VpSO4Fl+UaGrJQmdi/mKOcMw1EK2JjouW72A8c8AA68H8U6Cf7treYLu2/aH7y51
moQv1M5eQBlaJN4g4oaP1sF3RzcL2wAHLjN9s97QFhdtLHb/SpZBn4Hs0cj6kDX+
W+jYwP/YKVex+JbNChUR4ZiKpSerk5qA8Xt6+B7rdrdBLp57YJkR7y1jGS3EdRje
2yyaC5mw43U/We8w1IZbYcMZLEn8/0z7ap5YNjdhR1k8kkNZSmkJ2kbc4MyjTV1z
KaFH8J+QQ0SY+BtWTYDkT36IPFO3NPQxN4azNWYdFuqFjLZTrtReWmYJJls321ct
4Uf6NBPo4L9C4tcpjAbdYBTNpSqL08D8vNovhGxUqY5e+m+0KgnvpJovDbSxYaId
MyAGgUeAhnSNLU/aGdOLwpoKGYV2mSuGicUrd/HXDidrETxu5DxRb0QZhCfOx5gD
V9/XN9D3dzPzXkED4GbBfkxX/nCz63n/JjJUdrktAtOsiy7TVCF/P0EAqa6tdgmj
WF3GD2cB8Xe6C0tKrNuihGH46na9ytGdJTx7KLZlF6vy4Aclepb5eqYRi+sw0e5C
90tvWxIt3uyP9PvOdr08+OBgxk1rjPf1MaD7fVMKafVbkfhj0MqjazKeWtHRbSOf
MHJLGkQPZ59Y6nlh0nLG
=Dx/O
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--===============3685016353421596644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3685016353421596644==--
