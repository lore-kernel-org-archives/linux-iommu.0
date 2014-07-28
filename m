From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v3 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 28 Jul 2014 11:38:51 -0700
Message-ID: <1406572731-6216-2-git-send-email-ohaugan@codeaurora.org>
References: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Mapping and unmapping are more often than not in the critical path.
map_sg and unmap_sg allows IOMMU driver implementations to optimize
the process of mapping and unmapping buffers into the IOMMU page tables.

Instead of mapping a buffer one page at a time and requiring potentially
expensive TLB operations for each page, this function allows the driver
to map all pages in one go and defer TLB maintenance until after all
pages have been mapped.

Additionally, the mapping operation would be faster in general since
clients does not have to keep calling map API over and over again for
each physically contiguous chunk of memory that needs to be mapped to a
virtually contiguous region.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1698360..cd65511 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1088,6 +1088,54 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
+int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			struct scatterlist *sg, unsigned int nents,
+			int prot, unsigned long flags)
+{
+	int ret = 0;
+	unsigned long offset = 0;
+
+	BUG_ON(iova & (~PAGE_MASK));
+
+	if (unlikely(domain->ops->map_sg == NULL)) {
+		unsigned int i;
+		struct scatterlist *s;
+
+		for_each_sg(sg, s, nents, i) {
+			phys_addr_t phys = page_to_phys(sg_page(s));
+			u32 page_len = PAGE_ALIGN(s->offset + s->length);
+
+			ret = iommu_map(domain, iova + offset, phys, page_len,
+					prot);
+			if (ret)
+				goto fail;
+
+			offset += page_len;
+		}
+	} else {
+		ret = domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
+	}
+	goto out;
+
+fail:
+	/* undo mappings already done in case of error */
+	iommu_unmap(domain, iova, offset);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_sg);
+
+int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
+			size_t size, unsigned long flags)
+{
+	BUG_ON(iova & (~PAGE_MASK));
+
+	if (unlikely(domain->ops->unmap_sg == NULL))
+		return iommu_unmap(domain, iova, size);
+	else
+		return domain->ops->unmap_sg(domain, iova, size, flags);
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_sg);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..66ad543 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/types.h>
+#include <linux/scatterlist.h>
 #include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -93,6 +94,10 @@ enum iommu_attr {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @map_sg: map a scatter-gather list of physically contiguous memory chunks
+ * to an iommu domain
+ * @unmap_sg: unmap a scatter-gather list of physically contiguous memory
+ * chunks from an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @domain_has_cap: domain capabilities query
  * @add_device: add device to iommu grouping
@@ -110,6 +115,11 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
+	int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
+			struct scatterlist *sg, unsigned int nents, int prot,
+			unsigned long flags);
+	int (*unmap_sg)(struct iommu_domain *domain, unsigned long iova,
+			size_t size, unsigned long flags);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
@@ -153,6 +163,11 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
+extern int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			struct scatterlist *sg, unsigned int nents, int prot,
+			unsigned long flags);
+extern int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
+				size_t size, unsigned long flags);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
@@ -287,6 +302,19 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			struct scatterlist *sg, unsigned int nents, int prot,
+			unsigned long flags)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unmap_sg(struct iommu_domain *domain,
+			unsigned long iova, size_t size, unsigned long flags)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
 					     u64 size, int prot)
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
