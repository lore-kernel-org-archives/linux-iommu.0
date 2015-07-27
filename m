From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 08/18] iommu: tegra-smmu: store struct page pointer for page
 tables
Date: Mon, 27 Jul 2015 13:29:26 +0100
Message-ID: <E1ZJhX4-00047l-98@rmk-PC.arm.linux.org.uk>
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

Store the struct page pointer for the second level page tables, rather
than working back from the page directory entry.  This is necessary as
we want to eliminate the use of physical addresses used with
arch-private functions, switching instead to use the streaming DMA API.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index bbff5b647183..8ec5ac45caab 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -41,6 +41,7 @@ struct tegra_smmu_as {
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
 	struct page *count;
+	struct page **pts;
 	struct page *pd;
 	unsigned id;
 	u32 attr;
@@ -271,6 +272,14 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
+	if (!as->pts) {
+		__free_page(as->count);
+		__free_page(as->pd);
+		kfree(as);
+		return NULL;
+	}
+
 	/* clear PDEs */
 	pd = page_address(as->pd);
 	SetPageReserved(as->pd);
@@ -487,14 +496,11 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 {
 	unsigned int pd_index = iova_pd_index(iova);
 	struct page *pt_page;
-	u32 *pd;
 
-	pd = page_address(as->pd);
-
-	if (!pd[pd_index])
+	pt_page = as->pts[pd_index];
+	if (!pt_page)
 		return NULL;
 
-	pt_page = pfn_to_page(pd[pd_index] & as->smmu->pfn_mask);
 	*pagep = pt_page;
 
 	return tegra_smmu_pte_offset(pt_page, iova);
@@ -509,7 +515,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	struct page *page;
 	unsigned int i;
 
-	if (pd[pde] == 0) {
+	if (!as->pts[pde]) {
 		page = alloc_page(GFP_KERNEL | __GFP_DMA);
 		if (!page)
 			return NULL;
@@ -520,6 +526,8 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		for (i = 0; i < SMMU_NUM_PTE; i++)
 			pt[i] = 0;
 
+		as->pts[pde] = page;
+
 		smmu->soc->ops->flush_dcache(page, 0, SMMU_SIZE_PT);
 
 		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
@@ -529,7 +537,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 	} else {
-		page = pfn_to_page(pd[pde] & smmu->pfn_mask);
+		page = as->pts[pde];
 	}
 
 	*pagep = page;
@@ -550,9 +558,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	unsigned int pde = iova_pd_index(iova);
 	u32 *count = page_address(as->count);
 	u32 *pd = page_address(as->pd);
-	struct page *page;
-
-	page = pfn_to_page(pd[pde] & smmu->pfn_mask);
+	struct page *page = as->pts[pde];
 
 	/*
 	 * When no entries in this page table are used anymore, return the
@@ -573,6 +579,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		/* Finally, free the page */
 		ClearPageReserved(page);
 		__free_page(page);
+		as->pts[pde] = NULL;
 	}
 }
 
-- 
2.1.0
