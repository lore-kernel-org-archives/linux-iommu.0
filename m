From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 0/6] Optimise 64-bit IOVA allocations
Date: Thu, 21 Sep 2017 16:52:41 +0100
Message-ID: <cover.1506007392.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, dwoods@mellanox.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

v4: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1493704.html

Right, this is hopefully the last version - I've put things back in a
sensible order with the new additions at the end, so if they prove
contentious the first 4 previously-tested patches can still get their
time in -next. Patch #3 is updated to fix the bug brought to light by
Tomasz, patch #6 includes the cleanup afterthought from v4, and I've
nobbled one or two rogue whitespace changes I'd missed before.

And the diffstat is still even more negative than before, hooray! For
the whole series, the total code size reduction of alloc_iova() comes
to just over 26% (AArch64 GCC 6.3.1).

Robin.


Robin Murphy (3):
  iommu/iova: Extend rbtree node caching
  iommu/iova: Add rbtree anchor node
  iommu/iova: Simplify cached node logic

Zhen Lei (3):
  iommu/iova: Optimise rbtree searching
  iommu/iova: Optimise the padding calculation
  iommu/iova: Make dma_32bit_pfn implicit

 drivers/gpu/drm/tegra/drm.c      |   3 +-
 drivers/gpu/host1x/dev.c         |   3 +-
 drivers/iommu/amd_iommu.c        |   7 +-
 drivers/iommu/dma-iommu.c        |  18 +-----
 drivers/iommu/intel-iommu.c      |  11 +---
 drivers/iommu/iova.c             | 135 ++++++++++++++++-----------------------
 drivers/misc/mic/scif/scif_rma.c |   3 +-
 include/linux/iova.h             |   9 +--
 8 files changed, 69 insertions(+), 120 deletions(-)

-- 
2.13.4.dirty
