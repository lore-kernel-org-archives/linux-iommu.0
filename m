From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 1/3] iommu: introduce IOMMU_DOMAIN_HYP domain type for
	hypervisor allocation
Date: Tue,  1 Jul 2014 17:10:15 +0100
Message-ID: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Some IOMMUs, such as the ARM SMMU, support two stages of translation.
The idea behind such a scheme is to allow a guest operating system to
use the IOMMU for DMA mappings in the first stage of translation, with
the hypervisor then installing mappings in the second stage to provide
isolation of the DMA to the physical range assigned to that virtual
machine.

In order to allow IOMMU domains to be allocated for second-stage
translation, this patch extends iommu_domain_alloc (and the associated
->domain_init callback on struct iommu) to take a type parameter
indicating the intended purpose for the domain. The only supported types
at present are IOMMU_DOMAIN_DMA (i.e. what we have at the moment) and
IOMMU_DOMAIN_HYP, which instructs the backend driver to allocate and
initialise a second-stage domain, if possible.

All IOMMU drivers are updated to take the new type parameter, but it is
ignored at present. All callers of iommu_domain_alloc are also updated
to pass IOMMU_DOMAIN_DMA as the type parameter, apart from
kvm_iommu_map_guest, which passes the new IOMMU_DOMAIN_HYP flag.

Finally, a new IOMMU capability, IOMMU_CAP_HYP_MAPPING, is added so that
it is possible to check whether or not a domain is able to make use of
nested translation.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---

Hi Joerg, Alex,

Initially I wanted to use iommu_attr for this, but the IOMMU_DOMAIN_HYP
flag is not something that can change dynamically and needs to be known
at domain initialisation time. We could pass iommu_attr to domain_alloc,
but that would interact strangely with the existing attrs.

I'm open to all suggestions!

Will

 arch/arm/mm/dma-mapping.c                |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c            |  2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c |  2 +-
 drivers/iommu/amd_iommu.c                |  2 +-
 drivers/iommu/amd_iommu_v2.c             |  2 +-
 drivers/iommu/arm-smmu.c                 |  2 +-
 drivers/iommu/exynos-iommu.c             |  2 +-
 drivers/iommu/fsl_pamu_domain.c          |  2 +-
 drivers/iommu/intel-iommu.c              |  2 +-
 drivers/iommu/iommu.c                    |  4 ++--
 drivers/iommu/ipmmu-vmsa.c               |  2 +-
 drivers/iommu/msm_iommu.c                |  2 +-
 drivers/iommu/omap-iommu.c               |  2 +-
 drivers/iommu/shmobile-iommu.c           |  2 +-
 drivers/iommu/tegra-gart.c               |  2 +-
 drivers/iommu/tegra-smmu.c               |  2 +-
 drivers/remoteproc/remoteproc_core.c     |  2 +-
 drivers/vfio/vfio_iommu_type1.c          |  2 +-
 include/linux/iommu.h                    | 12 +++++++++---
 virt/kvm/iommu.c                         |  3 ++-
 20 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4c88935654ca..c768e58fa3f1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1970,7 +1970,7 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_domain_alloc(bus);
+	mapping->domain = iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
 	if (!mapping->domain)
 		goto err4;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index c6322197db8c..aa755c54e70f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -603,7 +603,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	 * and have separate page tables per context.  For now, to keep things
 	 * simple and to get something working, just use a single address space:
 	 */
-	iommu = iommu_domain_alloc(&platform_bus_type);
+	iommu = iommu_domain_alloc(&platform_bus_type, IOMMU_DOMAIN_DMA);
 	if (iommu) {
 		dev_info(drm->dev, "%s: using IOMMU\n", name);
 		gpu->mmu = msm_iommu_new(drm, iommu);
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 801a1d6937e4..4bdec982fc39 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -471,7 +471,7 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->domain = domain = iommu_domain_alloc(&pci_bus_type);
+	pd->domain = domain = iommu_domain_alloc(&pci_bus_type, IOMMU_DOMAIN_DMA);
 	if (IS_ERR_OR_NULL(domain)) {
 		usnic_err("Failed to allocate IOMMU domain with err %ld\n",
 				PTR_ERR(pd->domain));
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4aec6a29e316..98a5cf4f4c02 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3292,7 +3292,7 @@ static int __init alloc_passthrough_domain(void)
 
 	return 0;
 }
-static int amd_iommu_domain_init(struct iommu_domain *dom)
+static int amd_iommu_domain_init(struct iommu_domain *dom, int type)
 {
 	struct protection_domain *domain;
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 499b4366a98d..984f0aa19d6f 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -774,7 +774,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state->states == NULL)
 		goto out_free_dev_state;
 
-	dev_state->domain = iommu_domain_alloc(&pci_bus_type);
+	dev_state->domain = iommu_domain_alloc(&pci_bus_type, IOMMU_DOMAIN_DMA);
 	if (dev_state->domain == NULL)
 		goto out_free_states;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a6e38982d09c..37d36e88420b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -940,7 +940,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
-static int arm_smmu_domain_init(struct iommu_domain *domain)
+static int arm_smmu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct arm_smmu_domain *smmu_domain;
 	pgd_t *pgd;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 99054d2c040d..7f9b18cc214c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -697,7 +697,7 @@ static inline void pgtable_flush(void *vastart, void *vaend)
 				virt_to_phys(vaend));
 }
 
