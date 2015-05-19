From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 07/25] iommu/exynos: Refactor function parameters to
 simplify code
Date: Tue, 19 May 2015 15:20:27 +0200
Message-ID: <1432041645-11172-8-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch simplifies the code by:
- refactoring function parameters from struct device pointer to direct
  pointer to struct sysmmu drvdata
- moving list_head enteries from struct exynos_iommu_owner directly to
  struct sysmmu_drvdata

After above refactoring some functions were never used, so remove also
them completely.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 134 ++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 86 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4f6090361af1..741149622db3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -186,8 +186,6 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 /* attached to dev.archdata.iommu of the master device */
 struct exynos_iommu_owner {
-	struct list_head client; /* entry of exynos_iommu_domain.clients */
-	struct device *dev;
 	struct device *sysmmu;
 };
 
@@ -209,6 +207,7 @@ struct sysmmu_drvdata {
 	int activations;
 	spinlock_t lock;
 	struct iommu_domain *domain;
+	struct list_head domain_node;
 	phys_addr_t pgtable;
 	unsigned int version;
 };
@@ -464,47 +463,6 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	return ret;
 }
 
-/* __exynos_sysmmu_enable: Enables System MMU
- *
- * returns -error if an error occurred and System MMU is not enabled,
- * 0 if the System MMU has been just enabled and 1 if System MMU was already
- * enabled before.
- */
-static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
-				  struct iommu_domain *domain)
-{
-	int ret = 0;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
-
-	BUG_ON(!has_sysmmu(dev));
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	ret = __sysmmu_enable(data, pgtable, domain);
-	if (ret >= 0)
-		data->master = dev;
-
-	return ret;
-}
-
-static bool exynos_sysmmu_disable(struct device *dev)
-{
-	bool disabled = true;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
-
-	BUG_ON(!has_sysmmu(dev));
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	disabled = __sysmmu_disable(data);
-	if (disabled)
-		data->master = NULL;
-
-	return disabled;
-}
-
 static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					      sysmmu_iova_t iova)
 {
@@ -512,12 +470,10 @@ static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
 }
 
-static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
+static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					    sysmmu_iova_t iova)
 {
 	unsigned long flags;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data = dev_get_drvdata(owner->sysmmu);
 
 	if (!IS_ERR(data->clk_master))
 		clk_enable(data->clk_master);
@@ -531,14 +487,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
 		clk_disable(data->clk_master);
 }
 
-static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
-					size_t size)
+static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
+					sysmmu_iova_t iova, size_t size)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	unsigned long flags;
-	struct sysmmu_drvdata *data;
-
-	data = dev_get_drvdata(owner->sysmmu);
 
 	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data)) {
@@ -568,8 +520,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 		if (!IS_ERR(data->clk_master))
 			clk_disable(data->clk_master);
 	} else {
-		dev_dbg(dev, "disabled. Skipping TLB invalidation @ %#x\n",
-			iova);
+		dev_dbg(data->master,
+			"disabled. Skipping TLB invalidation @ %#x\n", iova);
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
 }
@@ -709,7 +661,7 @@ err_pgtable:
 static void exynos_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
-	struct exynos_iommu_owner *owner;
+	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	int i;
 
@@ -717,14 +669,12 @@ static void exynos_iommu_domain_free(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each_entry(owner, &priv->clients, client) {
-		while (!exynos_sysmmu_disable(owner->dev))
-			; /* until System MMU is actually disabled */
+	list_for_each_entry_safe(data, next, &priv->clients, domain_node) {
+		if (__sysmmu_disable(data))
+			data->master = NULL;
+		list_del_init(&data->domain_node);
 	}
 
-	while (!list_empty(&priv->clients))
-		list_del_init(priv->clients.next);
-
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
@@ -742,17 +692,25 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
+	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
-	int ret;
+	int ret = -ENODEV;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	if (!has_sysmmu(dev))
+		return -ENODEV;
 
-	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
-	if (ret == 0)
-		list_add_tail(&owner->client, &priv->clients);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
+	data = dev_get_drvdata(owner->sysmmu);
+	if (data) {
+		ret = __sysmmu_enable(data, pagetable, domain);
+		if (ret >= 0) {
+			data->master = dev;
+
+			spin_lock_irqsave(&priv->lock, flags);
+			list_add_tail(&data->domain_node, &priv->clients);
+			spin_unlock_irqrestore(&priv->lock, flags);
+		}
+	}
 
 	if (ret < 0) {
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
@@ -769,24 +727,29 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct exynos_iommu_owner *owner;
 	struct exynos_iommu_domain *priv = to_exynos_domain(domain);
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
+	struct sysmmu_drvdata *data;
 	unsigned long flags;
+	bool found = false;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	if (!has_sysmmu(dev))
+		return;
 
-	list_for_each_entry(owner, &priv->clients, client) {
-		if (owner == dev->archdata.iommu) {
-			if (exynos_sysmmu_disable(dev))
-				list_del_init(&owner->client);
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry(data, &priv->clients, domain_node) {
+		if (data->master == dev) {
+			if (__sysmmu_disable(data)) {
+				data->master = NULL;
+				list_del_init(&data->domain_node);
+			}
+			found = true;
 			break;
 		}
 	}
-
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (owner == dev->archdata.iommu)
+	if (found)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
 					__func__, &pagetable);
 	else
@@ -833,12 +796,11 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
 		 * not currently mapped.
 		 */
 		if (need_flush_flpd_cache) {
-			struct exynos_iommu_owner *owner;
+			struct sysmmu_drvdata *data;
 
 			spin_lock(&priv->lock);
-			list_for_each_entry(owner, &priv->clients, client)
-				sysmmu_tlb_invalidate_flpdcache(
-							owner->dev, iova);
+			list_for_each_entry(data, &priv->clients, domain_node)
+				sysmmu_tlb_invalidate_flpdcache(data, iova);
 			spin_unlock(&priv->lock);
 		}
 	}
@@ -873,13 +835,13 @@ static int lv1set_section(struct exynos_iommu_domain *priv,
 
 	spin_lock(&priv->lock);
 	if (lv1ent_page_zero(sent)) {
-		struct exynos_iommu_owner *owner;
+		struct sysmmu_drvdata *data;
 		/*
 		 * Flushing FLPD cache in System MMU v3.3 that may cache a FLPD
 		 * entry by speculative prefetch of SLPD which has no mapping.
 		 */
-		list_for_each_entry(owner, &priv->clients, client)
-			sysmmu_tlb_invalidate_flpdcache(owner->dev, iova);
+		list_for_each_entry(data, &priv->clients, domain_node)
+			sysmmu_tlb_invalidate_flpdcache(data, iova);
 	}
 	spin_unlock(&priv->lock);
 
@@ -984,13 +946,13 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
 static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *priv,
 						sysmmu_iova_t iova, size_t size)
 {
-	struct exynos_iommu_owner *owner;
+	struct sysmmu_drvdata *data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each_entry(owner, &priv->clients, client)
-		sysmmu_tlb_invalidate_entry(owner->dev, iova, size);
+	list_for_each_entry(data, &priv->clients, domain_node)
+		sysmmu_tlb_invalidate_entry(data, iova, size);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
-- 
1.9.2
