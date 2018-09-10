From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 5/5] dma-mapping: support non-coherent devices in
	dma_common_get_sgtable
Date: Mon, 10 Sep 2018 08:05:33 +0200
Message-ID: <20180910060533.27172-6-hch@lst.de>
References: <20180910060533.27172-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180910060533.27172-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We can use the arch_dma_coherent_to_pfn hook to provide a ->get_sgtable
implementation.  Note that this isn't an endorsement of this interface
(which is a horrible bad idea), but it is required to move arm64 over
to the generic code without a loss of functionality.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/xen/swiotlb-xen.c   |  2 +-
 include/linux/dma-mapping.h |  7 ++++---
 kernel/dma/mapping.c        | 23 ++++++++++++++++-------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 470757ddddea..28819a0e61d0 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -689,7 +689,7 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 							   handle, size, attrs);
 	}
 #endif
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
 }
 
 static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c3378d4e0d57..bd81e74cca7b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -483,8 +483,8 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
 int
-dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		       void *cpu_addr, dma_addr_t dma_addr, size_t size);
+dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
+		dma_addr_t dma_addr, size_t size, unsigned long attrs);
 
 static inline int
 dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
@@ -496,7 +496,8 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 	if (ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
+			attrs);
 }
 
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 42fd73aca305..58dec7a92b7b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -202,17 +202,26 @@ EXPORT_SYMBOL(dmam_release_declared_memory);
  * Create scatter-list for the already allocated DMA buffer.
  */
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t handle, size_t size)
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 unsigned long attrs)
 {
-	struct page *page = virt_to_page(cpu_addr);
+	struct page *page;
 	int ret;
 
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (unlikely(ret))
-		return ret;
+	if (!dev_is_dma_coherent(dev)) {
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
+			return -ENXIO;
 
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return 0;
+		page = pfn_to_page(arch_dma_coherent_to_pfn(dev, cpu_addr,
+				dma_addr));
+	} else {
+		page = virt_to_page(cpu_addr);
+	}
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
 }
 EXPORT_SYMBOL(dma_common_get_sgtable);
 
-- 
2.18.0
