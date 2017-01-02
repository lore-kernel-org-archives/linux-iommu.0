From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V8 5/9] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
Date: Mon,  2 Jan 2017 18:42:40 +0530
Message-ID: <1483362764-11990-6-git-send-email-sricharan@codeaurora.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483362764-11990-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
are only accessible to privileged DMA engines.  Implement it in
dma-iommu.c so that the ARM64 DMA IOMMU mapper can make use of it.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c |  6 +++---
 drivers/iommu/dma-iommu.c   | 12 +++++++++---
 include/linux/dma-iommu.h   |  3 ++-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 290a84f..49c6f75 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -557,7 +557,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
-	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
 	void *addr;
 
@@ -711,7 +711,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
-	int prot = dma_direction_to_prot(dir, coherent);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
 	if (!iommu_dma_mapping_error(dev, dev_addr) &&
@@ -769,7 +769,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
 
 	return iommu_dma_map_sg(dev, sgl, nelems,
-			dma_direction_to_prot(dir, coherent));
+				dma_info_to_prot(dir, coherent, attrs));
 }
 
 static void __iommu_unmap_sg_attrs(struct device *dev,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2db0d64..3006eee 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -181,16 +181,22 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
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
+		     unsigned long attrs)
 {
 	int prot = coherent ? IOMMU_CACHE : 0;
 
+	if (attrs & DMA_ATTR_PRIVILEGED)
+		prot |= IOMMU_PRIV;
+
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 		return prot | IOMMU_READ | IOMMU_WRITE;
@@ -633,7 +639,7 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_direction_to_prot(dir, false) | IOMMU_MMIO);
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
 }
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 7f7e9a7..c5511e1 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -34,7 +34,8 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev);
 
 /* General helpers for DMA-API <-> IOMMU-API interaction */
-int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
+int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
+		     unsigned long attrs);
 
 /*
  * These implement the bulk of the relevant DMA mapping callbacks, but require
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
