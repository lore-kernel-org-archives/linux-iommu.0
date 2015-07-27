From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 11/18] iommu: tegra-smmu: split smmu_flush_ptc()
Date: Mon, 27 Jul 2015 13:29:41 +0100
Message-ID: <E1ZJhXJ-000483-Mk@rmk-PC.arm.linux.org.uk>
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

smmu_flush_ptc() is used in two modes: one is to flush an individual
entry, the other is to flush all entries.  We know at the call site
which we require.  Split the function into smmu_flush_ptc_all() and
smmu_flush_ptc().

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index fa26b76017cf..89e7961f4848 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -159,29 +159,29 @@ static void smmu_flush_dcache(struct page *page, unsigned long offset,
 #endif
 }
 
+static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
+{
+	smmu_writel(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
+}
+
 static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
 				  unsigned long offset)
 {
-	phys_addr_t phys = page ? page_to_phys(page) : 0;
+	phys_addr_t phys = page_to_phys(page);
 	u32 value;
 
-	if (page) {
-		offset &= ~(smmu->mc->soc->atom_size - 1);
+	offset &= ~(smmu->mc->soc->atom_size - 1);
 
-		if (smmu->mc->soc->num_address_bits > 32) {
+	if (smmu->mc->soc->num_address_bits > 32) {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-			value = (phys >> 32) & SMMU_PTC_FLUSH_HI_MASK;
+		value = (phys >> 32) & SMMU_PTC_FLUSH_HI_MASK;
 #else
-			value = 0;
+		value = 0;
 #endif
-			smmu_writel(smmu, value, SMMU_PTC_FLUSH_HI);
-		}
-
-		value = (phys + offset) | SMMU_PTC_FLUSH_TYPE_ADR;
-	} else {
-		value = SMMU_PTC_FLUSH_TYPE_ALL;
+		smmu_writel(smmu, value, SMMU_PTC_FLUSH_HI);
 	}
 
+	value = (phys + offset) | SMMU_PTC_FLUSH_TYPE_ADR;
 	smmu_writel(smmu, value, SMMU_PTC_FLUSH);
 }
 
@@ -888,7 +888,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	smmu_writel(smmu, value, SMMU_TLB_CONFIG);
 
-	smmu_flush_ptc(smmu, NULL, 0);
+	smmu_flush_ptc_all(smmu);
 	smmu_flush_tlb(smmu);
 	smmu_writel(smmu, SMMU_CONFIG_ENABLE, SMMU_CONFIG);
 	smmu_flush(smmu);
-- 
2.1.0
