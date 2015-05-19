From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 08/25] iommu/exynos: Rename variables to reflect their
 purpose
Date: Tue, 19 May 2015 15:20:28 +0200
Message-ID: <1432041645-11172-9-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch renames some variables to make the code easier to understand.
'domain' is replaced by 'iommu_domain' (more generic entity) and really
meaningless 'priv' by 'domain' to reflect its purpose.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 187 ++++++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 741149622db3..1cb3c27e9125 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -435,8 +435,8 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 		clk_disable(data->clk_master);
 }
 
-static int __sysmmu_enable(struct sysmmu_drvdata *data,
-			phys_addr_t pgtable, struct iommu_domain *domain)
+static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
+			   struct iommu_domain *iommu_domain)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -444,7 +444,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
-		data->domain = domain;
+		data->domain = iommu_domain;
 
 		__sysmmu_enable_nocount(data);
 
@@ -609,91 +609,91 @@ static inline void pgtable_flush(void *vastart, void *vaend)
 
 static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 {
-	struct exynos_iommu_domain *exynos_domain;
+	struct exynos_iommu_domain *domain;
 	int i;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
-	exynos_domain = kzalloc(sizeof(*exynos_domain), GFP_KERNEL);
-	if (!exynos_domain)
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
 		return NULL;
 
-	exynos_domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
-	if (!exynos_domain->pgtable)
+	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	if (!domain->pgtable)
 		goto err_pgtable;
 
-	exynos_domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
-	if (!exynos_domain->lv2entcnt)
+	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	if (!domain->lv2entcnt)
 		goto err_counter;
 
 	/* Workaround for System MMU v3.3 to prevent caching 1MiB mapping */
 	for (i = 0; i < NUM_LV1ENTRIES; i += 8) {
-		exynos_domain->pgtable[i + 0] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 1] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 2] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 3] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 4] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 5] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 6] = ZERO_LV2LINK;
-		exynos_domain->pgtable[i + 7] = ZERO_LV2LINK;
+		domain->pgtable[i + 0] = ZERO_LV2LINK;
+		domain->pgtable[i + 1] = ZERO_LV2LINK;
+		domain->pgtable[i + 2] = ZERO_LV2LINK;
+		domain->pgtable[i + 3] = ZERO_LV2LINK;
+		domain->pgtable[i + 4] = ZERO_LV2LINK;
+		domain->pgtable[i + 5] = ZERO_LV2LINK;
+		domain->pgtable[i + 6] = ZERO_LV2LINK;
+		domain->pgtable[i + 7] = ZERO_LV2LINK;
 	}
 
-	pgtable_flush(exynos_domain->pgtable, exynos_domain->pgtable + NUM_LV1ENTRIES);
+	pgtable_flush(domain->pgtable, domain->pgtable + NUM_LV1ENTRIES);
 
-	spin_lock_init(&exynos_domain->lock);
-	spin_lock_init(&exynos_domain->pgtablelock);
-	INIT_LIST_HEAD(&exynos_domain->clients);
+	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->pgtablelock);
+	INIT_LIST_HEAD(&domain->clients);
 
-	exynos_domain->domain.geometry.aperture_start = 0;
-	exynos_domain->domain.geometry.aperture_end   = ~0UL;
-	exynos_domain->domain.geometry.force_aperture = true;
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end   = ~0UL;
+	domain->domain.geometry.force_aperture = true;
 
-	return &exynos_domain->domain;
+	return &domain->domain;
 
 err_counter:
-	free_pages((unsigned long)exynos_domain->pgtable, 2);
+	free_pages((unsigned long)domain->pgtable, 2);
 err_pgtable:
-	kfree(exynos_domain);
+	kfree(domain);
 	return NULL;
 }
 
-static void exynos_iommu_domain_free(struct iommu_domain *domain)
+static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 {
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	int i;
 
-	WARN_ON(!list_empty(&priv->clients));
+	WARN_ON(!list_empty(&domain->clients));
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&domain->lock, flags);
 
-	list_for_each_entry_safe(data, next, &priv->clients, domain_node) {
+	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
 		if (__sysmmu_disable(data))
 			data->master = NULL;
 		list_del_init(&data->domain_node);
 	}
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
-		if (lv1ent_page(priv->pgtable + i))
+		if (lv1ent_page(domain->pgtable + i))
 			kmem_cache_free(lv2table_kmem_cache,
-				phys_to_virt(lv2table_base(priv->pgtable + i)));
+				phys_to_virt(lv2table_base(domain->pgtable + i)));
 
