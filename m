From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC] iommu: Move over to unsigned int domain type
Date: Wed, 17 May 2017 19:29:12 +0900
Message-ID: <149501695257.25282.12037681018061688033.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Checkpatch dislikes the type unsigned, so update the iommu
domain type and consumers to use unsigned int to reduce noise.

$ ./scripts/checkpatch.pl ../linux-v4.13-pre-drivers-iommu-ipmmu-dma-ops-20170517b.patch
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#89: FILE: drivers/iommu/ipmmu-vmsa.c:720:
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#111: FILE: drivers/iommu/ipmmu-vmsa.c:844:
+static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Untested for now.

 drivers/iommu/amd_iommu.c       |    2 +-
 drivers/iommu/arm-smmu-v3.c     |    2 +-
 drivers/iommu/arm-smmu.c        |    2 +-
 drivers/iommu/exynos-iommu.c    |    2 +-
 drivers/iommu/fsl_pamu_domain.c |    2 +-
 drivers/iommu/intel-iommu.c     |    2 +-
 drivers/iommu/iommu.c           |    4 ++--
 drivers/iommu/ipmmu-vmsa.c      |    2 +-
 drivers/iommu/msm_iommu.c       |    2 +-
 drivers/iommu/mtk_iommu.c       |    2 +-
 drivers/iommu/mtk_iommu_v1.c    |    2 +-
 drivers/iommu/omap-iommu.c      |    2 +-
 drivers/iommu/rockchip-iommu.c  |    2 +-
 drivers/iommu/s390-iommu.c      |    2 +-
 drivers/iommu/tegra-gart.c      |    2 +-
 drivers/iommu/tegra-smmu.c      |    2 +-
 include/linux/iommu.h           |    4 ++--
 17 files changed, 19 insertions(+), 19 deletions(-)

--- 0001/drivers/iommu/amd_iommu.c
+++ work/drivers/iommu/amd_iommu.c	2017-05-17 19:19:00.810607110 +0900
@@ -2940,7 +2940,7 @@ out_err:
 	return NULL;
 }
 
