From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH 1/1] swiotlb: fix comment on swiotlb_bounce()
Date: Tue, 28 Aug 2018 15:46:37 +0800
Message-ID: <1535442397-28647-1-git-send-email-dongli.zhang@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

Fix the comment as swiotlb_bounce() is used to copy from original dma
location to swiotlb buffer during swiotlb_tbl_map_single(), while to
copy from swiotlb buffer to original dma location during
swiotlb_tbl_unmap_single().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6db..8fd4cfe 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -435,7 +435,7 @@ int is_swiotlb_buffer(phys_addr_t paddr)
 }
 
 /*
- * Bounce: copy the swiotlb buffer back to the original dma location
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
 static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
-- 
2.7.4
