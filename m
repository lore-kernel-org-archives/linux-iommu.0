From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: Re: atomic context for iommu_map call
Date: Tue, 26 Jun 2012 11:07:43 -0700
Message-ID: <20120626180743.GV15796@sequoia.sous-sol.org>
References: <20120622112812.GV8140@oktetlabs.ru>
	<20120626085853.GX2624@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120626085853.GX2624-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: "Alexandra N. Kossovsky" <Alexandra.Kossovsky-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robert Stonehouse <rstonehouse-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

* Joerg Roedel (joerg.roedel-5C7GfCeVMHo@public.gmane.org) wrote:
> On Fri, Jun 22, 2012 at 03:28:14PM +0400, Alexandra N. Kossovsky wrote:
> > Hello.
> > 
> > It is not clear from the documentation if iommu_map()/iommu_unmap()
> > functions may be called from atomic context.
> > In case of Intel IOMMU, it works; in case of AMD IOMMU, it does not.
> > 
> > Was it done by purpose?  May I propose a patch for AMD IOMMU replacing
> > GFP_KERNEL by GFP_ATOMIC to make things better?
> 
> Well, a better option would be to have an iommu_map_atomic() alongside
> the current iommu_map API call.

A simple change for ->map to include flags and an iommu_map_atomic helper
that calls ->map w/ GFP_ATOMIC will hit this in AMD IOMMU:

        mutex_lock(&domain->api_lock);
-       ret = iommu_map_page(domain, iova, paddr, prot, page_size);
+       ret = iommu_map_page(domain, iova, paddr, prot, page_size, flags);
        mutex_unlock(&domain->api_lock);

thanks,
-chris
---

From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH example] iommu: add gfp flags to ->map

untested, not to apply

---
 drivers/iommu/amd_iommu.c   |   12 +++++++-----
 drivers/iommu/intel-iommu.c |    2 +-
 drivers/iommu/iommu.c       |   19 ++++++++++++++++---
 drivers/iommu/msm_iommu.c   |    2 +-
 drivers/iommu/omap-iommu.c  |   16 +++++++++-------
 drivers/iommu/tegra-gart.c  |    2 +-
 drivers/iommu/tegra-smmu.c  |    2 +-
 include/linux/iommu.h       |   11 ++++++++++-
 8 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5bee8e..9160810 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1186,7 +1186,8 @@ static int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
 			  int prot,