-	free_pages((unsigned long)priv->pgtable, 2);
-	free_pages((unsigned long)priv->lv2entcnt, 1);
-	kfree(priv);
+	free_pages((unsigned long)domain->pgtable, 2);
+	free_pages((unsigned long)domain->lv2entcnt, 1);
+	kfree(domain);
 }
 
-static int exynos_iommu_attach_device(struct iommu_domain *domain,
+static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 				   struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	struct sysmmu_drvdata *data;
-	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
+	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
 	int ret = -ENODEV;
 
@@ -702,13 +702,13 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 
 	data = dev_get_drvdata(owner->sysmmu);
 	if (data) {
-		ret = __sysmmu_enable(data, pagetable, domain);
+		ret = __sysmmu_enable(data, pagetable, iommu_domain);
 		if (ret >= 0) {
 			data->master = dev;
 
-			spin_lock_irqsave(&priv->lock, flags);
-			list_add_tail(&data->domain_node, &priv->clients);
-			spin_unlock_irqrestore(&priv->lock, flags);
+			spin_lock_irqsave(&domain->lock, flags);
+			list_add_tail(&data->domain_node, &domain->clients);
+			spin_unlock_irqrestore(&domain->lock, flags);
 		}
 	}
 
@@ -724,11 +724,11 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static void exynos_iommu_detach_device(struct iommu_domain *domain,
+static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 				    struct device *dev)
 {
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
-	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
+	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	struct sysmmu_drvdata *data;
 	unsigned long flags;
 	bool found = false;
@@ -736,8 +736,8 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 	if (!has_sysmmu(dev))
 		return;
 
-	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(data, &priv->clients, domain_node) {
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(data, &domain->clients, domain_node) {
 		if (data->master == dev) {
 			if (__sysmmu_disable(data)) {
 				data->master = NULL;
@@ -747,7 +747,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	if (found)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
@@ -756,7 +756,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
 }
 
-static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
+static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		sysmmu_pte_t *sent, sysmmu_iova_t iova, short *pgcounter)
 {
 	if (lv1ent_section(sent)) {
@@ -798,17 +798,17 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
 		if (need_flush_flpd_cache) {
 			struct sysmmu_drvdata *data;
 
-			spin_lock(&priv->lock);
-			list_for_each_entry(data, &priv->clients, domain_node)
+			spin_lock(&domain->lock);
+			list_for_each_entry(data, &domain->clients, domain_node)
 				sysmmu_tlb_invalidate_flpdcache(data, iova);
-			spin_unlock(&priv->lock);
+			spin_unlock(&domain->lock);
 		}
 	}
 
 	return page_entry(sent, iova);
 }
 
-static int lv1set_section(struct exynos_iommu_domain *priv,
+static int lv1set_section(struct exynos_iommu_domain *domain,
 			  sysmmu_pte_t *sent, sysmmu_iova_t iova,
 			  phys_addr_t paddr, short *pgcnt)
 {
@@ -833,17 +833,17 @@ static int lv1set_section(struct exynos_iommu_domain *priv,
 
 	pgtable_flush(sent, sent + 1);
 
-	spin_lock(&priv->lock);
+	spin_lock(&domain->lock);
 	if (lv1ent_page_zero(sent)) {
 		struct sysmmu_drvdata *data;
 		/*
 		 * Flushing FLPD cache in System MMU v3.3 that may cache a FLPD
 		 * entry by speculative prefetch of SLPD which has no mapping.
 		 */
-		list_for_each_entry(data, &priv->clients, domain_node)
+		list_for_each_entry(data, &domain->clients, domain_node)
 			sysmmu_tlb_invalidate_flpdcache(data, iova);
 	}
-	spin_unlock(&priv->lock);
+	spin_unlock(&domain->lock);
 
 	return 0;
 }
@@ -903,74 +903,75 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
  *   than or equal to 128KiB.
  * - Start address of an I/O virtual region must be aligned by 128KiB.
  */
-static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
-			 phys_addr_t paddr, size_t size, int prot)
+static int exynos_iommu_map(struct iommu_domain *iommu_domain,
+			    unsigned long l_iova, phys_addr_t paddr, size_t size,
+			    int prot)
 {
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	unsigned long flags;
 	int ret = -ENOMEM;
 
-	BUG_ON(priv->pgtable == NULL);
+	BUG_ON(domain->pgtable == NULL);
 
-	spin_lock_irqsave(&priv->pgtablelock, flags);
+	spin_lock_irqsave(&domain->pgtablelock, flags);
 
-	entry = section_entry(priv->pgtable, iova);
+	entry = section_entry(domain->pgtable, iova);
 
 	if (size == SECT_SIZE) {
-		ret = lv1set_section(priv, entry, iova, paddr,
-					&priv->lv2entcnt[lv1ent_offset(iova)]);
+		ret = lv1set_section(domain, entry, iova, paddr,
+				     &domain->lv2entcnt[lv1ent_offset(iova)]);
 	} else {
 		sysmmu_pte_t *pent;
 
-		pent = alloc_lv2entry(priv, entry, iova,
-					&priv->lv2entcnt[lv1ent_offset(iova)]);
+		pent = alloc_lv2entry(domain, entry, iova,
+				      &domain->lv2entcnt[lv1ent_offset(iova)]);
 
 		if (IS_ERR(pent))
 			ret = PTR_ERR(pent);
 		else
 			ret = lv2set_page(pent, paddr, size,
-					&priv->lv2entcnt[lv1ent_offset(iova)]);
+				       &domain->lv2entcnt[lv1ent_offset(iova)]);
 	}
 
 	if (ret)
 		pr_err("%s: Failed(%d) to map %#zx bytes @ %#x\n",
 			__func__, ret, size, iova);
 
-	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+	spin_unlock_irqrestore(&domain->pgtablelock, flags);
 
 	return ret;
 }
 
-static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *priv,
-						sysmmu_iova_t iova, size_t size)
+static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *domain,
+					      sysmmu_iova_t iova, size_t size)
 {
 	struct sysmmu_drvdata *data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&domain->lock, flags);
 
-	list_for_each_entry(data, &priv->clients, domain_node)
+	list_for_each_entry(data, &domain->clients, domain_node)
 		sysmmu_tlb_invalidate_entry(data, iova, size);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static size_t exynos_iommu_unmap(struct iommu_domain *domain,
-					unsigned long l_iova, size_t size)
+static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
+				 unsigned long l_iova, size_t size)
 {
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	sysmmu_pte_t *ent;
 	size_t err_pgsize;
 	unsigned long flags;
 
-	BUG_ON(priv->pgtable == NULL);
+	BUG_ON(domain->pgtable == NULL);
 
-	spin_lock_irqsave(&priv->pgtablelock, flags);
+	spin_lock_irqsave(&domain->pgtablelock, flags);
 
-	ent = section_entry(priv->pgtable, iova);
+	ent = section_entry(domain->pgtable, iova);
 
 	if (lv1ent_section(ent)) {
 		if (WARN_ON(size < SECT_SIZE)) {
@@ -1004,7 +1005,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 		*ent = 0;
 		size = SPAGE_SIZE;
 		pgtable_flush(ent, ent + 1);
-		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
+		domain->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
 	}
 
@@ -1018,15 +1019,15 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
-	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
+	domain->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
 done:
-	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+	spin_unlock_irqrestore(&domain->pgtablelock, flags);
 
-	exynos_iommu_tlb_invalidate_entry(priv, iova, size);
+	exynos_iommu_tlb_invalidate_entry(domain, iova, size);
 
 	return size;
 err:
-	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+	spin_unlock_irqrestore(&domain->pgtablelock, flags);
 
 	pr_err("%s: Failed: size(%#zx) @ %#x is smaller than page size %#zx\n",
 		__func__, size, iova, err_pgsize);
@@ -1034,17 +1035,17 @@ err:
 	return 0;
 }
 
-static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
+static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 					  dma_addr_t iova)
 {
-	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
 	unsigned long flags;
 	phys_addr_t phys = 0;
 
-	spin_lock_irqsave(&priv->pgtablelock, flags);
+	spin_lock_irqsave(&domain->pgtablelock, flags);
 
-	entry = section_entry(priv->pgtable, iova);
+	entry = section_entry(domain->pgtable, iova);
 
 	if (lv1ent_section(entry)) {
 		phys = section_phys(entry) + section_offs(iova);
@@ -1057,7 +1058,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 			phys = spage_phys(entry) + spage_offs(iova);
 	}
 
-	spin_unlock_irqrestore(&priv->pgtablelock, flags);
+	spin_unlock_irqrestore(&domain->pgtablelock, flags);
 
 	return phys;
 }
-- 
1.9.2
