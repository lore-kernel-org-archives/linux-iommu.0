From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Mon, 30 Jun 2014 09:51:51 -0700
Message-ID: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, joro@8bytes.org, vgandhi@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
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
 drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
 include/linux/iommu.h | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fc..f2a6b80 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -898,6 +898,30 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
 
+int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
+		    struct scatterlist *sg, unsigned int len, int prot)
+{
+	if (unlikely(domain->ops->map_range == NULL))
+		return -ENODEV;
+
+	BUG_ON(iova & (~PAGE_MASK));
+
+	return domain->ops->map_range(domain, iova, sg, len, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_map_range);
+
+int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len)
+{
+	if (unlikely(domain->ops->unmap_range == NULL))
+		return -ENODEV;
+
+	BUG_ON(iova & (~PAGE_MASK));
+
+	return domain->ops->unmap_range(domain, iova, len);
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_range);
+
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b96a5b2..63dca6d 100644
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
+		    struct scatterlist *sg, unsigned int len, int prot);
+	int (*unmap_range)(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
@@ -153,6 +160,10 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
+extern int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
+		    struct scatterlist *sg, unsigned int len, int prot);
+extern int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
+		      unsigned int len);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
@@ -280,6 +291,19 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_range(struct iommu_domain *domain,
+				  unsigned int iova, struct scatterlist *sg,
+				  unsigned int len, int prot)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unmap_range(struct iommu_domain *domain,
+				    unsigned int iova, unsigned int len)
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
