From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 12/18] iommu: tegra-smmu: smmu_flush_ptc() wants device
 address
Date: Mon, 27 Jul 2015 13:29:46 +0100
Message-ID: <E1ZJhXO-000489-TI@rmk-PC.arm.linux.org.uk>
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

Pass smmu_flush_ptc() the device address rather than struct page
poiner.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 89e7961f4848..c54b0afda475 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -164,10 +164,9 @@ static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
 	smmu_writel(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
 }
 
-static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
+static inline void smmu_flush_ptc(struct tegra_smmu *smmu, phys_addr_t phys,
 				  unsigned long offset)
 {
-	phys_addr_t phys = page_to_phys(page);
 	u32 value;
 
 	offset &= ~(smmu->mc->soc->atom_size - 1);
@@ -407,7 +406,7 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 		return err;
 
 	smmu_flush_dcache(as->pd, 0, SMMU_SIZE_PD);
-	smmu_flush_ptc(smmu, as->pd, 0);
+	smmu_flush_ptc(smmu, page_to_phys(as->pd), 0);
 	smmu_flush_tlb_asid(smmu, as->id);
 
 	smmu_writel(smmu, as->id & 0x7f, SMMU_PTB_ASID);
@@ -540,7 +539,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
 
 		smmu_flush_dcache(as->pd, pde << 2, 4);
-		smmu_flush_ptc(smmu, as->pd, pde << 2);
+		smmu_flush_ptc(smmu, page_to_phys(as->pd), pde << 2);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 	} else {
@@ -577,7 +576,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 
 		/* Flush the page directory entry */
 		smmu_flush_dcache(as->pd, offset, sizeof(*pd));
-		smmu_flush_ptc(smmu, as->pd, offset);
+		smmu_flush_ptc(smmu, page_to_phys(as->pd), offset);
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 
@@ -597,7 +596,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	*pte = val;
 
 	smmu_flush_dcache(pte_page, offset, 4);
-	smmu_flush_ptc(smmu, pte_page, offset);
+	smmu_flush_ptc(smmu, page_to_phys(pte_page), offset);
 	smmu_flush_tlb_group(smmu, as->id, iova);
 	smmu_flush(smmu);
 }
-- 
2.1.0