-static int exynos_iommu_domain_init(struct iommu_domain *domain)
+static int exynos_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct exynos_iommu_domain *priv;
 	int i;
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 93072ba44b1d..4e1b7e1fd8e9 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -438,7 +438,7 @@ static void fsl_pamu_domain_destroy(struct iommu_domain *domain)
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
-static int fsl_pamu_domain_init(struct iommu_domain *domain)
+static int fsl_pamu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct fsl_dma_domain *dma_domain;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 51b6b77dc3e5..415f8fdb0256 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4160,7 +4160,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
-static int intel_iommu_domain_init(struct iommu_domain *domain)
+static int intel_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct dmar_domain *dmar_domain;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fcfe703..ca0a850152ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -647,7 +647,7 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+struct iommu_domain *iommu_domain_alloc(struct bus_type *bus, int type)
 {
 	struct iommu_domain *domain;
 	int ret;
@@ -661,7 +661,7 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 
 	domain->ops = bus->iommu_ops;
 
-	ret = domain->ops->domain_init(domain);
+	ret = domain->ops->domain_init(domain, type);
 	if (ret)
 		goto out_free;
 
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 53cde086e83b..a7f7de68c830 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -854,7 +854,7 @@ done:
  * IOMMU Operations
  */
 
-static int ipmmu_domain_init(struct iommu_domain *io_domain)
+static int ipmmu_domain_init(struct iommu_domain *io_domain, int type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f5ff657f49fa..1f535e468d33 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -210,7 +210,7 @@ static void __program_context(void __iomem *base, int ctx, phys_addr_t pgtable)
 	SET_M(base, ctx, 1);
 }
 
-static int msm_iommu_domain_init(struct iommu_domain *domain)
+static int msm_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct msm_priv *priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 895af06a667f..83dbb43ebc63 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1160,7 +1160,7 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&omap_domain->lock);
 }
 
-static int omap_iommu_domain_init(struct iommu_domain *domain)
+static int omap_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct omap_iommu_domain *omap_domain;
 
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index 464acda0bbc4..0ee48e3ca7f7 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -82,7 +82,7 @@ static void pgtable_write(struct shmobile_iommu_domain_pgtable *pgtable,
 				   sizeof(val) * count, DMA_TO_DEVICE);
 }
 
-static int shmobile_iommu_domain_init(struct iommu_domain *domain)
+static int shmobile_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	struct shmobile_iommu_domain *sh_domain;
 	int i, ret;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index dba1a9fd5070..a138d772f009 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -216,7 +216,7 @@ out:
 	spin_unlock(&gart->client_lock);
 }
 
-static int gart_iommu_domain_init(struct iommu_domain *domain)
+static int gart_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	return 0;
 }
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 605b5b46a903..edd1ec26b408 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -868,7 +868,7 @@ out:
 	spin_unlock(&as->client_lock);
 }
 
-static int smmu_iommu_domain_init(struct iommu_domain *domain)
+static int smmu_iommu_domain_init(struct iommu_domain *domain, int type)
 {
 	int i, err = -EAGAIN;
 	unsigned long flags;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3cd85a638afa..d0bb5b64e7ee 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -110,7 +110,7 @@ static int rproc_enable_iommu(struct rproc *rproc)
 		return 0;
 	}
 
-	domain = iommu_domain_alloc(dev->bus);
+	domain = iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 	if (!domain) {
 		dev_err(dev, "can't alloc iommu domain\n");
 		return -ENOMEM;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0734fbe5b651..8ae76774d28e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -699,7 +699,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_free;
 
-	domain->domain = iommu_domain_alloc(bus);
+	domain->domain = iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
 	if (!domain->domain) {
 		ret = -EIO;
 		goto out_free;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b96a5b2136e4..023ea8775303 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -49,6 +49,10 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+/* iommu domain types */
+#define IOMMU_DOMAIN_DMA	0x0
+#define IOMMU_DOMAIN_HYP	0x1
+
 struct iommu_domain {
 	struct iommu_ops *ops;
 	void *priv;
@@ -59,6 +63,7 @@ struct iommu_domain {
 
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
 #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
+#define IOMMU_CAP_HYP_MAPPING		0x3	/* isolates guest DMA */
 
 /*
  * Following constraints are specifc to FSL_PAMUV1:
@@ -102,7 +107,7 @@ enum iommu_attr {
  * @pgsize_bitmap: bitmap of supported page sizes
  */
 struct iommu_ops {
-	int (*domain_init)(struct iommu_domain *domain);
+	int (*domain_init)(struct iommu_domain *domain, int type);
 	void (*domain_destroy)(struct iommu_domain *domain);
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -142,7 +147,7 @@ struct iommu_ops {
 
 extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
-extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
+extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus, int type);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
@@ -243,7 +248,8 @@ static inline bool iommu_present(struct bus_type *bus)
 	return false;
 }
 
-static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus,
+						      int type)
 {
 	return NULL;
 }
diff --git a/virt/kvm/iommu.c b/virt/kvm/iommu.c
index 0df7d4b34dfe..9b025ba63898 100644
--- a/virt/kvm/iommu.c
+++ b/virt/kvm/iommu.c
@@ -238,7 +238,8 @@ int kvm_iommu_map_guest(struct kvm *kvm)
 
 	mutex_lock(&kvm->slots_lock);
 
-	kvm->arch.iommu_domain = iommu_domain_alloc(&pci_bus_type);
+	kvm->arch.iommu_domain = iommu_domain_alloc(&pci_bus_type,
+						    IOMMU_DOMAIN_HYP);
 	if (!kvm->arch.iommu_domain) {
 		r = -ENOMEM;
 		goto out_unlock;
-- 
2.0.0
