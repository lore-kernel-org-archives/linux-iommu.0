From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 17/18] iommu: tegra-smmu: more cleanups
Date: Mon, 27 Jul 2015 13:30:12 +0100
Message-ID: <E1ZJhXo-0004Ce-Hq@rmk-PC.arm.linux.org.uk>
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

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 49 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8bf38b95cdd5..e5d6bc45c58f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -497,6 +497,27 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
 	}
 }
 
+static void tegra_smmu_set_pge(struct tegra_smmu_as *as, unsigned long iova,
+			       u32 val)
+{
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned int pd_index = iova_pd_index(iova);
+	u32 *pd = page_address(as->pd);
+	unsigned long offset = pd_index * sizeof(*pd);
+
+	/* Set the page directory entry first */
+	pd[pd_index] = val;
+
+	/* The flush the page directory entry from caches */
+	dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
+					 sizeof(*pd), DMA_TO_DEVICE);
+
+	/* And flush the iommu */
+	smmu_flush_ptc(smmu, as->pd_dma, offset);
+	smmu_flush_tlb_section(smmu, as->id, iova);
+	smmu_flush(smmu);
+}
+
 static u32 *tegra_smmu_pte_offset(struct page *pt_page, unsigned long iova)
 {
 	u32 *pt = page_address(pt_page);
@@ -524,7 +545,6 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       dma_addr_t *dmap)
 {
-	u32 *pd = page_address(as->pd);
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
@@ -552,16 +572,13 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 
 		as->pts[pde] = page;
 
-		pd[pde] = SMMU_MK_PDE(dma, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
-
-		dma_sync_single_range_for_device(smmu->dev, as->pd_dma,
-						 pde << 2, 4, DMA_TO_DEVICE);
-		smmu_flush_ptc(smmu, as->pd_dma, pde << 2);
-		smmu_flush_tlb_section(smmu, as->id, iova);
-		smmu_flush(smmu);
+		tegra_smmu_set_pge(as, iova, SMMU_MK_PDE(dma, SMMU_PDE_ATTR |
+							      SMMU_PDE_NEXT));
 
 		*dmap = dma;
 	} else {
+		u32 *pd = page_address(as->pd);
+
 		*dmap = smmu_pde_to_dma(pd[pde]);
 	}
 
@@ -577,9 +594,7 @@ static void tegra_smmu_pte_get_use(struct tegra_smmu_as *as, unsigned long iova)
 
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 {
-	struct tegra_smmu *smmu = as->smmu;
 	unsigned int pde = iova_pd_index(iova);
-	u32 *pd = page_address(as->pd);
 	struct page *page = as->pts[pde];
 
 	/*
@@ -587,20 +602,12 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	 * memory page to the system.
 	 */
 	if (--as->count[pde] == 0) {
-		unsigned int offset = pde * sizeof(*pd);
+		struct tegra_smmu *smmu = as->smmu;
+		u32 *pd = page_address(as->pd);
 		dma_addr_t pte_dma = smmu_pde_to_dma(pd[pde]);
 
-		/* Clear the page directory entry first */
-		pd[pde] = 0;
-
-		/* Flush the page directory entry */
-		dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
-						 sizeof(*pd), DMA_TO_DEVICE);
-		smmu_flush_ptc(smmu, as->pd_dma, offset);
-		smmu_flush_tlb_section(smmu, as->id, iova);
-		smmu_flush(smmu);
+		tegra_smmu_set_pge(as, iova, 0);
 
-		/* Finally, free the page */
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
 		__free_page(page);
 		as->pts[pde] = NULL;
-- 
2.1.0
