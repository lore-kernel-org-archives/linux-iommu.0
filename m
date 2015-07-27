From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 15/18] iommu: tegra-smmu: use __GFP_ZERO to allocate zeroed
 pages
Date: Mon, 27 Jul 2015 13:30:02 +0100
Message-ID: <E1ZJhXe-00048y-9l@rmk-PC.arm.linux.org.uk>
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

Rather than explicitly zeroing pages allocated via alloc_page(), add
__GFP_ZERO to the gfp mask to ask the allocator for zeroed pages.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index b826362ce96b..bc179c759805 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -260,8 +260,6 @@ static bool tegra_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
-	unsigned int i;
-	uint32_t *pd;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
@@ -272,7 +270,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
-	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA);
+	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
 	if (!as->pd) {
 		kfree(as);
 		return NULL;
@@ -293,12 +291,6 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
-	/* clear PDEs */
-	pd = page_address(as->pd);
-
-	for (i = 0; i < SMMU_NUM_PDE; i++)
-		pd[i] = 0;
-
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -535,21 +527,15 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	u32 *pd = page_address(as->pd), *pt;
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned int i;
 
 	if (!as->pts[pde]) {
 		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA);
+		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
 		if (!page)
 			return NULL;
 
-		pt = page_address(page);
-
-		for (i = 0; i < SMMU_NUM_PTE; i++)
-			pt[i] = 0;
-
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
-- 
2.1.0
