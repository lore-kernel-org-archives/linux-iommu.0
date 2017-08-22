From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 0/4] Optimise 64-bit IOVA allocations
Date: Tue, 22 Aug 2017 16:17:41 +0100
Message-ID: <cover.1503412074.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, thunder.leizhen@huawei.com, ard.biesheuvel@linaro.org, nwatters@codeaurora.org, ray.jui@broadcom.com
List-Id: iommu@lists.linux-foundation.org

Hi all,

Just a quick repost of v2[1] with a small fix for the bug reported by Nate.
To recap, whilst this mostly only improves worst-case performance, those
worst-cases have a tendency to be pathologically bad:

Ard reports general desktop performance with Chromium on AMD Seattle going
from ~1-2FPS to perfectly usable.

Leizhen reports gigabit ethernet throughput going from ~6.5Mbit/s to line
speed.

I also inadvertantly found that the HiSilicon hns_dsaf driver was taking ~35s
to probe simply becuase of the number of DMA buffers it maps on startup (perf
shows around 76% of that was spent under the lock in alloc_iova()). With this
series applied it takes a mere ~1s, mostly of unrelated mdelay()s, with
alloc_iova() entirely lost in the noise.

Robin.

[1] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg19139.html

Robin Murphy (1):
  iommu/iova: Extend rbtree node caching

Zhen Lei (3):
  iommu/iova: Optimise rbtree searching
  iommu/iova: Optimise the padding calculation
  iommu/iova: Make dma_32bit_pfn implicit

 drivers/gpu/drm/tegra/drm.c      |   3 +-
 drivers/gpu/host1x/dev.c         |   3 +-
 drivers/iommu/amd_iommu.c        |   7 +--
 drivers/iommu/dma-iommu.c        |  18 +------
 drivers/iommu/intel-iommu.c      |  11 ++--
 drivers/iommu/iova.c             | 114 +++++++++++++++++----------------------
 drivers/misc/mic/scif/scif_rma.c |   3 +-
 include/linux/iova.h             |   8 +--
 8 files changed, 62 insertions(+), 105 deletions(-)

-- 
2.13.4.dirty
