From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] iommu/tegra: smmu: Compute PFN mask at runtime
Date: Fri, 27 Mar 2015 11:07:27 +0100
Message-ID: <1427450847-17719-4-git-send-email-thierry.reding@gmail.com>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427450847-17719-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The SMMU on Tegra30 and Tegra114 supports addressing up to 4 GiB of
physical memory. On Tegra124 the addressable physical memory was
extended to 16 GiB. The page frame number stored in PTEs therefore
requires 20 or 22 bits, depending on SoC generation.

In order to cope with this, compute the proper value at runtime.

Reported-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7b36760ae087..f0496e34ada3 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
@@ -25,6 +26,8 @@ struct tegra_smmu {
 	struct tegra_mc *mc;
 	const struct tegra_smmu_soc *soc;
 
+	unsigned long pfn_mask;
+
 	unsigned long *asids;
 	struct mutex lock;
 
@@ -108,8 +111,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12
 
-#define SMMU_PFN_MASK 0x000fffff
-
 #define SMMU_PD_READABLE	(1 << 31)
 #define SMMU_PD_WRITABLE	(1 << 30)
 #define SMMU_PD_NONSECURE	(1 << 29)
@@ -489,7 +490,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 	} else {
-		page = pfn_to_page(pd[pde] & SMMU_PFN_MASK);
+		page = pfn_to_page(pd[pde] & smmu->pfn_mask);
 		pt = page_address(page);
 	}
 
@@ -511,7 +512,7 @@ static void as_put_pte(struct tegra_smmu_as *as, dma_addr_t iova)
 	u32 *pd = page_address(as->pd), *pt;
 	struct page *page;
 
-	page = pfn_to_page(pd[pde] & SMMU_PFN_MASK);
+	page = pfn_to_page(pd[pde] & as->smmu->pfn_mask);
 	pt = page_address(page);
 
 	/*
@@ -586,7 +587,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &page);
-	pfn = *pte & SMMU_PFN_MASK;
+	pfn = *pte & as->smmu->pfn_mask;
 
 	return PFN_PHYS(pfn);
 }
@@ -807,6 +808,10 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
+	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
+	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
+		mc->soc->num_address_bits, smmu->pfn_mask);
+
 	value = SMMU_PTC_CONFIG_ENABLE | SMMU_PTC_CONFIG_INDEX_MAP(0x3f);
 
 	if (soc->supports_request_limit)
-- 
2.3.2
