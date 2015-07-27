From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 13/18] iommu: tegra-smmu: convert to use DMA API
Date: Mon, 27 Jul 2015 13:29:52 +0100
Message-ID: <E1ZJhXU-00048F-0C@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727122824.GH7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Use the DMA API instead of calling architecture internal functions in
the Tegra SMMU driver.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 129 +++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c54b0afda475..d4264e2bdd69 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -45,6 +45,7 @@ struct tegra_smmu_as {
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
+	dma_addr_t pd_dma;
 	unsigned id;
 	u32 attr;
 };
@@ -82,9 +83,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define  SMMU_PTB_ASID_VALUE(x) ((x) & 0x7f)
 
 #define SMMU_PTB_DATA 0x020
-#define  SMMU_PTB_DATA_VALUE(page, attr) (page_to_phys(page) >> 12 | (attr))
+#define  SMMU_PTB_DATA_VALUE(dma, attr) ((dma) >> 12 | (attr))
 
-#define SMMU_MK_PDE(page, attr) (page_to_phys(page) >> SMMU_PTE_SHIFT | (attr))
+#define SMMU_MK_PDE(dma, attr) ((dma) >> SMMU_PTE_SHIFT | (attr))
 
 #define SMMU_TLB_FLUSH 0x030
 #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
@@ -147,16 +148,15 @@ static unsigned int iova_pt_index(unsigned long iova)
 	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
 }
 
-static void smmu_flush_dcache(struct page *page, unsigned long offset,
-			      size_t size)
+static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
 {
-	phys_addr_t phys = page_to_phys(page) + offset;
-	void *virt = page_address(page) + offset;
+	addr >>= 12;
+	return (addr & smmu->pfn_mask) == addr;
+}
 
-	__cpuc_flush_dcache_area(virt, size);
-#ifdef CONFIG_ARM
-	outer_flush_range(phys, phys + size);
-#endif
+static dma_addr_t smmu_pde_to_dma(u32 pde)
+{
+	return pde << 12;
 }
 
 static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
@@ -164,7 +164,7 @@ static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
 	smmu_writel(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
 }
 
-static inline void smmu_flush_ptc(struct tegra_smmu *smmu, phys_addr_t phys,
+static inline void smmu_flush_ptc(struct tegra_smmu *smmu, dma_addr_t dma,
 				  unsigned long offset)
 {
 	u32 value;
@@ -172,15 +172,15 @@ static inline void smmu_flush_ptc(struct tegra_smmu *smmu, phys_addr_t phys,
 	offset &= ~(smmu->mc->soc->atom_size - 1);
 
 	if (smmu->mc->soc->num_address_bits > 32) {
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-		value = (phys >> 32) & SMMU_PTC_FLUSH_HI_MASK;
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		value = (dma >> 32) & SMMU_PTC_FLUSH_HI_MASK;
 #else
 		value = 0;
 #endif
 		smmu_writel(smmu, value, SMMU_PTC_FLUSH_HI);
 	}
 
-	value = (phys + offset) | SMMU_PTC_FLUSH_TYPE_ADR;
+	value = (dma + offset) | SMMU_PTC_FLUSH_TYPE_ADR;
 	smmu_writel(smmu, value, SMMU_PTC_FLUSH);
 }
 
@@ -401,16 +401,26 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 		return 0;
 	}
 
+	as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(smmu->dev, as->pd_dma))
+		return -ENOMEM;
+
+	/* We can't handle 64-bit DMA addresses */
+	if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
+		err = -ENOMEM;
+		goto err_unmap;
+	}
+
 	err = tegra_smmu_alloc_asid(smmu, &as->id);
 	if (err < 0)
-		return err;
+		goto err_unmap;
 
-	smmu_flush_dcache(as->pd, 0, SMMU_SIZE_PD);
-	smmu_flush_ptc(smmu, page_to_phys(as->pd), 0);
+	smmu_flush_ptc(smmu, as->pd_dma, 0);
 	smmu_flush_tlb_asid(smmu, as->id);
 
 	smmu_writel(smmu, as->id & 0x7f, SMMU_PTB_ASID);
-	value = SMMU_PTB_DATA_VALUE(as->pd, as->attr);
+	value = SMMU_PTB_DATA_VALUE(as->pd_dma, as->attr);
 	smmu_writel(smmu, value, SMMU_PTB_DATA);
 	smmu_flush(smmu);
 
@@ -418,6 +428,10 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	as->use_count++;
 
 	return 0;
+
+err_unmap:
+	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+	return err;
 }
 
 static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
@@ -427,6 +441,9 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 		return;
 
 	tegra_smmu_free_asid(smmu, as->id);
+
+	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+
 	as->smmu = NULL;
 }
 
@@ -498,63 +515,81 @@ static u32 *tegra_smmu_pte_offset(struct page *pt_page, unsigned long iova)
 }
 
 static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