-static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 {
 	struct protection_domain *pdomain;
 	struct dma_ops_domain *dma_domain;
--- 0001/drivers/iommu/arm-smmu-v3.c
+++ work/drivers/iommu/arm-smmu-v3.c	2017-05-17 19:17:18.300607110 +0900
@@ -1381,7 +1381,7 @@ static bool arm_smmu_capable(enum iommu_
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc(unsigned int type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
--- 0001/drivers/iommu/arm-smmu.c
+++ work/drivers/iommu/arm-smmu.c	2017-05-17 19:17:35.410607110 +0900
@@ -1078,7 +1078,7 @@ static void arm_smmu_destroy_domain_cont
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc(unsigned int type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
--- 0001/drivers/iommu/exynos-iommu.c
+++ work/drivers/iommu/exynos-iommu.c	2017-05-17 19:15:55.760607110 +0900
@@ -730,7 +730,7 @@ static inline void update_pte(sysmmu_pte
 				   DMA_TO_DEVICE);
 }
 
-static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *exynos_iommu_domain_alloc(unsigned int type)
 {
 	struct exynos_iommu_domain *domain;
 	dma_addr_t handle;
--- 0001/drivers/iommu/fsl_pamu_domain.c
+++ work/drivers/iommu/fsl_pamu_domain.c	2017-05-17 19:15:19.190607110 +0900
@@ -416,7 +416,7 @@ static void fsl_pamu_domain_free(struct
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
-static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
+static struct iommu_domain *fsl_pamu_domain_alloc(unsigned int type)
 {
 	struct fsl_dma_domain *dma_domain;
 
--- 0001/drivers/iommu/intel-iommu.c
+++ work/drivers/iommu/intel-iommu.c	2017-05-17 19:14:56.520607110 +0900
@@ -5021,7 +5021,7 @@ static int md_domain_init(struct dmar_do
 	return 0;
 }
 
-static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *intel_iommu_domain_alloc(unsigned int type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
--- 0001/drivers/iommu/iommu.c
+++ work/drivers/iommu/iommu.c	2017-05-17 19:20:48.720607110 +0900
@@ -105,7 +105,7 @@ void iommu_device_unregister(struct iomm
 }
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
-						 unsigned type);
+						 unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -1255,7 +1255,7 @@ void iommu_set_fault_handler(struct iomm
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
-						 unsigned type)
+						 unsigned int type)
 {
 	struct iommu_domain *domain;
 
--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-05-17 19:13:42.310607110 +0900
@@ -455,7 +455,7 @@ static irqreturn_t ipmmu_irq(int irq, vo
  * IOMMU Operations
  */
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+static struct iommu_domain *ipmmu_domain_alloc(unsigned int type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
--- 0001/drivers/iommu/msm_iommu.c
+++ work/drivers/iommu/msm_iommu.c	2017-05-17 19:13:25.990607110 +0900
@@ -312,7 +312,7 @@ static void __program_context(void __iom
 	SET_M(base, ctx, 1);
 }
 
-static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *msm_iommu_domain_alloc(unsigned int type)
 {
 	struct msm_priv *priv;
 
--- 0001/drivers/iommu/mtk_iommu.c
+++ work/drivers/iommu/mtk_iommu.c	2017-05-17 19:13:11.170607110 +0900
@@ -249,7 +249,7 @@ static int mtk_iommu_domain_finalise(str
 	return 0;
 }
 
-static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *mtk_iommu_domain_alloc(unsigned int type)
 {
 	struct mtk_iommu_domain *dom;
 
--- 0001/drivers/iommu/mtk_iommu_v1.c
+++ work/drivers/iommu/mtk_iommu_v1.c	2017-05-17 19:12:57.140607110 +0900
@@ -243,7 +243,7 @@ static int mtk_iommu_domain_finalise(str
 	return 0;
 }
 
-static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *mtk_iommu_domain_alloc(unsigned int type)
 {
 	struct mtk_iommu_domain *dom;
 
--- 0001/drivers/iommu/omap-iommu.c
+++ work/drivers/iommu/omap-iommu.c	2017-05-17 19:12:38.240607110 +0900
@@ -1137,7 +1137,7 @@ static void omap_iommu_detach_dev(struct
 	spin_unlock(&omap_domain->lock);
 }
 
-static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *omap_iommu_domain_alloc(unsigned int type)
 {
 	struct omap_iommu_domain *omap_domain;
 
--- 0001/drivers/iommu/rockchip-iommu.c
+++ work/drivers/iommu/rockchip-iommu.c	2017-05-17 19:12:23.120607110 +0900
@@ -885,7 +885,7 @@ static void rk_iommu_detach_device(struc
 	dev_dbg(dev, "Detached from iommu domain\n");
 }
 
-static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *rk_iommu_domain_alloc(unsigned int type)
 {
 	struct rk_iommu_domain *rk_domain;
 	struct platform_device *pdev;
--- 0001/drivers/iommu/s390-iommu.c
+++ work/drivers/iommu/s390-iommu.c	2017-05-17 19:12:02.700607110 +0900
@@ -48,7 +48,7 @@ static bool s390_iommu_capable(enum iomm
 	}
 }
 
-static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
+static struct iommu_domain *s390_domain_alloc(unsigned int domain_type)
 {
 	struct s390_domain *s390_domain;
 
--- 0001/drivers/iommu/tegra-gart.c
+++ work/drivers/iommu/tegra-gart.c	2017-05-17 19:11:52.660607110 +0900
@@ -218,7 +218,7 @@ out:
 	spin_unlock(&gart->client_lock);
 }
 
-static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
+static struct iommu_domain *gart_iommu_domain_alloc(unsigned int type)
 {
 	struct gart_domain *gart_domain;
 	struct gart_device *gart;
--- 0001/drivers/iommu/tegra-smmu.c
+++ work/drivers/iommu/tegra-smmu.c	2017-05-17 19:11:40.240607110 +0900
@@ -258,7 +258,7 @@ static bool tegra_smmu_capable(enum iomm
 	return false;
 }
 
-static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *tegra_smmu_domain_alloc(unsigned int type)
 {
 	struct tegra_smmu_as *as;
 
--- 0001/include/linux/iommu.h
+++ work/include/linux/iommu.h	2017-05-17 19:11:00.790607110 +0900
@@ -87,7 +87,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API)
 
 struct iommu_domain {
-	unsigned type;
+	unsigned int type;
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
@@ -188,7 +188,7 @@ struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
 
 	/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc)(unsigned int iommu_domain_type);
 	void (*domain_free)(struct iommu_domain *);
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
