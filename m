From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 0/6] Optimise 64-bit IOVA allocations
Date: Tue, 19 Sep 2017 17:31:51 +0100
Message-ID: <cover.1505829018.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

v3: https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg19694.html

This was supposed to be just a rebase and repost, but in the meantime I
kept scratching the itch and ended up with two extra patches to simplify
the end result even more - the series was least churny with them added
in the middle, but #5 and #6 remain essentially unchanged from v3, such
that I'm happy the tested-bys all remain valid.

Robin.

Robin Murphy (3):
  iommu/iova: Add rbtree anchor node
  iommu/iova: Simplify cached node logic
  iommu/iova: Extend rbtree node caching

Zhen Lei (3):
  iommu/iova: Optimise rbtree searching
  iommu/iova: Optimise the padding calculation
  iommu/iova: Make dma_32bit_pfn implicit

 drivers/gpu/drm/tegra/drm.c      |   3 +-
 drivers/gpu/host1x/dev.c         |   3 +-
 drivers/iommu/amd_iommu.c        |   7 +-
 drivers/iommu/dma-iommu.c        |  18 +----
 drivers/iommu/intel-iommu.c      |  11 +---
 drivers/iommu/iova.c             | 139 +++++++++++++++++----------------------
 drivers/misc/mic/scif/scif_rma.c |   3 +-
 include/linux/iova.h             |   9 +--
 8 files changed, 74 insertions(+), 119 deletions(-)

-- 
2.13.4.dirty
