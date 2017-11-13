From: Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] IOMMU updates for v4.15
Date: Mon, 13 Nov 2017 14:47:05 -0700
Message-ID: <20171113144705.08dee688@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

As Joerg mentioned[1], he's out on paternity leave through the end of
the year and I'm filling in for him in the interim.  Thanks,

Alex

[1] https://lkml.org/lkml/2017/10/22/72

The following changes since commit ce76353f169a6471542d999baf3d29b121dce9c0:

  iommu/amd: Finish TLB flush in amd_iommu_unmap() (2017-10-13 17:32:19 +0200)

are available in the git repository at:

  git://github.com/awilliam/linux-vfio.git tags/iommu-v4.15-rc1

for you to fetch changes up to 56f19441da39e5f27824bcbdf3f60980414b5bd0:

  Merge branches 'iommu/arm/smmu', 'iommu/updates', 'iommu/vt-d', 'iommu/ipmmu-vmsa' and 'iommu/iova' into iommu-next-20171113.0 (2017-11-13 12:40:51 -0700)

----------------------------------------------------------------

IOMMU Updates for Linux v4.15

 * Enforce MSI multiple IRQ alignment in AMD IOMMU

 * VT-d PASID error handling fixes

 * Add r8a7795 IPMMU support

 * Manage runtime PM links on exynos at {add,remove}_device callbacks

 * Fix Mediatek driver name to avoid conflict

 * Add terminate support to qcom fault handler

 * 64-bit IOVA optimizations

 * Simplfy IOVA domain destruction, better use of rcache, and
   skip anchor nodes on copy

 * Convert to IOMMU TLB sync API in io-pgtable-arm{-v7s}

 * Drop command queue lock when waiting for CMD_SYNC completion on
   ARM SMMU implementations supporting MSI to cacheable memory

 * iomu-vmsa cleanup inspired by missed IOTLB sync callbacks

 * Fix sleeping lock with preemption disabled for RT

 * Dual MMU support for TI DRA7xx DSPs

 * Optional flush option on IOVA allocation avoiding overhead when
   caller can try other options

----------------------------------------------------------------
Alex Williamson (2):
      iommu/amd: Fix alloc_irq_index() increment
      Merge branches 'iommu/arm/smmu', 'iommu/updates', 'iommu/vt-d', 'iommu/ipmmu-vmsa' and 'iommu/iova' into iommu-next-20171113.0

Christos Gkekas (1):
      iommu/vt-d: Delete unnecessary check in domain_context_mapping_one()

Colin Ian King (1):
      iommu/amd: remove unused variable flush_addr

Feng Kan (1):
      iommu/arm-smmu: Enable bypass transaction caching for ARM SMMU 500

Gary R Hook (1):
      iommu/amd: Limit the IOVA page range to the specified addresses

Joerg Roedel (4):
      iommu/vt-d: Don't register bus-notifier under dmar_global_lock
      iommu/amd: Add align parameter to alloc_irq_index()
      iommu/amd: Enforce alignment for MSI IRQs
      Merge branches 'iommu/fixes', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next

Lu Baolu (3):
      iommu/vt-d: Missing checks for pasid tables if allocation fails
      iommu/vt-d: Clear Page Request Overflow fault bit
      iommu/vt-d: Clear pasid table entry when memory unbound

Magnus Damm (9):
      iommu/ipmmu-vmsa: Introduce features, break out alias
      iommu/ipmmu-vmsa: Add optional root device feature
      iommu/ipmmu-vmsa: Enable multi context support
      iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
      iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
      iommu/ipmmu-vmsa: Write IMCTR twice
      iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
      iommu/ipmmu-vmsa: Allow two bit SL0
      iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

Marek Szyprowski (1):
      iommu/exynos: Rework runtime PM links management

Matthias Brugger (1):
      iommu/mediatek: Fix driver name

Rob Clark (1):
      iommu: qcom: wire up fault handler

Robin Murphy (19):
      iommu/iova: Extend rbtree node caching
      iommu/iova: Add rbtree anchor node
      iommu/iova: Simplify cached node logic
      iommu/iova: Simplify domain destruction
      iommu/iova: Make rcache limit_pfn handling more robust
      iommu/iova: Try harder to allocate from rcache magazine
      iommu/iova: Don't try to copy anchor nodes
      iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
      iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync
      iommu/arm-smmu: Remove ACPICA workarounds
      iommu/arm-smmu-v3: Correct COHACC override message
      iommu/arm-smmu-v3: Specialise CMD_SYNC handling
      iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
      iommu/arm-smmu-v3: Use CMD_SYNC completion MSI
      iommu/arm-smmu-v3: Use burst-polling for sync completion
      iommu/ipmmu-vmsa: Unify domain alloc/free
      iommu/ipmmu-vmsa: Simplify group allocation
      iommu/ipmmu-vmsa: Clean up struct ipmmu_vmsa_iommu_priv
      iommu/ipmmu-vmsa: Unify ipmmu_ops

Sebastian Andrzej Siewior (1):
      iommu/iova: Use raw_cpu_ptr() instead of get_cpu_ptr() for ->fq

Suman Anna (2):
      iommu/omap: Change the attach detection logic
      iommu/omap: Add support to program multiple iommus

Tomasz Nowicki (1):
      iommu/iova: Make rcache flush optional on IOVA allocation failure

Will Deacon (3):
      iommu/arm-smmu-v3: Ensure we sync STE when only changing config field
      iommu/arm-smmu-v3: Split arm_smmu_cmdq_issue_sync in half
      iommu/arm-smmu-v3: Consolidate identical timeouts

Yisheng Xie (1):
      iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD and CD.S

Zhen Lei (3):
      iommu/iova: Optimise rbtree searching
      iommu/iova: Optimise the padding calculation
      iommu/iova: Make dma_32bit_pfn implicit

weiyongjun (A) (1):
      iommu/ipmmu-vmsa: Fix return value check in ipmmu_find_group_dma()

 drivers/gpu/drm/tegra/drm.c        |   3 +-
 drivers/gpu/host1x/dev.c           |   3 +-
 drivers/iommu/amd_iommu.c          |  43 +--
 drivers/iommu/arm-smmu-v3.c        | 214 ++++++++++-----
 drivers/iommu/arm-smmu.c           |  31 ++-
 drivers/iommu/dma-iommu.c          |  24 +-
 drivers/iommu/dmar.c               |  10 +-
 drivers/iommu/exynos-iommu.c       |  23 +-
 drivers/iommu/intel-iommu.c        |  28 +-
 drivers/iommu/intel-svm.c          |   4 +-
 drivers/iommu/io-pgtable-arm-v7s.c |   7 +-
 drivers/iommu/io-pgtable-arm.c     |   7 +-
 drivers/iommu/iova.c               | 220 +++++++---------
 drivers/iommu/ipmmu-vmsa.c         | 527 ++++++++++++++++++++++---------------
 drivers/iommu/mtk_iommu.c          |   7 +
 drivers/iommu/mtk_iommu_v1.c       |   2 +-
 drivers/iommu/omap-iommu.c         | 375 +++++++++++++++++++-------
 drivers/iommu/omap-iommu.h         |  30 +--
 drivers/iommu/qcom_iommu.c         |  33 ++-
 drivers/misc/mic/scif/scif_rma.c   |   3 +-
 include/linux/dmar.h               |   1 +
 include/linux/intel-iommu.h        |   1 +
 include/linux/iova.h               |  14 +-
 23 files changed, 983 insertions(+), 627 deletions(-)
