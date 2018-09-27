From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/5] dma-direct: add an explicit dma_direct_get_required_mask
Date: Thu, 27 Sep 2018 15:35:36 -0700
Message-ID: <20180927223539.28449-3-hch@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180927223539.28449-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is somewhat modelled after the powerpc version, and differs from
the legacy fallback in use fls64 instead of pointlessly splitting up the
address into low and high dwords and in that it takes (__)phys_to_dma
into account.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 86a59ba5a7f3..b79496d8c75b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -55,6 +55,7 @@ static inline void dma_mark_clean(void *addr, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
 
+u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c954f0a6dc62..f32b33cfa331 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,6 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
+#include <linux/bootmem.h> /* for max_pfn */
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
@@ -53,11 +54,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static inline dma_addr_t phys_to_dma_direct(struct device *dev,
+		phys_addr_t phys)
+{
+	if (force_dma_unencrypted())
+		return __phys_to_dma(dev, phys);
+	return phys_to_dma(dev, phys);
+}
+
+u64 dma_direct_get_required_mask(struct device *dev)
+{
+	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+
+	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+}
+
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t addr = force_dma_unencrypted() ?
-		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
-	return addr + size - 1 <= dev->coherent_dma_mask;
+	return phys_to_dma_direct(dev, phys) + size - 1 <=
+			dev->coherent_dma_mask;
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -296,6 +311,7 @@ const struct dma_map_ops dma_direct_ops = {
 	.unmap_page		= dma_direct_unmap_page,
 	.unmap_sg		= dma_direct_unmap_sg,
 #endif
+	.get_required_mask	= dma_direct_get_required_mask,
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
-- 
2.19.0
