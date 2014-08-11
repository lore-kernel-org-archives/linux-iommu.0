From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 11 Aug 2014 15:45:50 -0700
Message-ID: <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org, laurent.pinchart+renesas@ideasonboard.com, robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, kgene.kim@samsung.com, dwmw2@infradead.org, hdoyu@nvidia.com, Varun.Sethi@freescale.com, konrad.wilk@oracle.com, s-anna@ti.com
Cc: mitchelh@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Olav Haugan <ohaugan@codeaurora.org>
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
 drivers/iommu/amd_iommu.c      |  2 ++
 drivers/iommu/arm-smmu.c       |  2 ++
 drivers/iommu/exynos-iommu.c   |  2 ++
 drivers/iommu/intel-iommu.c    |  2 ++
 drivers/iommu/iommu.c          | 33 +++++++++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c     |  2 ++
 drivers/iommu/msm_iommu.c      |  2 ++
 drivers/iommu/omap-iommu.c     |  2 ++
 drivers/iommu/shmobile-iommu.c |  2 ++
 drivers/iommu/tegra-smmu.c     |  2 ++
 include/linux/iommu.h          | 44 ++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 95 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1840531..3604f3c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3402,6 +3402,8 @@ static const struct iommu_ops amd_iommu_ops = {
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
 	.unmap = amd_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.unmap_sg = default_iommu_unmap_sg,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.domain_has_cap = amd_iommu_domain_has_cap,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d..231e006 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1604,6 +1604,8 @@ static const struct iommu_ops arm_smmu_ops = {
 	.detach_dev	= arm_smmu_detach_dev,
 	.map		= arm_smmu_map,
 	.unmap		= arm_smmu_unmap,
+	.map_sg		= default_iommu_map_sg,
+	.unmap_sg	= default_iommu_unmap_sg,
 	.iova_to_phys	= arm_smmu_iova_to_phys,
 	.domain_has_cap	= arm_smmu_domain_has_cap,
 	.add_device	= arm_smmu_add_device,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d037e87..8876508 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1177,6 +1177,8 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.detach_dev = exynos_iommu_detach_device,
 	.map = exynos_iommu_map,
 	.unmap = exynos_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.unmap_sg = default_iommu_unmap_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.add_device = exynos_iommu_add_device,
 	.remove_device = exynos_iommu_remove_device,
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d1f5caa..4fc61ff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4462,6 +4462,8 @@ static const struct iommu_ops intel_iommu_ops = {
 	.detach_dev	= intel_iommu_detach_device,
 	.map		= intel_iommu_map,
 	.unmap		= intel_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
+	.unmap_sg	= default_iommu_unmap_sg,
 	.iova_to_phys	= intel_iommu_iova_to_phys,
 	.domain_has_cap = intel_iommu_domain_has_cap,
 	.add_device	= intel_iommu_add_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1698360..24cf727 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1088,6 +1088,39 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
+int default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			 struct scatterlist *sg, unsigned int nents,
+			 int prot, unsigned long flags)
+{
+	int ret = 0;
+	unsigned long offset = 0;
+	unsigned int i;
+	struct scatterlist *s;
+
+	for_each_sg(sg, s, nents, i) {
+		phys_addr_t phys = page_to_phys(sg_page(s));
+		size_t page_len = s->offset + s->length;
+
+		ret = iommu_map(domain, iova + offset, phys, page_len,
+				prot);
+		if (ret) {
+			/* undo mappings already done */
+			iommu_unmap(domain, iova, offset);
+			break;
+		}
+		offset += page_len;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(default_iommu_map_sg);
+
+int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, unsigned long flags)
+{
+	return iommu_unmap(domain, iova, size);
+}
+EXPORT_SYMBOL_GPL(default_iommu_unmap_sg);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7dab5cb..1dc6f94 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1127,6 +1127,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
 	.unmap = ipmmu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.unmap_sg = default_iommu_unmap_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 49f41d6..2b3c8d3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -681,6 +681,8 @@ static const struct iommu_ops msm_iommu_ops = {
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
 	.unmap = msm_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.unmap_sg = default_iommu_unmap_sg,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.domain_has_cap = msm_iommu_domain_has_cap,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e202b0c..7d4c920 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1285,6 +1285,8 @@ static const struct iommu_ops omap_iommu_ops = {
 	.detach_dev	= omap_iommu_detach_dev,
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
+	.unmap_sg	= default_iommu_unmap_sg,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index 1333e6fb..3510f70 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -361,6 +361,8 @@ static const struct iommu_ops shmobile_iommu_ops = {
 	.detach_dev = shmobile_iommu_detach_device,
 	.map = shmobile_iommu_map,
 	.unmap = shmobile_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.unmap_sg = default_iommu_unmap_sg,
 	.iova_to_phys = shmobile_iommu_iova_to_phys,
 	.add_device = shmobile_iommu_add_device,
 	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 792da5e..ebd847b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -954,6 +954,8 @@ static const struct iommu_ops smmu_iommu_ops = {
 	.detach_dev	= smmu_iommu_detach_dev,
 	.map		= smmu_iommu_map,
 	.unmap		= smmu_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
+	.unmap_sg	= default_iommu_unmap_sg,
 	.iova_to_phys	= smmu_iommu_iova_to_phys,
 	.domain_has_cap	= smmu_iommu_domain_has_cap,
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..ee106ce 100644
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
@@ -153,6 +163,12 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
+extern int default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+				struct scatterlist *sg,unsigned int nents,
+				int prot, unsigned long flags);
+extern int default_iommu_unmap_sg(struct iommu_domain *domain,
+				  unsigned long iova, size_t size,
+				  unsigned long flags);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
@@ -240,6 +256,20 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 	return ret;
 }
 
+static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			       struct scatterlist *sg, unsigned int nents,
+			       int prot, unsigned long flags)
+{
+	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
+}
+
+static inline int iommu_unmap_sg(struct iommu_domain *domain,
+				 unsigned long iova, size_t size,
+				 unsigned long flags)
+{
+	return domain->ops->unmap_sg(domain, iova, size, flags);
+}
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -287,6 +317,20 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			       struct scatterlist *sg, unsigned int nents,
+			       int prot, unsigned long flags)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unmap_sg(struct iommu_domain *domain,
+				 unsigned long iova, size_t size,
+				 unsigned long flags)
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
