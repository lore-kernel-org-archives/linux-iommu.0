From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/5] dma-mapping: implement dmam_alloc_coherent using
	dmam_alloc_attrs
Date: Wed,  2 Jan 2019 09:33:16 +0100
Message-ID: <20190102083319.12374-3-hch@lst.de>
References: <20190102083319.12374-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190102083319.12374-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

dmam_alloc_coherent is just the default no-flags case of
dmam_alloc_attrs, so take advantage of this similar to the non-managed
version.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-mapping.h | 20 ++++++++++++-------
 kernel/dma/mapping.c        | 39 -------------------------------------
 2 files changed, 13 insertions(+), 46 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0452a8be2789..fa2ebe8ad4d0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -677,21 +677,20 @@ dma_mark_declared_memory_occupied(struct device *dev,
  * Managed DMA API
  */
 #ifdef CONFIG_HAS_DMA
-extern void *dmam_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp);
+extern void *dmam_alloc_attrs(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 unsigned long attrs);
 extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 			       dma_addr_t dma_handle);
 #else /* !CONFIG_HAS_DMA */
-static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t gfp)
+static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
+					dma_addr_t *dma_handle, gfp_t gfp,
+					unsigned long attrs)
 { return NULL; }
 static inline void dmam_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_handle) { }
 #endif /* !CONFIG_HAS_DMA */
 
-extern void *dmam_alloc_attrs(struct device *dev, size_t size,
-			      dma_addr_t *dma_handle, gfp_t gfp,
-			      unsigned long attrs);
 #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 extern int dmam_declare_coherent_memory(struct device *dev,
 					phys_addr_t phys_addr,
@@ -711,6 +710,13 @@ static inline void dmam_release_declared_memory(struct device *dev)
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
+static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return dmam_alloc_attrs(dev, size, dma_handle, gfp,
+			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
+}
+
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d7c34d2d1ba5..f00544cda4e9 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -45,45 +45,6 @@ static int dmam_match(struct device *dev, void *res, void *match_data)
 	return 0;
 }
 
-/**
- * dmam_alloc_coherent - Managed dma_alloc_coherent()
- * @dev: Device to allocate coherent memory for
- * @size: Size of allocation
- * @dma_handle: Out argument for allocated DMA handle
- * @gfp: Allocation flags
- *
- * Managed dma_alloc_coherent().  Memory allocated using this function
- * will be automatically released on driver detach.
- *
- * RETURNS:
- * Pointer to allocated memory on success, NULL on failure.
- */
-void *dmam_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t gfp)
-{
-	struct dma_devres *dr;
-	void *vaddr;
-
-	dr = devres_alloc(dmam_release, sizeof(*dr), gfp);
-	if (!dr)
-		return NULL;
-
-	vaddr = dma_alloc_coherent(dev, size, dma_handle, gfp);
-	if (!vaddr) {
-		devres_free(dr);
-		return NULL;
-	}
-
-	dr->vaddr = vaddr;
-	dr->dma_handle = *dma_handle;
-	dr->size = size;
-
-	devres_add(dev, dr);
-
-	return vaddr;
-}
-EXPORT_SYMBOL(dmam_alloc_coherent);
-
 /**
  * dmam_free_coherent - Managed dma_free_coherent()
  * @dev: Device to free coherent memory for
-- 
2.19.2
