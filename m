From: Esteban Zamora <estebanzacr.20@gmail.com>
Subject: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
Date: Sat, 18 Aug 2018 13:04:51 -0600
Message-ID: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: estebanzacr.20@gmail.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The mmap function pointer on swiotlb_dma_ops struct is
uninitialized, which causes a random crash when calling
the dma_mmap_coherent function on platforms where no DMA
address translation hardware is available.

Set this pointer to NULL in order to fix the issue.

Signed-off-by: Esteban Zamora <estebanzacr.20@gmail.com>
---
 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6db..9a7718c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
 	.dma_supported		= dma_direct_supported,
+	.mmap                   = NULL,
 };
 EXPORT_SYMBOL(swiotlb_dma_ops);
-- 
2.7.4
