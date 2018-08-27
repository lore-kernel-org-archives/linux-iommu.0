From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] dma-mapping: support non-coherent devices in dma_common_get_sgtable
Date: Mon, 27 Aug 2018 16:50:32 +0200
Message-ID: <20180827145032.9522-6-hch@lst.de>
References: <20180827145032.9522-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827145032.9522-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We can use the arch_dma_coherent_to_pfn hook to provide a ->get_sgtable
implementation.  Note that this isn't an endorsement of this interface
(which is a horrible bad idea), but it is required to move arm64 over
to the generic code without a loss of functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index ea39eafec873..5da76b8860f5 100644
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
index 9550c08ddab1..213322077374 100644
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