-				  struct page **pagep)
+				  dma_addr_t *dmap)
 {
 	unsigned int pd_index = iova_pd_index(iova);
 	struct page *pt_page;
+	u32 *pd;
 
 	pt_page = as->pts[pd_index];
 	if (!pt_page)
 		return NULL;
 
-	*pagep = pt_page;
+	pd = page_address(as->pd);
+	*dmap = smmu_pde_to_dma(pd[pd_index]);
 
 	return tegra_smmu_pte_offset(pt_page, iova);
 }
 
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
-		       struct page **pagep)
+		       dma_addr_t *dmap)
 {
 	u32 *pd = page_address(as->pd), *pt;
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
-	struct page *page;
 	unsigned int i;
 
 	if (!as->pts[pde]) {
+		struct page *page;
+		dma_addr_t dma;
+
 		page = alloc_page(GFP_KERNEL | __GFP_DMA);
 		if (!page)
 			return NULL;
 
 		pt = page_address(page);
-		SetPageReserved(page);
 
 		for (i = 0; i < SMMU_NUM_PTE; i++)
 			pt[i] = 0;
 
+		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
+				   DMA_TO_DEVICE);
+		if (dma_mapping_error(smmu->dev, dma)) {
+			__free_page(page);
+			return NULL;
+		}
+
+		if (!smmu_dma_addr_valid(smmu, dma)) {
+			dma_unmap_page(smmu->dev, dma, SMMU_SIZE_PT,
+				       DMA_TO_DEVICE);
+			__free_page(page);
+			return NULL;
+		}
+
 		as->pts[pde] = page;
 
-		smmu_flush_dcache(page, 0, SMMU_SIZE_PT);
+		SetPageReserved(page);
 
-		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
+		pd[pde] = SMMU_MK_PDE(dma, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
 
-		smmu_flush_dcache(as->pd, pde << 2, 4);
-		smmu_flush_ptc(smmu, page_to_phys(as->pd), pde << 2);
+		dma_sync_single_range_for_device(smmu->dev, as->pd_dma,
+						 pde << 2, 4, DMA_TO_DEVICE);
+		smmu_flush_ptc(smmu, as->pd_dma, pde << 2);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
+
+		*dmap = dma;
 	} else {
-		page = as->pts[pde];
+		*dmap = smmu_pde_to_dma(pd[pde]);
 	}
 
-	*pagep = page;
-
-	pt = page_address(page);
+	pt = page_address(as->pts[pde]);
 
 	/* Keep track of entries in this page table. */
 	if (pt[iova_pt_index(iova)] == 0)
 		as->count[pde]++;
 
-	return tegra_smmu_pte_offset(page, iova);
+	return tegra_smmu_pte_offset(as->pts[pde], iova);
 }
 
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
@@ -570,17 +605,20 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	 */
 	if (--as->count[pde] == 0) {
 		unsigned int offset = pde * sizeof(*pd);
+		dma_addr_t pte_dma = smmu_pde_to_dma(pd[pde]);
 
 		/* Clear the page directory entry first */
 		pd[pde] = 0;
 
 		/* Flush the page directory entry */
-		smmu_flush_dcache(as->pd, offset, sizeof(*pd));
-		smmu_flush_ptc(smmu, page_to_phys(as->pd), offset);
+		dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
+						 sizeof(*pd), DMA_TO_DEVICE);
+		smmu_flush_ptc(smmu, as->pd_dma, offset);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 
 		/* Finally, free the page */
+		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
 		ClearPageReserved(page);
 		__free_page(page);
 		as->pts[pde] = NULL;
@@ -588,15 +626,16 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 }
 
 static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
-			       u32 *pte, struct page *pte_page, u32 val)
+			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
 	struct tegra_smmu *smmu = as->smmu;
 	unsigned long offset = offset_in_page(pte);
 
 	*pte = val;
 
-	smmu_flush_dcache(pte_page, offset, 4);
-	smmu_flush_ptc(smmu, page_to_phys(pte_page), offset);
+	dma_sync_single_range_for_device(smmu->dev, pte_dma, offset,
+					 4, DMA_TO_DEVICE);
+	smmu_flush_ptc(smmu, pte_dma, offset);
 	smmu_flush_tlb_group(smmu, as->id, iova);
 	smmu_flush(smmu);
 }
@@ -605,14 +644,14 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct page *page;
+	dma_addr_t pte_dma;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &page);
+	pte = as_get_pte(as, iova, &pte_dma);
 	if (!pte)
 		return -ENOMEM;
 
-	tegra_smmu_set_pte(as, iova, pte, page,
+	tegra_smmu_set_pte(as, iova, pte, pte_dma,
 			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
 
 	return 0;
@@ -622,14 +661,14 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct page *pte_page;
+	dma_addr_t pte_dma;
 	u32 *pte;
 
-	pte = tegra_smmu_pte_lookup(as, iova, &pte_page);
+	pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
 	if (!pte || !*pte)
 		return 0;
 
-	tegra_smmu_set_pte(as, iova, pte, pte_page, 0);
+	tegra_smmu_set_pte(as, iova, pte, pte_dma, 0);
 	tegra_smmu_pte_put_use(as, iova);
 
 	return size;
@@ -639,11 +678,11 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct page *pte_page;
 	unsigned long pfn;
+	dma_addr_t pte_dma;
 	u32 *pte;
 
-	pte = tegra_smmu_pte_lookup(as, iova, &pte_page);
+	pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
 	if (!pte || !*pte)
 		return 0;
 
-- 
2.1.0
