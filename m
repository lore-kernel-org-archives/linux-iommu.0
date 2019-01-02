From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/5] dma-mapping: remove dmam_{declare,
	release}_coherent_memory
Date: Wed,  2 Jan 2019 09:33:17 +0100
Message-ID: <20190102083319.12374-4-hch@lst.de>
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

These functions have never been used.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 Documentation/driver-model/devres.txt |  1 -
 include/linux/dma-mapping.h           | 19 ---------
 kernel/dma/mapping.c                  | 55 ---------------------------
 3 files changed, 75 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 841c99529d27..b277cafce71e 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -250,7 +250,6 @@ DMA
   dmaenginem_async_device_register()
   dmam_alloc_coherent()
   dmam_alloc_attrs()
-  dmam_declare_coherent_memory()
   dmam_free_coherent()
   dmam_pool_create()
   dmam_pool_destroy()
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index fa2ebe8ad4d0..937c2a949fca 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -691,25 +691,6 @@ static inline void dmam_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_handle) { }
 #endif /* !CONFIG_HAS_DMA */
 
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
-extern int dmam_declare_coherent_memory(struct device *dev,
-					phys_addr_t phys_addr,
-					dma_addr_t device_addr, size_t size,
-					int flags);
-extern void dmam_release_declared_memory(struct device *dev);
-#else /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
-static inline int dmam_declare_coherent_memory(struct device *dev,
-				phys_addr_t phys_addr, dma_addr_t device_addr,
-				size_t size, gfp_t gfp)
-{
-	return 0;
-}
-
-static inline void dmam_release_declared_memory(struct device *dev)
-{
-}
-#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
-
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f00544cda4e9..a11006b6d8e8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -105,61 +105,6 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 }
 EXPORT_SYMBOL(dmam_alloc_attrs);
 
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
-
-static void dmam_coherent_decl_release(struct device *dev, void *res)
-{
-	dma_release_declared_memory(dev);
-}
-
-/**
- * dmam_declare_coherent_memory - Managed dma_declare_coherent_memory()
- * @dev: Device to declare coherent memory for
- * @phys_addr: Physical address of coherent memory to be declared
- * @device_addr: Device address of coherent memory to be declared
- * @size: Size of coherent memory to be declared
- * @flags: Flags
- *
- * Managed dma_declare_coherent_memory().
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int dmam_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				 dma_addr_t device_addr, size_t size, int flags)
-{
-	void *res;
-	int rc;
-
-	res = devres_alloc(dmam_coherent_decl_release, 0, GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	rc = dma_declare_coherent_memory(dev, phys_addr, device_addr, size,
-					 flags);
-	if (!rc)
-		devres_add(dev, res);
-	else
-		devres_free(res);
-
-	return rc;
-}
-EXPORT_SYMBOL(dmam_declare_coherent_memory);
-
-/**
- * dmam_release_declared_memory - Managed dma_release_declared_memory().
- * @dev: Device to release declared coherent memory for
- *
- * Managed dmam_release_declared_memory().
- */
-void dmam_release_declared_memory(struct device *dev)
-{
-	WARN_ON(devres_destroy(dev, dmam_coherent_decl_release, NULL, NULL));
-}
-EXPORT_SYMBOL(dmam_release_declared_memory);
-
-#endif
-
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
-- 
2.19.2
