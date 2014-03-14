From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 25/27] iommu/exynos: use simpler function to get MMU
	version
Date: Fri, 14 Mar 2014 14:13:46 +0900
Message-ID: <20140314141346.101ae9148289467808857d13@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This commit changes the function to get MMU version simpler.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6e716cc..3d4dabb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -251,24 +251,6 @@ static unsigned int __raw_sysmmu_version(struct sysmmu_drvdata *data)
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
@@ -422,13 +404,13 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
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
@@ -583,7 +565,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 			 * 1MB page can be cached in one of all sets.
 			 * 64KB page can be one of 16 consecutive sets.
 			 */
-			if (__sysmmu_version(data, NULL) == 2)
+			if (MMU_MAJ_VER(__raw_sysmmu_version(data)) == 2)
 				num_inv = min_t(unsigned int,
 						size / PAGE_SIZE, 64);
 
-- 
1.7.9.5
