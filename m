From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 05/18] iommu: tegra-smmu: factor out common pte setting
Date: Mon, 27 Jul 2015 13:29:10 +0100
Message-ID: <E1ZJhWo-00047R-SM@rmk-PC.arm.linux.org.uk>
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

Factor out the common pte setting code into a separate function.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index a7a7645fb268..53d0f15dac6f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -541,12 +541,24 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	}
 }
 
+static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
+			       u32 *pte, struct page *pte_page, u32 val)
+{
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long offset = offset_in_page(pte);
+
+	*pte = val;
+
+	smmu->soc->ops->flush_dcache(pte_page, offset, 4);
+	smmu_flush_ptc(smmu, pte_page, offset);
+	smmu_flush_tlb_group(smmu, as->id, iova);
+	smmu_flush(smmu);
+}
+
 static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset;
 	struct page *page;
 	u32 *pte;
 
@@ -554,13 +566,8 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!pte)
 		return -ENOMEM;
 
-	*pte = __phys_to_pfn(paddr) | SMMU_PTE_ATTR;
-	offset = offset_in_page(pte);
-
-	smmu->soc->ops->flush_dcache(page, offset, 4);
-	smmu_flush_ptc(smmu, page, offset);
-	smmu_flush_tlb_group(smmu, as->id, iova);
-	smmu_flush(smmu);
+	tegra_smmu_set_pte(as, iova, pte, page,
+			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
 
 	return 0;
 }
@@ -569,8 +576,6 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset;
 	struct page *page;
 	u32 *pte;
 
@@ -578,15 +583,7 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	if (!pte || !*pte)
 		return 0;
 
-	*pte = 0;
-
-	offset = offset_in_page(pte);
-
-	smmu->soc->ops->flush_dcache(page, offset, 4);
-	smmu_flush_ptc(smmu, page, offset);
-	smmu_flush_tlb_group(smmu, as->id, iova);
-	smmu_flush(smmu);
-
+	tegra_smmu_set_pte(as, iova, pte, page, 0);
 	tegra_smmu_pte_put_use(as, iova);
 
 	return size;
-- 
2.1.0
