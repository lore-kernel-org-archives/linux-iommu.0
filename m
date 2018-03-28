From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] dma-mapping: don't clear GFP_ZERO in dma_alloc_attrs
Date: Wed, 28 Mar 2018 15:35:35 +0200
Message-ID: <20180328133535.17302-2-hch@lst.de>
References: <20180328133535.17302-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180328133535.17302-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Evgeniy Didin <Evgeniy.Didin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Revert the clearing of __GFP_ZERO in dma_alloc_attrs and move it to
dma_direct_alloc for now.  While most common architectures always zero dma
cohereny allocations (and x86 did so since day one) this is not documented
and at least arc and s390 do not zero without the explicit __GFP_ZERO
argument.

Fixes: 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")
Reported-by: Evgeniy Didin <Evgeniy.Didin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Reported-by: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-mapping.h | 8 ++------
 lib/dma-direct.c            | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4ecd6d..12fedcba9a9a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -518,12 +518,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
-	/*
-	 * Let the implementation decide on the zone to allocate from, and
-	 * decide on the way of zeroing the memory given that the memory
-	 * returned should always be zeroed.
-	 */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
+	/* let the implementation decide on the zone to allocate from: */
+	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 1277d293d4da..c0bba30fef0a 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -59,6 +59,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page = NULL;
 	void *ret;
 
+	/* we always manually zero the memory once we are done: */
+	gfp &= ~__GFP_ZERO;
+
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
 		gfp |= GFP_DMA;
-- 
2.14.2
