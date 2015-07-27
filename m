From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 04/18] iommu: tegra-smmu: fix unmap() method
Date: Mon, 27 Jul 2015 13:29:05 +0100
Message-ID: <E1ZJhWj-000477-OT@rmk-PC.arm.linux.org.uk>
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

The Tegra SMMU unmap path has several problems:
1. as_pte_put() can perform a write-after-free
2. tegra_smmu_unmap() can perform cache maintanence on a page we have
   just freed.
3. when a page table is unmapped, there is no CPU cache maintanence of
   the write clearing the page directory entry, nor is there any
   maintanence of the IOMMU to ensure that it sees the page table has
   gone.

Fix this by getting rid of as_pte_put(), and instead coding the PTE
unmap separately from the PDE unmap, placing the PDE unmap after the
PTE unmap has been completed.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 083354903a1a..a7a7645fb268 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -509,29 +509,35 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	return &pt[pte];
 }
 
-static void as_put_pte(struct tegra_smmu_as *as, dma_addr_t iova)
+static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 {
+	struct tegra_smmu *smmu = as->smmu;
 	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
-	u32 pte = (iova >> SMMU_PTE_SHIFT) & 0x3ff;
 	u32 *count = page_address(as->count);
-	u32 *pd = page_address(as->pd), *pt;
+	u32 *pd = page_address(as->pd);
 	struct page *page;
 
-	page = pfn_to_page(pd[pde] & as->smmu->pfn_mask);
-	pt = page_address(page);
+	page = pfn_to_page(pd[pde] & smmu->pfn_mask);
 
 	/*
 	 * When no entries in this page table are used anymore, return the
 	 * memory page to the system.
 	 */
-	if (pt[pte] != 0) {
-		if (--count[pde] == 0) {
-			ClearPageReserved(page);
-			__free_page(page);
-			pd[pde] = 0;
-		}
+	if (--count[pde] == 0) {
+		unsigned int offset = pde * sizeof(*pd);
 
-		pt[pte] = 0;
+		/* Clear the page directory entry first */
+		pd[pde] = 0;
+
+		/* Flush the page directory entry */
+		smmu->soc->ops->flush_dcache(as->pd, offset, sizeof(*pd));
+		smmu_flush_ptc(smmu, as->pd, offset);
+		smmu_flush_tlb_section(smmu, as->id, iova);
+		smmu_flush(smmu);
+
+		/* Finally, free the page */
+		ClearPageReserved(page);
+		__free_page(page);
 	}
 }
 
@@ -569,17 +575,20 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &page);
-	if (!pte)
+	if (!pte || !*pte)
 		return 0;
 
+	*pte = 0;
+
 	offset = offset_in_page(pte);
-	as_put_pte(as, iova);
 
 	smmu->soc->ops->flush_dcache(page, offset, 4);
 	smmu_flush_ptc(smmu, page, offset);
 	smmu_flush_tlb_group(smmu, as->id, iova);
 	smmu_flush(smmu);
 
+	tegra_smmu_pte_put_use(as, iova);
+
 	return size;
 }
 
-- 
2.1.0
