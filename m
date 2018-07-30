From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] iommu: remove the ->map_sg indirection
Date: Mon, 30 Jul 2018 09:36:26 +0200
Message-ID: <20180730073626.15880-1-hch@lst.de>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

All iommu drivers use the default_iommu_map_sg implementation, and there
is no good reason to ever override it.  Just expose it as iommu_map_sg
directly and remove the indirection, specially in our post-spectre world
where indirect calls are horribly expensive.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/amd_iommu.c      |  1 -
 drivers/iommu/arm-smmu-v3.c    |  1 -
 drivers/iommu/arm-smmu.c       |  1 -
 drivers/iommu/exynos-iommu.c   |  1 -
 drivers/iommu/intel-iommu.c    |  1 -
 drivers/iommu/iommu.c          |  6 +++---
 drivers/iommu/ipmmu-vmsa.c     |  1 -
 drivers/iommu/msm_iommu.c      |  1 -
 drivers/iommu/mtk_iommu.c      |  1 -
 drivers/iommu/mtk_iommu_v1.c   |  1 -
 drivers/iommu/omap-iommu.c     |  1 -
 drivers/iommu/qcom_iommu.c     |  1 -
 drivers/iommu/rockchip-iommu.c |  1 -
 drivers/iommu/tegra-gart.c     |  1 -
 drivers/iommu/tegra-smmu.c     |  1 -
 include/linux/iommu.h          | 16 ++--------------
 16 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c50051..a23c6a4014a5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3192,7 +3192,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
 	.unmap = amd_iommu_unmap,
-	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.add_device = amd_iommu_add_device,
 	.remove_device = amd_iommu_remove_device,
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..f1dc294f8e08 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1997,7 +1997,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-	.map_sg			= default_iommu_map_sg,
 	.flush_iotlb_all	= arm_smmu_iotlb_sync,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..644fd7ec8ac7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1562,7 +1562,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-	.map_sg			= default_iommu_map_sg,
 	.flush_iotlb_all	= arm_smmu_iotlb_sync,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 85879cfec52f..19e55cf6a9dd 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1332,7 +1332,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.detach_dev = exynos_iommu_detach_device,
 	.map = exynos_iommu_map,
 	.unmap = exynos_iommu_unmap,
-	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.device_group = generic_device_group,
 	.add_device = exynos_iommu_add_device,
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 115ff26e9ced..6bfa3bd5a174 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5366,7 +5366,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.detach_dev		= intel_iommu_detach_device,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
-	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..edf1a19c5755 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1637,8 +1637,8 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot)
+size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		    struct scatterlist *sg, unsigned int nents, int prot)
 {
 	struct scatterlist *s;
 	size_t mapped = 0;
@@ -1678,7 +1678,7 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 
 }
-EXPORT_SYMBOL_GPL(default_iommu_map_sg);
+EXPORT_SYMBOL_GPL(iommu_map_sg);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e87cb88..c9ce27cfa7e8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -889,7 +889,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.unmap = ipmmu_unmap,
 	.flush_iotlb_all = ipmmu_iotlb_sync,
 	.iotlb_sync = ipmmu_iotlb_sync,
-	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0d3350463a3f..cdf6ab22ede9 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -708,7 +708,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.detach_dev = msm_iommu_detach_dev,
 	.map = msm_iommu_map,
 	.unmap = msm_iommu_unmap,
-	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.add_device = msm_iommu_add_device,
 	.remove_device = msm_iommu_remove_device,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f2832a10fcea..f9f69f7111a9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -495,7 +495,6 @@ static struct iommu_ops mtk_iommu_ops = {
 	.detach_dev	= mtk_iommu_detach_device,
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
 	.flush_iotlb_all = mtk_iommu_iotlb_sync,
 	.iotlb_sync	= mtk_iommu_iotlb_sync,
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a7c2a973784f..676c029494e4 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -531,7 +531,6 @@ static struct iommu_ops mtk_iommu_ops = {
 	.detach_dev	= mtk_iommu_detach_device,
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
 	.remove_device	= mtk_iommu_remove_device,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index af4a8e7fcd27..86d64ff507fa 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1548,7 +1548,6 @@ static const struct iommu_ops omap_iommu_ops = {
 	.detach_dev	= omap_iommu_detach_dev,
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index fe88a4880d3a..6e914b3a2b4b 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -590,7 +590,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.detach_dev	= qcom_iommu_detach_dev,
 	.map		= qcom_iommu_map,
 	.unmap		= qcom_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
 	.flush_iotlb_all = qcom_iommu_iotlb_sync,
 	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..90625cdd3b66 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1110,7 +1110,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.detach_dev = rk_iommu_detach_device,
 	.map = rk_iommu_map,
 	.unmap = rk_iommu_unmap,
-	.map_sg = default_iommu_map_sg,
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a004f6da35f2..7b1361d57a17 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -377,7 +377,6 @@ static const struct iommu_ops gart_iommu_ops = {
 	.remove_device	= gart_iommu_remove_device,
 	.device_group	= generic_device_group,
 	.map		= gart_iommu_map,
-	.map_sg		= default_iommu_map_sg,
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 44d40bc771b5..0d03341317c4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -876,7 +876,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.device_group = tegra_smmu_device_group,
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
-	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..9d56b16805e5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -166,8 +166,6 @@ struct iommu_resv_region {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @map_sg: map a scatter-gather list of physically contiguous memory chunks
- *          to an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
  * @tlb_range_add: Add a given iova range to the flush queue for this domain
  * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
@@ -201,8 +199,6 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
-	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
@@ -303,9 +299,8 @@ extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
-extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-				struct scatterlist *sg,unsigned int nents,
-				int prot);
+extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			   struct scatterlist *sg,unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -378,13 +373,6 @@ static inline void iommu_tlb_sync(struct iommu_domain *domain)
 		domain->ops->iotlb_sync(domain);
 }
 
-static inline size_t iommu_map_sg(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot)
-{
-	return domain->ops->map_sg(domain, iova, sg, nents, prot);
-}
-
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
-- 
2.18.0
