From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v6 1/1] iommu-api: Add map_sg function
Date: Sat, 25 Oct 2014 09:55:16 -0700
Message-ID: <1414256116-26933-2-git-send-email-ohaugan@codeaurora.org>
References: <1414256116-26933-1-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414256116-26933-1-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, s-anna-l0cyMroinI0@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Mapping and unmapping are more often than not in the critical path.
map_sg allows IOMMU driver implementations to optimize the process
of mapping buffers into the IOMMU page tables.

Instead of mapping a buffer one page at a time and requiring potentially
expensive TLB operations for each page, this function allows the driver
to map all pages in one go and defer TLB maintenance until after all
pages have been mapped.

Additionally, the mapping operation would be faster in general since
clients does not have to keep calling map API over and over again for
each physically contiguous chunk of memory that needs to be mapped to a
virtually contiguous region.

Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |  1 +
 drivers/iommu/arm-smmu.c       |  1 +
 drivers/iommu/exynos-iommu.c   |  1 +
 drivers/iommu/intel-iommu.c    |  1 +
 drivers/iommu/iommu.c          | 25 +++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c     |  1 +
 drivers/iommu/msm_iommu.c      |  1 +
 drivers/iommu/omap-iommu.c     |  1 +
 drivers/iommu/shmobile-iommu.c |  1 +
 drivers/iommu/tegra-smmu.c     |  1 +
 include/linux/iommu.h          | 22 ++++++++++++++++++++++
 11 files changed, 56 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 505a9ad..2d84c9e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3424,6 +3424,7 @@ static const struct iommu_ops amd_iommu_ops = {
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
 	.unmap = amd_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f7..e393ae0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1652,6 +1652,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.detach_dev	= arm_smmu_detach_dev,
 	.map		= arm_smmu_map,
 	.unmap		= arm_smmu_unmap,
+	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= arm_smmu_iova_to_phys,
 	.add_device	= arm_smmu_add_device,
 	.remove_device	= arm_smmu_remove_device,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7423318..28372b8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1178,6 +1178,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.detach_dev = exynos_iommu_detach_device,
 	.map = exynos_iommu_map,
 	.unmap = exynos_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.add_device = exynos_iommu_add_device,
 	.remove_device = exynos_iommu_remove_device,
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a27d6cb..02cd26a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4467,6 +4467,7 @@ static const struct iommu_ops intel_iommu_ops = {
 	.detach_dev	= intel_iommu_detach_device,
 	.map		= intel_iommu_map,
 	.unmap		= intel_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= intel_iommu_iova_to_phys,
 	.add_device	= intel_iommu_add_device,
 	.remove_device	= intel_iommu_remove_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed8b048..46727ce 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1124,6 +1124,31 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
+size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			 struct scatterlist *sg, unsigned int nents, int prot)
+{
+	int ret;
+	size_t mapped = 0;
+	unsigned int i;
+	struct scatterlist *s;
+
+	for_each_sg(sg, s, nents, i) {
+		phys_addr_t phys = page_to_phys(sg_page(s));
+		size_t page_len = s->offset + s->length;
+
+		ret = iommu_map(domain, iova + mapped, phys, page_len, prot);
+		if (ret) {
+			/* undo mappings already done */
+			iommu_unmap(domain, iova, mapped);
+			mapped = 0;
+			break;
+		}
+		mapped += page_len;
+	}
+
+	return mapped;
+}
+EXPORT_SYMBOL_GPL(default_iommu_map_sg);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7dab5cb..e509c58 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1127,6 +1127,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
 	.unmap = ipmmu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6e3dcc28..1c7b78e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -681,6 +681,7 @@ static const struct iommu_ops msm_iommu_ops = {
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
 	.unmap = msm_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 };
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3627887..18003c04 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1288,6 +1288,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.detach_dev	= omap_iommu_detach_dev,
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index 1333e6fb..f1b0077 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -361,6 +361,7 @@ static const struct iommu_ops shmobile_iommu_ops = {
 	.detach_dev = shmobile_iommu_detach_device,
 	.map = shmobile_iommu_map,
 	.unmap = shmobile_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = shmobile_iommu_iova_to_phys,
 	.add_device = shmobile_iommu_add_device,
 	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3afdf43..73e845a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -955,6 +955,7 @@ static const struct iommu_ops smmu_iommu_ops = {
 	.detach_dev	= smmu_iommu_detach_dev,
 	.map		= smmu_iommu_map,
 	.unmap		= smmu_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= smmu_iommu_iova_to_phys,
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
 };
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 379a617..a74e131 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/types.h>
+#include <linux/scatterlist.h>
 #include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -96,6 +97,8 @@ enum iommu_attr {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @map_sg: map a scatter-gather list of physically contiguous memory chunks
+ * to an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
@@ -113,6 +116,8 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
+	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
+			 struct scatterlist *sg, unsigned int nents, int prot);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
@@ -155,6 +160,9 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
+extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+				struct scatterlist *sg,unsigned int nents,
+				int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -240,6 +248,13 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 	return ret;
 }
 
+static inline size_t iommu_map_sg(struct iommu_domain *domain,
+				  unsigned long iova, struct scatterlist *sg,
+				  unsigned int nents, int prot)
+{
+	return domain->ops->map_sg(domain, iova, sg, nents, prot);
+}
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -292,6 +307,13 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline size_t iommu_map_sg(struct iommu_domain *domain,
+				  unsigned long iova, struct scatterlist *sg,
+				  unsigned int nents, int prot)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
 					     u64 size, int prot)
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
