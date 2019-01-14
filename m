From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/19] dma-iommu: don't remap contiguous allocations for coherent devices
Date: Mon, 14 Jan 2019 10:41:53 +0100
Message-ID: <20190114094159.27326-14-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no need to remap for pte attributes, or for a virtually
contiguous address, so just don't do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c9788e0c1d5d..710814a370b9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1041,10 +1041,10 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
-		if (!addr)
-			return NULL;
-		page = virt_to_page(addr);
+		if (coherent || !addr)
+			return addr;
 
+		page = virt_to_page(addr);
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
 				__builtin_return_address(0));
 		if (!addr) {
@@ -1052,8 +1052,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 			return NULL;
 		}
 
-		if (!coherent)
-			arch_dma_prep_coherent(page, iosize);
+		arch_dma_prep_coherent(page, iosize);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1