-			  unsigned long page_size)
+			  unsigned long page_size,
+			  gfp_t flags)
 {
 	u64 __pte, *pte;
 	int i, count;
@@ -1197,7 +1198,7 @@ static int iommu_map_page(struct protection_domain *dom,
 	bus_addr  = PAGE_ALIGN(bus_addr);
 	phys_addr = PAGE_ALIGN(phys_addr);
 	count     = PAGE_SIZE_PTE_COUNT(page_size);
-	pte       = alloc_pte(dom, bus_addr, page_size, NULL, GFP_KERNEL);
+	pte       = alloc_pte(dom, bus_addr, page_size, NULL, flags);
 
 	for (i = 0; i < count; ++i)
 		if (IOMMU_PTE_PRESENT(pte[i]))
@@ -1297,7 +1298,7 @@ static int dma_ops_unity_map(struct dma_ops_domain *dma_dom,
 	for (addr = e->address_start; addr < e->address_end;
 	     addr += PAGE_SIZE) {
 		ret = iommu_map_page(&dma_dom->domain, addr, addr, e->prot,
-				     PAGE_SIZE);
+				     PAGE_SIZE, GFP_KERNEL);
 		if (ret)
 			return ret;
 		/*
@@ -3116,7 +3117,8 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 }
 
 static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
-			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+			 phys_addr_t paddr, size_t page_size, int iommu_prot,
+			 gfp_t flags)
 {
 	struct protection_domain *domain = dom->priv;
 	int prot = 0;
@@ -3131,7 +3133,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IW;
 
 	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, prot, page_size);
+	ret = iommu_map_page(domain, iova, paddr, prot, page_size, flags);
 	mutex_unlock(&domain->api_lock);
 
 	return ret;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bf2fbaa..19fa562 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4010,7 +4010,7 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
-			   size_t size, int iommu_prot)
+			   size_t size, int iommu_prot, gfp_t flags)
 {
 	struct dmar_domain *dmar_domain = domain->priv;
 	u64 max_addr;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2198b2d..13e8dcd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -209,8 +209,8 @@ int iommu_domain_has_cap(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot, gfp_t flags)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
@@ -269,7 +269,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa 0x%lx pgsize %lu\n", iova,
 					(unsigned long)paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = domain->ops->map(domain, iova, paddr, pgsize, prot, flags);
 		if (ret)
 			break;
 
@@ -284,8 +284,21 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+}
 EXPORT_SYMBOL_GPL(iommu_map);
 
+int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
+		     phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
+}
+EXPORT_SYMBOL_GPL(iommu_map_atomic);
+
 size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
 	size_t unmapped_page, unmapped = 0;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index cee307e..7381418 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -355,7 +355,7 @@ fail:
 }
 
 static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
-			 phys_addr_t pa, size_t len, int prot)
+			 phys_addr_t pa, size_t len, int prot, gfp_t flags)
 {
 	struct msm_priv *priv;
 	unsigned long flags;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6899dcd..e20cde4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -493,7 +493,7 @@ static void iopte_free(u32 *iopte)
 	kmem_cache_free(iopte_cachep, iopte);
 }
 
-static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
+static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da, gfp_t gfp)
 {
 	u32 *iopte;
 
@@ -505,7 +505,7 @@ static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
 	 * do the allocation outside the page table lock
 	 */
 	spin_unlock(&obj->page_table_lock);
-	iopte = kmem_cache_zalloc(iopte_cachep, GFP_KERNEL);
+	iopte = kmem_cache_zalloc(iopte_cachep, gfp);
 	spin_lock(&obj->page_table_lock);
 
 	if (!*iopgd) {
@@ -563,10 +563,11 @@ static int iopgd_alloc_super(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot,
+			    gfp_t gfp)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
-	u32 *iopte = iopte_alloc(obj, iopgd, da);
+	u32 *iopte = iopte_alloc(obj, iopgd, da, gfp);
 
 	if (IS_ERR(iopte))
 		return PTR_ERR(iopte);
@@ -580,10 +581,11 @@ static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopte_alloc_large(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopte_alloc_large(struct omap_iommu *obj, u32 da, u32 pa, u32 prot,
+			     gfp_t gfp)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
-	u32 *iopte = iopte_alloc(obj, iopgd, da);
+	u32 *iopte = iopte_alloc(obj, iopgd, da, gfp);
 	int i;
 
 	if ((da | pa) & ~IOLARGE_MASK) {
@@ -1014,7 +1016,7 @@ static void iopte_cachep_ctor(void *iopte)
 }
 
 static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
-			 phys_addr_t pa, size_t bytes, int prot)
+			 phys_addr_t pa, size_t bytes, int prot, gfp_t gfp)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 779306e..b8e8889 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -233,7 +233,7 @@ static void gart_iommu_domain_destroy(struct iommu_domain *domain)
 }
 
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t pa, size_t bytes, int prot)
+			  phys_addr_t pa, size_t bytes, int prot, gfp_t gfp)
 {
 	struct gart_device *gart = domain->priv;
 	unsigned long flags;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index eb93c82..ab71e81 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -627,7 +627,7 @@ static void __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
 }
 
 static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t pa, size_t bytes, int prot)
+			  phys_addr_t pa, size_t bytes, int prot, gfp_t gfp)
 {
 	struct smmu_as *as = domain->priv;
 	unsigned long pfn = __phys_to_pfn(pa);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d937580..e9a5997 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -67,7 +67,7 @@ struct iommu_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
-		   phys_addr_t paddr, size_t size, int prot);
+		   phys_addr_t paddr, size_t size, int prot, gfp_t flags);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
@@ -88,6 +88,8 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
+extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
+			    phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
@@ -172,6 +174,13 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_atomic(struct iommu_domain *domain,
+				   unsigned long iova, phys_addr_t paddr,
+				   int gfp_order, int prot)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			      int gfp_order)
 {
