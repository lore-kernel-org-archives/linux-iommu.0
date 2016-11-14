From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
Date: Mon, 14 Nov 2016 12:16:26 +0000
Message-ID: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the new dma_{map,unmap}_resource() functions added to the DMA API
for the benefit of cases like slave DMA, add suitable implementations to
the arsenal of our generic layer. Since cache maintenance should not be
a concern, these can both be standalone callback implementations without
the need for arch code wrappers.

CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v4: Add the missed static qualifier (thanks Catalin)

 drivers/iommu/dma-iommu.c | 24 +++++++++++++++++++++---
 include/linux/dma-iommu.h |  4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab8667e6f2..2db0d641cf45 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -432,13 +432,12 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 	return ret;
 }
 
-dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, int prot)
+static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
+		size_t size, int prot)
 {
 	dma_addr_t dma_addr;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iova_domain *iovad = cookie_iovad(domain);
-	phys_addr_t phys = page_to_phys(page) + offset;
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
 	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev));
@@ -454,6 +453,12 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	return dma_addr + iova_off;
 }
 
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot)
+{
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
+}
+
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
@@ -624,6 +629,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
 }
 
+dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return __iommu_dma_map(dev, phys, size,
+			dma_direction_to_prot(dir, false) | IOMMU_MMIO);
+}
+
+void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
+}
+
 int iommu_dma_supported(struct device *dev, u64 mask)
 {
 	/*
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 32c589062bd9..7f7e9a7e3839 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -61,6 +61,10 @@ void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
-- 
2.10.2.dirty
