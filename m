From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 09/18] iommu: exynos: refactor function parameters to
 simplify code
Date: Tue, 16 Sep 2014 13:54:36 +0200
Message-ID: <1410868485-4143-10-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch simplifies the code by:
- refactoring function parameters from struct device pointer to direct pointer
  to struct sysmmu drvdata
- moving list_head enteries from struct exynos_iommu_owner directly to struct
  sysmmu_drvdata

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 93 ++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index ae2703ed91d8..ef30890f4069 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -186,8 +186,6 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 /* attached to dev.archdata.iommu of the master device */
 struct exynos_iommu_owner {
-	struct list_head client; /* entry of exynos_iommu_domain.clients */
-	struct device *dev;
 	struct device *sysmmu;
 };
 
@@ -208,6 +206,7 @@ struct sysmmu_drvdata {
 	int activations;
 	spinlock_t lock;
 	struct iommu_domain *domain;
+	struct list_head domain_node;
 	phys_addr_t pgtable;
 	int version;
 };
@@ -508,12 +507,10 @@ static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
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
@@ -527,14 +524,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct device *dev,
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
@@ -564,8 +557,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
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
@@ -704,7 +697,7 @@ err_pgtable:
 static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct exynos_iommu_owner *owner;
+	struct sysmmu_drvdata *data;
 	unsigned long flags;
 	int i;
 
@@ -712,14 +705,12 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each_entry(owner, &priv->clients, client) {
-		while (!exynos_sysmmu_disable(owner->dev))
-			; /* until System MMU is actually disabled */
+	list_for_each_entry(data, &priv->clients, domain_node) {
+		if (__sysmmu_disable(data))
+			data->master = NULL;
+		list_del_init(&data->domain_node);
 	}
 
-	while (!list_empty(&priv->clients))
-		list_del_init(priv->clients.next);
-
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
@@ -738,20 +729,26 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *priv = domain->priv;
+	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
-	int ret;
+	int ret = -ENODEV;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	if (!has_sysmmu(dev))
+		return -ENODEV;
 
-	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
-	if (ret == 0) {
-		list_add_tail(&owner->client, &priv->clients);
-		owner->domain = domain;
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
 	}
 
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	if (ret < 0) {
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
 					__func__, &pagetable);
@@ -767,26 +764,29 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct exynos_iommu_owner *owner;
 	struct exynos_iommu_domain *priv = domain->priv;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
+	struct sysmmu_drvdata *data;
 	unsigned long flags;
+	int found = 0;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	if (!has_sysmmu(dev))
+		return;
 
-	list_for_each_entry(owner, &priv->clients, client) {
-		if (owner == dev->archdata.iommu) {
-			if (exynos_sysmmu_disable(dev)) {
-				list_del_init(&owner->client);
-				owner->domain = NULL;
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry(data, &priv->clients, domain_node) {
+		if (data->master == dev) {
+			if (__sysmmu_disable(data)) {
+				data->master = NULL;
+				list_del_init(&data->domain_node);
 			}
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
@@ -833,12 +833,11 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
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
@@ -873,13 +872,13 @@ static int lv1set_section(struct exynos_iommu_domain *priv,
 
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
 
@@ -984,13 +983,13 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long l_iova,
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
