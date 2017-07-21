From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/4] Optimise 64-bit IOVA allocations
Date: Fri, 21 Jul 2017 12:41:57 +0100
Message-ID: <cover.1500636791.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, thunder.leizhen@huawei.com, lorenzo.pieralisi@arm.com, ard.biesheuvel@linaro.org, Jonathan.Cameron@huawei.com, nwatters@codeaurora.org, ray.jui@broadcom.com
List-Id: iommu@lists.linux-foundation.org

Hi all,

In the wake of the ARM SMMU optimisation efforts, it seems that certain
workloads (e.g. storage I/O with large scatterlists) probably remain quite
heavily influenced by IOVA allocation performance. Separately, Ard also
reported massive performance drops for a graphical desktop on AMD Seattle
when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
ops domain getting initialised differently for ACPI vs. DT, and exposing
the overhead of the rbtree slow path. Whilst we could go around trying to
close up all the little gaps that lead to hitting the slowest case, it
seems a much better idea to simply make said slowest case a lot less slow.

I had a go at rebasing Leizhen's last IOVA series[1], but ended up finding
the changes rather too hard to follow, so I've taken the liberty here of
picking the whole thing up and reimplementing the main part in a rather
less invasive manner.

Robin.

Changes from v1:
 - Fix overflow with 32-bit dma_addr_t
 - Add tested-bys

[1] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg17753.html

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
 drivers/iommu/iova.c             | 112 ++++++++++++++++-----------------------
 drivers/misc/mic/scif/scif_rma.c |   3 +-
 include/linux/iova.h             |   8 +--
 8 files changed, 60 insertions(+), 105 deletions(-)

-- 
2.12.2.dirty
