From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v3 4/6] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
Date: Tue, 19 Jul 2016 13:36:53 -0700
Message-ID: <20160719203655.16629-5-mitchelh@codeaurora.org>
References: <20160719203655.16629-1-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160719203655.16629-1-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Patrick Daly <pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thomas Zeng <tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
are only accessible to privileged DMA engines.  Implement it in
dma-iommu.c so that the ARM64 DMA IOMMU mapper can make use of it.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

Notes:
    v2..v3
    
      - Renamed and redocumented dma_direction_to_prot.
      - Dropped the stuff making all privileged mappings read-only.

 arch/arm64/mm/dma-mapping.c |  6 +++---
 drivers/iommu/dma-iommu.c   | 16 +++++++++++-----
 include/linux/dma-iommu.h   |  3 ++-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c566ec83719f..5da8946ead9e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -543,7 +543,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 struct dma_attrs *attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
-	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
 	void *addr;
 
@@ -697,7 +697,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   struct dma_attrs *attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
-	int prot = dma_direction_to_prot(dir, coherent);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
 	if (!iommu_dma_mapping_error(dev, dev_addr) &&
@@ -755,7 +755,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
 
 	return iommu_dma_map_sg(dev, sgl, nelems,
-			dma_direction_to_prot(dir, coherent));
+				dma_info_to_prot(dir, coherent, attrs));
 }
 
 static void __iommu_unmap_sg_attrs(struct device *dev,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..cc2c9cccde1f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -129,26 +129,32 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 EXPORT_SYMBOL(iommu_dma_init_domain);
 
 /**
- * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags
+ * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
+ *                    page flags.
  * @dir: Direction of DMA transfer
  * @coherent: Is the DMA master cache-coherent?
+ * @attrs: DMA attributes for the mapping
  *
  * Return: corresponding IOMMU API page protection flags
  */
-int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
+int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
+		     struct dma_attrs *attrs)
 {
 	int prot = coherent ? IOMMU_CACHE : 0;
 
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
-		return prot | IOMMU_READ | IOMMU_WRITE;
+		prot |= IOMMU_READ | IOMMU_WRITE;
 	case DMA_TO_DEVICE:
-		return prot | IOMMU_READ;
+		prot |= IOMMU_READ;
 	case DMA_FROM_DEVICE:
-		return prot | IOMMU_WRITE;
+		prot |= IOMMU_WRITE;
 	default:
 		return 0;
 	}
+	if (dma_get_attr(DMA_ATTR_PRIVILEGED, attrs))
+		prot |= IOMMU_PRIV;
+	return prot;
 }
 
 static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8443bbb5c071..b0dbcff2d73e 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -32,7 +32,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size);
 
 /* General helpers for DMA-API <-> IOMMU-API interaction */
-int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
+int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
+		     struct dma_attrs *attrs);
 
 /*
  * These implement the bulk of the relevant DMA mapping callbacks, but require
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
