From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 14/18] iommu: tegra-smmu: remove PageReserved manipulation
Date: Mon, 27 Jul 2015 13:29:57 +0100
Message-ID: <E1ZJhXZ-00048L-5P@rmk-PC.arm.linux.org.uk>
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

Remove the unnecessary manipulation of the PageReserved flags in the
Tegra SMMU driver.  None of this is required as the page(s) remain
private to the SMMU driver.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index d4264e2bdd69..b826362ce96b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -295,7 +295,6 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	/* clear PDEs */
 	pd = page_address(as->pd);
-	SetPageReserved(as->pd);
 
 	for (i = 0; i < SMMU_NUM_PDE; i++)
 		pd[i] = 0;
@@ -313,7 +312,6 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 
 	/* TODO: free page directory and page tables */
-	ClearPageReserved(as->pd);
 
 	kfree(as);
 }
@@ -568,8 +566,6 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 
 		as->pts[pde] = page;
 
-		SetPageReserved(page);
-
 		pd[pde] = SMMU_MK_PDE(dma, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
 
 		dma_sync_single_range_for_device(smmu->dev, as->pd_dma,
@@ -619,7 +615,6 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 
 		/* Finally, free the page */
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
-		ClearPageReserved(page);
 		__free_page(page);
 		as->pts[pde] = NULL;
 	}
-- 
2.1.0
