From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v12 21/31] iommu/exynos: fix address handling
Date: Sun, 27 Apr 2014 13:07:53 +0530
Message-ID: <1398584283-22846-22-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Use of __pa and __va macro is changed to virt_to_phys and phys_to_virt
which are recommended in driver code. printk formatting of physical
address is also fixed to %pa.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5c7f4d2..08a7ce0 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -131,7 +131,8 @@ static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
 
 static unsigned long *page_entry(unsigned long *sent, unsigned long iova)
 {
-	return (unsigned long *)__va(lv2table_base(sent)) + lv2ent_offset(iova);
+	return (unsigned long *)phys_to_virt(
+				lv2table_base(sent)) + lv2ent_offset(iova);
 }
 
 enum exynos_sysmmu_inttype {
@@ -204,7 +205,7 @@ struct sysmmu_drvdata {
 	struct iommu_domain *domain;
 	bool powered_on;
 	bool suspended;
-	unsigned long pgtable;
+	phys_addr_t pgtable;
 };
 
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
@@ -296,17 +297,17 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 
 static void show_fault_information(const char *name,
 		enum exynos_sysmmu_inttype itype,
-		unsigned long pgtable_base, unsigned long fault_addr)
+		phys_addr_t pgtable_base, unsigned long fault_addr)
 {
 	unsigned long *ent;
 
 	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
 		itype = SYSMMU_FAULT_UNKNOWN;
 
-	pr_err("%s occurred at 0x%lx by %s(Page table base: 0x%lx)\n",
-		sysmmu_fault_name[itype], fault_addr, name, pgtable_base);
+	pr_err("%s occurred at %#lx by %s(Page table base: %pa)\n",
+		sysmmu_fault_name[itype], fault_addr, name, &pgtable_base);
 
-	ent = section_entry(__va(pgtable_base), fault_addr);
+	ent = section_entry(phys_to_virt(pgtable_base), fault_addr);
 	pr_err("\tLv1 entry: 0x%lx\n", *ent);
 
 	if (lv1ent_page(ent)) {
@@ -909,7 +910,7 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
 			kmem_cache_free(lv2table_kmem_cache,
-					__va(lv2table_base(priv->pgtable + i)));
+				phys_to_virt(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -928,8 +929,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-
-	ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
+	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
 	if (ret == 0) {
 		list_add_tail(&owner->client, &priv->clients);
 		owner->domain = domain;
@@ -937,13 +937,14 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-	else
-		dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa%s\n",
-					__func__, &pagetable,
-					(ret == 0) ? "" : ", again");
+				__func__, &pagetable);
+		return ret;
+	}
+
+	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
+		__func__, &pagetable, (ret == 0) ? "" : ", again");
 
 	return ret;
 }
@@ -993,7 +994,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-		*sent = mk_lv1ent_page(__pa(pent));
+		*sent = mk_lv1ent_page(virt_to_phys(pent));
 		*pgcounter = NUM_LV2ENTRIES;
 		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
 		pgtable_flush(sent, sent + 1);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
