From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 23/31] iommu/exynos: use simpler function to get MMU version
Date: Sun, 27 Apr 2014 13:07:55 +0530
Message-ID: <1398584283-22846-24-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, tomasz.figa@gmail.com, pullip.cho@samsung.com, a.motakis@virtualopensystems.com, grundler@chromium.org, joro@8bytes.org, prathyush.k@samsung.com, rahul.sharma@samsung.com, sachin.kamat@linaro.org, supash.ramaswamy@linaro.org, Varun.Sethi@freescale.com, s.nawrocki@samsung.com, t.figa@samsung.com, joshi@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

This commit changes the function to get MMU version simpler.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 00915f2..54011e5 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -252,24 +252,6 @@ static unsigned int __raw_sysmmu_version(struct sysmmu_drvdata *data)
 	return MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
 }
 
-static unsigned int __sysmmu_version(struct sysmmu_drvdata *data,
-				     unsigned int *minor)
-{
-	unsigned int ver = 0;
-
-	ver = __raw_sysmmu_version(data);
-	if (ver > MAKE_MMU_VER(3, 3)) {
-		dev_err(data->sysmmu, "%s: version(%d.%d) is higher than 3.3\n",
-			__func__, MMU_MAJ_VER(ver), MMU_MIN_VER(ver));
-		BUG();
-	}
-
-	if (minor)
-		*minor = MMU_MIN_VER(ver);
-
-	return MMU_MAJ_VER(ver);
-}
-
 static bool sysmmu_block(void __iomem *sfrbase)
 {
 	int i = 120;
@@ -427,13 +409,13 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 {
 	unsigned int cfg = CFG_LRU | CFG_QOS(15);
-	int maj, min = 0;
+	unsigned int ver;
 
-	maj = __sysmmu_version(data, &min);
-	if (maj == 3) {
-		if (min >= 2) {
+	ver = __raw_sysmmu_version(data);
+	if (MMU_MAJ_VER(ver) == 3) {
+		if (MMU_MIN_VER(ver) >= 2) {
 			cfg |= CFG_FLPDCACHE;
-			if (min == 3) {
+			if (MMU_MIN_VER(ver) == 3) {
 				cfg |= CFG_ACGEN;
 				cfg &= ~CFG_LRU;
 			} else {
@@ -591,7 +573,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 			 * 1MB page can be cached in one of all sets.
 			 * 64KB page can be one of 16 consecutive sets.
 			 */
-			if (__sysmmu_version(data, NULL) == 2)
+			if (MMU_MAJ_VER(__raw_sysmmu_version(data)) == 2)
 				num_inv = min_t(unsigned int,
 						size / PAGE_SIZE, 64);
 
-- 
1.7.9.5
