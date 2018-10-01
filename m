From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] dma-mapping: translate __GFP_NOFAIL to DMA_ATTR_NO_WARN
Date: Mon,  1 Oct 2018 13:12:56 -0700
Message-ID: <20181001201257.366-2-hch@lst.de>
References: <20181001201257.366-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001201257.366-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This allows all dma_map_ops instances to entirely rely on
DMA_ATTR_NO_WARN going forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 562af6b45f23..02ecd4679e47 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -557,9 +557,11 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 }
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag)
+		dma_addr_t *dma_handle, gfp_t gfp)
 {
-	return dma_alloc_attrs(dev, size, dma_handle, flag, 0);
+
+	return dma_alloc_attrs(dev, size, dma_handle, gfp,
+			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
@@ -793,8 +795,12 @@ static inline void dmam_release_declared_memory(struct device *dev)
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
-	return dma_alloc_attrs(dev, size, dma_addr, gfp,
-			       DMA_ATTR_WRITE_COMBINE);
+	unsigned long attrs = DMA_ATTR_NO_WARN;
+
+	if (gfp & __GFP_NOWARN)
+		attrs |= DMA_ATTR_NO_WARN;
+
+	return dma_alloc_attrs(dev, size, dma_addr, gfp, attrs);
 }
 #ifndef dma_alloc_writecombine
 #define dma_alloc_writecombine dma_alloc_wc
-- 
2.19.0
