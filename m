From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Wed, 16 Jul 2014 18:01:57 -0700
Message-ID: <1405558917-7597-2-git-send-email-ohaugan@codeaurora.org>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org
Cc: robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Mapping and unmapping are more often than not in the critical path.
map_range and unmap_range allows SMMU driver implementations to optimize
the process of mapping and unmapping buffers into the SMMU page tables.
Instead of mapping one physical address, do TLB operation (expensive),
mapping, do TLB operation, mapping, do TLB operation the driver can map
a scatter-gatherlist of physically contiguous pages into one virtual
address space and then at the end do one TLB operation.

Additionally, the mapping operation would be faster in general since
clients does not have to keep calling map API over and over again for
each physically contiguous chunk of memory that needs to be mapped to a
virtually contiguous region.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 25 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1698360..a0eebb7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
 
+int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
+		    struct scatterlist *sg, unsigned int len, int opt)
+{
+	s32 ret = 0;
+	u32 offset = 0;
+	u32 start_iova = iova;
+
+	BUG_ON(iova & (~PAGE_MASK));
+
+	if (unlikely(domain->ops->map_range == NULL)) {
+		while (offset < len) {
+			phys_addr_t phys = page_to_phys(sg_page(sg));
+			u32 page_len = PAGE_ALIGN(sg->offset + sg->length);
+
+			ret = iommu_map(domain, iova, phys, page_len, opt);
+			if (ret)
+				goto fail;
+
+			iova += page_len;
+			offset += page_len;
+			if (offset < len)
+				sg = sg_next(sg);
+		}
+	} else {
+		ret = domain->ops->map_range(domain, iova, sg, len, opt);
+	}
+	goto out;
+
+fail:
+	/* undo mappings already done in case of error */
+	iommu_unmap(domain, start_iova, offset);
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_range);
+
+int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len, int opt)
+{
+	BUG_ON(iova & (~PAGE_MASK));
+
+	if (unlikely(domain->ops->unmap_range == NULL))
+		return iommu_unmap(domain, iova, len);
+	else
+		return domain->ops->unmap_range(domain, iova, len, opt);
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_range);
+
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c7097d7..54c836e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/types.h>
+#include <linux/scatterlist.h>
 #include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -93,6 +94,8 @@ enum iommu_attr {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @map_range: map a scatter-gather list of physically contiguous memory chunks to an iommu domain
+ * @unmap_range: unmap a scatter-gather list of physically contiguous memory chunks from an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @domain_has_cap: domain capabilities query
  * @add_device: add device to iommu grouping
@@ -110,6 +113,10 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
+	int (*map_range)(struct iommu_domain *domain, unsigned int iova,
+		    struct scatterlist *sg, unsigned int len, int opt);
+	int (*unmap_range)(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len, int opt);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
@@ -153,6 +160,10 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
+extern int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
+		    struct scatterlist *sg, unsigned int len, int opt);
+extern int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len, int opt);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
@@ -287,6 +298,20 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_range(struct iommu_domain *domain,
+				  unsigned int iova, struct scatterlist *sg,
+				  unsigned int len, int opt)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unmap_range(struct iommu_domain *domain,
+				    unsigned int iova,
+				    unsigned int len, int opt)
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
