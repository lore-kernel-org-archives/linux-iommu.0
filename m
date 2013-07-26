From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v8 03/12] iommu/exynos: fix page table maintenance
Date: Fri, 26 Jul 2013 20:27:11 +0900
Message-ID: <003901ce89f3$126c0390$37440ab0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This prevents allocating lv2 page table for the lv1 page table entry
that already has 1MB page mapping. In addition some BUG_ON() is
changed to WARN_ON().

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   52 +++++++++++++++++++++++++++++------------
 1 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e3be3e5..6c4ecce 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -52,11 +52,11 @@
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
 #define section_phys(sent) (*(sent) & SECT_MASK)
-#define section_offs(iova) ((iova) & 0xFFFFF)
+#define section_offs(iova) ((iova) & ~SECT_MASK)
 #define lpage_phys(pent) (*(pent) & LPAGE_MASK)
-#define lpage_offs(iova) ((iova) & 0xFFFF)
+#define lpage_offs(iova) ((iova) & ~LPAGE_MASK)
 #define spage_phys(pent) (*(pent) & SPAGE_MASK)
-#define spage_offs(iova) ((iova) & 0xFFF)
+#define spage_offs(iova) ((iova) & ~SPAGE_MASK)
 
 #define lv1ent_offset(iova) ((iova) >> SECT_ORDER)
 #define lv2ent_offset(iova) (((iova) & 0xFF000) >> SPAGE_ORDER)
@@ -862,12 +862,14 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 
 		*sent = mk_lv1ent_page(__pa(pent));
 		*pgcounter = NUM_LV2ENTRIES;
 		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
 		pgtable_flush(sent, sent + 1);
+	} else if (lv1ent_section(sent)) {
+		return ERR_PTR(-EADDRINUSE);
 	}
 
 	return page_entry(sent, iova);
@@ -894,6 +896,12 @@ static int lv1set_section(unsigned long *sent, phys_addr_t paddr, short *pgcnt)
 	return 0;
 }
 
+static void clear_page_table(unsigned long *ent, int n)
+{
+	if (n > 0)
+		memset(ent, 0, sizeof(*ent) * n);
+}
+
 static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
 								short *pgcnt)
 {
@@ -908,7 +916,7 @@ static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_t size,
 		int i;
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
 			if (!lv2ent_fault(pent)) {
-				memset(pent, 0, sizeof(*pent) * i);
+				clear_page_table(pent - i, i);
 				return -EADDRINUSE;
 			}
 
@@ -944,17 +952,16 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
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
-		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
-							__func__, iova, size);
-	}
+	if (ret)
+		pr_err("%s: Failed(%d) to map 0x%#x bytes @ %#lx\n",
+			__func__, ret, size, iova);
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
@@ -968,6 +975,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	struct sysmmu_drvdata *data;
 	unsigned long flags;
 	unsigned long *ent;
+	size_t err_pgsize;
 
 	BUG_ON(priv->pgtable == NULL);
 
@@ -976,7 +984,10 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	ent = section_entry(priv->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
-		BUG_ON(size < SECT_SIZE);
+		if (WARN_ON(size < SECT_SIZE)) {
+			err_pgsize = SECT_SIZE;
+			goto err;
+		}
 
 		*ent = 0;
 		pgtable_flush(ent, ent + 1);
@@ -1008,9 +1019,12 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	}
 
 	/* lv1ent_large(ent) == true here */
-	BUG_ON(size < LPAGE_SIZE);
+	if (WARN_ON(size < LPAGE_SIZE)) {
+		err_pgsize = LPAGE_SIZE;
+		goto err;
+	}
 
-	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
+	clear_page_table(ent, SPAGES_PER_LPAGE);
 	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
@@ -1023,8 +1037,16 @@ done:
 		sysmmu_tlb_invalidate_entry(data->dev, iova);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-
 	return size;
+err:
+	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+
+	pr_err("%s: Failed due to size(%#x) @ %#lx is"\
+		" smaller than page size %#x\n",
+		__func__, size, iova, err_pgsize);
+
+	return 0;
+
 }
 
 static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
1.7.2.5
