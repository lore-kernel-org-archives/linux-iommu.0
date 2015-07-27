From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 06/18] iommu: tegra-smmu: add iova_pd_index() and
 iova_pt_index() helpers
Date: Mon, 27 Jul 2015 13:29:16 +0100
Message-ID: <E1ZJhWu-00047X-13@rmk-PC.arm.linux.org.uk>
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

Add a pair of helpers to get the page directory and page table indexes.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 53d0f15dac6f..4c4bc7966046 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -134,6 +134,16 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
 				 SMMU_PTE_NONSECURE)
 
+static unsigned int iova_pd_index(unsigned long iova)
+{
+	return (iova >> SMMU_PDE_SHIFT) & (SMMU_NUM_PDE - 1);
+}
+
+static unsigned int iova_pt_index(unsigned long iova)
+{
+	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
+}
+
 static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
 				  unsigned long offset)
 {
@@ -469,8 +479,8 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       struct page **pagep)
 {
 	u32 *pd = page_address(as->pd), *pt, *count;
-	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
-	u32 pte = (iova >> SMMU_PTE_SHIFT) & 0x3ff;
+	unsigned int pde = iova_pd_index(iova);
+	unsigned int pte = iova_pt_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 	struct page *page;
 	unsigned int i;
@@ -512,7 +522,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
+	unsigned int pde = iova_pd_index(iova);
 	u32 *count = page_address(as->count);
 	u32 *pd = page_address(as->pd);
 	struct page *page;
-- 
2.1.0
