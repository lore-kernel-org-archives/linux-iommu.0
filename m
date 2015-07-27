From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 16/18] iommu: tegra-smmu: get_use
Date: Mon, 27 Jul 2015 13:30:07 +0100
Message-ID: <E1ZJhXj-0004CY-DQ@rmk-PC.arm.linux.org.uk>
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
 drivers/iommu/tegra-smmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index bc179c759805..8bf38b95cdd5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -524,7 +524,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       dma_addr_t *dmap)
 {
-	u32 *pd = page_address(as->pd), *pt;
+	u32 *pd = page_address(as->pd);
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
@@ -565,13 +565,14 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		*dmap = smmu_pde_to_dma(pd[pde]);
 	}
 
-	pt = page_address(as->pts[pde]);
+	return tegra_smmu_pte_offset(as->pts[pde], iova);
+}
 
-	/* Keep track of entries in this page table. */
-	if (pt[iova_pt_index(iova)] == 0)
-		as->count[pde]++;
+static void tegra_smmu_pte_get_use(struct tegra_smmu_as *as, unsigned long iova)
+{
+	unsigned int pd_index = iova_pd_index(iova);
 
-	return tegra_smmu_pte_offset(as->pts[pde], iova);
+	as->count[pd_index]++;
 }
 
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
@@ -632,6 +633,10 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!pte)
 		return -ENOMEM;
 
+	/* If we aren't overwriting a pre-existing entry, increment use */
+	if (!*pte)
+		tegra_smmu_pte_get_use(as, iova);
+
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
 			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
 
-- 
2.1.0
