From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 27/27] iommu/exynos: enhanced error messages
Date: Fri, 14 Mar 2014 14:14:31 +0900
Message-ID: <20140314141431.320b055a618203746b1e3075@samsung.com>
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

Some redundant error message is removed and some error messages
are changed to error level from debug level.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4888383..b7f7731 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1012,7 +1012,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
 					__func__, &pgtable);
 	} else {
-		dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
+		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
 	}
 }
 
@@ -1112,10 +1112,8 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 								short *pgcnt)
 {
 	if (size == SPAGE_SIZE) {
-		if (!lv2ent_fault(pent)) {
-			WARN(1, "Trying mapping on 4KiB where mapping exists");
+		if (WARN_ON(!lv2ent_fault(pent)))
 			return -EADDRINUSE;
-		}
 
 		*pent = mk_lv2ent_spage(paddr);
 		pgtable_flush(pent, pent + 1);
@@ -1123,9 +1121,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 	} else { /* size == LPAGE_SIZE */
 		int i;
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
-			if (!lv2ent_fault(pent)) {
-				WARN(1,
-				"Trying mapping on 64KiB where mapping exists");
+			if (WARN_ON(!lv2ent_fault(pent))) {
 				if (i > 0)
 					memset(pent - i, 0, sizeof(*pent) * i);
 				return -EADDRINUSE;
@@ -1198,8 +1194,8 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 	}
 
 	if (ret)
-		pr_debug("%s: Failed to map iova %#x/%#zx bytes\n",
-							__func__, iova, size);
+		pr_err("%s: Failed(%d) to map %#zx bytes @ %#x\n",
+			__func__, ret, size, iova);
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
@@ -1236,7 +1232,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	ent = section_entry(priv->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
-		if (size < SECT_SIZE) {
+		if (WARN_ON(size < SECT_SIZE)) {
 			err_pgsize = SECT_SIZE;
 			goto err;
 		}
@@ -1271,7 +1267,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	}
 
 	/* lv1ent_large(ent) == true here */
-	if (size < LPAGE_SIZE) {
+	if (WARN_ON(size < LPAGE_SIZE)) {
 		err_pgsize = LPAGE_SIZE;
 		goto err;
 	}
@@ -1290,9 +1286,8 @@ done:
 err:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
-	WARN(1,
-	"%s: Failed due to size(%#zx) @ %#x is smaller than page size %#zx\n",
-	__func__, size, iova, err_pgsize);
+	pr_err("%s: Failed: size(%#zx) @ %#x is smaller than page size %#zx\n",
+		__func__, size, iova, err_pgsize);
 
 	return 0;
 }
-- 
1.7.9.5
