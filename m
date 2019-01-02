From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 5/5] dma-mapping: remove a few unused exports
Date: Wed,  2 Jan 2019 09:33:19 +0100
Message-ID: <20190102083319.12374-6-hch@lst.de>
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

Now that the slow path DMA API calls are implemented out of line a few
helpers only used by them don't need to be exported anymore.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 kernel/dma/coherent.c | 2 --
 kernel/dma/debug.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 597d40893862..66f0fb7e9a3a 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -223,7 +223,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	 */
 	return mem->flags & DMA_MEMORY_EXCLUSIVE;
 }
-EXPORT_SYMBOL(dma_alloc_from_dev_coherent);
 
 void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
 {
@@ -268,7 +267,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
-EXPORT_SYMBOL(dma_release_from_dev_coherent);
 
 int dma_release_from_global_coherent(int order, void *vaddr)
 {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1e0157113d15..23cf5361bcf1 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1512,7 +1512,6 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 
 	add_dma_entry(entry);
 }
-EXPORT_SYMBOL(debug_dma_alloc_coherent);
 
 void debug_dma_free_coherent(struct device *dev, size_t size,
 			 void *virt, dma_addr_t addr)
@@ -1540,7 +1539,6 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 
 	check_unmap(&ref);
 }
-EXPORT_SYMBOL(debug_dma_free_coherent);
 
 void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 			    int direction, dma_addr_t dma_addr)
-- 
2.19.2
