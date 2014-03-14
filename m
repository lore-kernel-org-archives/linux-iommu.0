From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 03/27] iommu/exynos: change error handling when page table
	update is failed
Date: Fri, 14 Mar 2014 14:02:43 +0900
Message-ID: <20140314140243.853cb1fc76afdc7e713c58da@samsung.com>
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

This patch changes not to panic on any error when updating page table.
Instead prints error messages with callstack.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   58 ++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 1c3a397..4a74ed8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -812,13 +812,18 @@ finish:
 static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 					short *pgcounter)
 {
+	if (lv1ent_section(sent)) {
+		WARN(1, "Trying mapping on %#08lx mapped with 1MiB page", iova);
+		return ERR_PTR(-EADDRINUSE);
+	}
+
 	if (lv1ent_fault(sent)) {
 		unsigned long *pent;
 
 		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 
 		*sent = mk_lv1ent_page(__pa(pent));
 		*pgcounter = NUM_LV2ENTRIES;
@@ -829,14 +834,21 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	return page_entry(sent, iova);
 }
 
-static int lv1set_section(unsigned long *sent, phys_addr_t paddr, short *pgcnt)
+static int lv1set_section(unsigned long *sent, unsigned long iova,
+			  phys_addr_t paddr, short *pgcnt)
 {
-	if (lv1ent_section(sent))
+	if (lv1ent_section(sent)) {
+		WARN(1, "Trying mapping on 1MiB@%#08lx that is mapped",
+			iova);
 		return -EADDRINUSE;
+	}
 
 	if (lv1ent_page(sent)) {
-		if (*pgcnt != NUM_LV2ENTRIES)
+		if (*pgcnt != NUM_LV2ENTRIES) {
+			WARN(1, "Trying mapping on 1MiB@%#08lx that is mapped",
+				iova);
 			return -EADDRINUSE;
+		}
 
 		kfree(page_entry(sent, 0));
 
@@ -854,8 +866,10 @@ static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
 								short *pgcnt)
 {
 	if (size == SPAGE_SIZE) {
-		if (!lv2ent_fault(pent))
+		if (!lv2ent_fault(pent)) {
+			WARN(1, "Trying mapping on 4KiB where mapping exists");
 			return -EADDRINUSE;
+		}
 
 		*pent = mk_lv2ent_spage(paddr);
 		pgtable_flush(pent, pent + 1);
@@ -864,7 +878,10 @@ static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
 		int i;
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
 			if (!lv2ent_fault(pent)) {
-				memset(pent, 0, sizeof(*pent) * i);
+				WARN(1,
+				"Trying mapping on 64KiB where mapping exists");
+				if (i > 0)
+					memset(pent - i, 0, sizeof(*pent) * i);
 				return -EADDRINUSE;
 			}
 
@@ -892,7 +909,7 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	entry = section_entry(priv->pgtable, iova);
 
 	if (size == SECT_SIZE) {
-		ret = lv1set_section(entry, paddr,
+		ret = lv1set_section(entry, iova, paddr,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 	} else {
 		unsigned long *pent;
@@ -900,17 +917,16 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pent = alloc_lv2entry(entry, iova,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 
-		if (!pent)
-			ret = -ENOMEM;
+		if (IS_ERR(pent))
+			ret = PTR_ERR(pent);
 		else
 			ret = lv2set_page(pent, paddr, size,
 					&priv->lv2entcnt[lv1ent_offset(iova)]);
 	}
 
-	if (ret) {
+	if (ret)
 		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
 							__func__, iova, size);
-	}
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
@@ -924,6 +940,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	struct sysmmu_drvdata *data;
 	unsigned long flags;
 	unsigned long *ent;
+	size_t err_pgsize;
 
 	BUG_ON(priv->pgtable == NULL);
 
@@ -932,7 +949,10 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	ent = section_entry(priv->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
-		BUG_ON(size < SECT_SIZE);
+		if (size < SECT_SIZE) {
+			err_pgsize = SECT_SIZE;
+			goto err;
+		}
 
 		*ent = 0;
 		pgtable_flush(ent, ent + 1);
@@ -964,7 +984,10 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	}
 
 	/* lv1ent_large(ent) == true here */
-	BUG_ON(size < LPAGE_SIZE);
+	if (size < LPAGE_SIZE) {
+		err_pgsize = LPAGE_SIZE;
+		goto err;
+	}
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
 	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
@@ -979,8 +1002,15 @@ done:
 		sysmmu_tlb_invalidate_entry(data->dev, iova);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-
 	return size;
+err:
+	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+
+	WARN(1,
+	"%s: Failed due to size(%#x) @ %#08lx is smaller than page size %#x\n",
+	__func__, size, iova, err_pgsize);
+
+	return 0;
 }
 
 static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
1.7.9.5
