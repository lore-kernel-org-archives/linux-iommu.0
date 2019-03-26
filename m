From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 RFC/RFT 3/5] iommu: amd_iommu: Add fallback normal page allocations
Date: Tue, 26 Mar 2019 16:01:29 -0700
Message-ID: <20190326230131.16275-4-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Note: amd_iommu driver uses dma_alloc_from_contiguous() as a fallback
      allocation and uses alloc_pages() as its first round allocation.
      This's in reverse order than other callers. So the alloc_pages()
      added by this change becomes a second fallback, though it likely
      won't succeed since the alloc_pages() has failed once.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 21cb088d6687..2aa4818f5249 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2701,6 +2701,9 @@ static void *alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 					get_order(size), flag & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(flag | __GFP_NOWARN,
+					   get_order(size));
 		if (!page)
 			return NULL;
 	}
-- 
2.17.1
