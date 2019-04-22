From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 13/26] iommu/dma: Remove __iommu_dma_free
Date: Mon, 22 Apr 2019 19:59:29 +0200
Message-ID: <20190422175942.18788-14-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190422175942.18788-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We only have a single caller of this function left, so open code it there.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b8e46e89a60a..4632b9d301a1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -534,24 +534,6 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
 	return area->pages;
 }
 
-/**
- * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
- * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
- * @size: Size of buffer in bytes
- * @handle: DMA address of buffer
- *
- * Frees both the pages associated with the buffer, and the array
- * describing them
- */
-static void __iommu_dma_free(struct device *dev, struct page **pages,
-		size_t size, dma_addr_t *handle)
-{
-	__iommu_dma_unmap(dev, *handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_MAPPING_ERROR;
-}
-
 /**
  * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
@@ -1034,7 +1016,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 		if (WARN_ON(!pages))
 			return;
-		__iommu_dma_free(dev, pages, iosize, &handle);
+		__iommu_dma_unmap(dev, handle, iosize);
+		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
 		__iommu_dma_unmap(dev, handle, iosize);
-- 
2.20.1
