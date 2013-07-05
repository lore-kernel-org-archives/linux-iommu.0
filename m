From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v7 3/9] iommu/exynos: fix page table maintenance
Date: Fri, 05 Jul 2013 21:29:18 +0900
Message-ID: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Grant Grundler' <grundler@chromium.org>
List-Id: iommu@lists.linux-foundation.org

This prevents allocating lv2 page table for the lv1 page table entry
that already has 1MB page mapping. In addition some BUG_ON() is
changed to WARN_ON().

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e3be3e5..2bfe9fa 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
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
@@ -944,16 +946,16 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
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
 
 	if (ret) {
-		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
-							__func__, iova, size);
+		pr_err("%s: Failed(%d) to map iova 0x%#x bytes @ %#lx\n",
+						__func__, ret, size, iova);
 	}
 
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
@@ -968,6 +970,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	struct sysmmu_drvdata *data;
 	unsigned long flags;
 	unsigned long *ent;
+	size_t err_page;
 
 	BUG_ON(priv->pgtable == NULL);
 
@@ -976,7 +979,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	ent = section_entry(priv->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
-		BUG_ON(size < SECT_SIZE);
+		if (WARN_ON(size < SECT_SIZE))
+			goto err;
 
 		*ent = 0;
 		pgtable_flush(ent, ent + 1);
@@ -1008,7 +1012,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	}
 
 	/* lv1ent_large(ent) == true here */
-	BUG_ON(size < LPAGE_SIZE);
+	if (WARN_ON(size < LPAGE_SIZE))
+		goto err;
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
 	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
@@ -1023,8 +1028,21 @@ done:
 		sysmmu_tlb_invalidate_entry(data->dev, iova);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-
 	return size;
+err:
+	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+
+	err_page = (
+		((unsigned long)ent - (unsigned long)priv->pgtable)
+			< (NUM_LV1ENTRIES * sizeof(long))
+			   ) ?  SECT_SIZE : LPAGE_SIZE;
+
+	pr_err("%s: Failed due to size(%#lx) @ %#x is"\
+		" smaller than page size %#x\n",
+		__func__, iova, size, err_page);
+
+	       return 0;
+
 }
 
 static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
1.7.2.5
