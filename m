From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Use smarter TLB flush method for v5 SYSMMU
Date: Fri, 24 Mar 2017 10:19:01 +0100
Message-ID: <1490347141-17980-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170324091908eucas1p1afc5e0375908fd2e620b119eeb089cad@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

SYSMMU v5 has dedicated registers to perform TLB flush range operation,
so use them instead of looping with FLUSH_ENTRY command.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c01bfcdb2383..48b5dabd06ce 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -171,6 +171,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_PT_BASE_PFN	0x00C
 #define REG_V5_MMU_FLUSH_ALL	0x010
 #define REG_V5_MMU_FLUSH_ENTRY	0x014
+#define REG_V5_MMU_FLUSH_RANGE	0x018
+#define REG_V5_MMU_FLUSH_START	0x020
+#define REG_V5_MMU_FLUSH_END	0x024
 #define REG_V5_INT_STATUS	0x060
 #define REG_V5_INT_CLEAR	0x064
 #define REG_V5_FAULT_AR_VA	0x070
@@ -319,14 +322,23 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 {
 	unsigned int i;
 
-	for (i = 0; i < num_inv; i++) {
-		if (MMU_MAJ_VER(data->version) < 5)
+	if (MMU_MAJ_VER(data->version) < 5) {
+		for (i = 0; i < num_inv; i++) {
 			writel((iova & SPAGE_MASK) | 1,
 				     data->sfrbase + REG_MMU_FLUSH_ENTRY);
-		else
+			iova += SPAGE_SIZE;
+		}
+	} else {
+		if (num_inv == 1) {
 			writel((iova & SPAGE_MASK) | 1,
 				     data->sfrbase + REG_V5_MMU_FLUSH_ENTRY);
-		iova += SPAGE_SIZE;
+		} else {
+			writel((iova & SPAGE_MASK),
+				     data->sfrbase + REG_V5_MMU_FLUSH_START);
+			writel((iova & SPAGE_MASK) + (num_inv - 1) * SPAGE_SIZE,
+				     data->sfrbase + REG_V5_MMU_FLUSH_END);
+			writel(1, data->sfrbase + REG_V5_MMU_FLUSH_RANGE);
+		}
 	}
 }
 
-- 
1.9.1
