From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v13 17/19] iommu/exynos: support for device tree
Date: Mon, 12 May 2014 11:45:02 +0530
Message-ID: <1399875304-19948-18-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1399875304-19948-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This commit adds device tree support for System MMU.

Also, system mmu handling is improved. Previously, an IOMMU domain is
bound to a System MMU which is not correct. This patch binds an IOMMU
domain with the master device of a System MMU.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |  283 +++++++++++++++++++++++-------------------
 1 file changed, 158 insertions(+), 125 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7188b47..b937490 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -114,6 +114,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_PB1_SADDR		0x054
 #define REG_PB1_EADDR		0x058
 
+#define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
+
 static struct kmem_cache *lv2table_kmem_cache;
 
 static sysmmu_pte_t *section_entry(sysmmu_pte_t *pgtable, sysmmu_iova_t iova)
@@ -163,6 +165,16 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 	"UNKNOWN FAULT"
 };
 
+/* attached to dev.archdata.iommu of the master device */
+struct exynos_iommu_owner {
+	struct list_head client; /* entry of exynos_iommu_domain.clients */
+	struct device *dev;
+	struct device *sysmmu;
+	struct iommu_domain *domain;
+	void *vmm_data;         /* IO virtual memory manager's data */
+	spinlock_t lock;        /* Lock to preserve consistency of System MMU */
+};
+
 struct exynos_iommu_domain {
 	struct list_head clients; /* list of sysmmu_drvdata.node */
 	sysmmu_pte_t *pgtable; /* lv1 page table, 16KB */
@@ -172,9 +184,8 @@ struct exynos_iommu_domain {
 };
 
 struct sysmmu_drvdata {
-	struct list_head node; /* entry of exynos_iommu_domain.clients */
 	struct device *sysmmu;	/* System MMU's device descriptor */
-	struct device *dev;	/* Owner of system MMU */
+	struct device *master;	/* Owner of system MMU */
 	void __iomem *sfrbase;
 	struct clk *clk;
 	struct clk *clk_master;
@@ -243,7 +254,6 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
 static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 				       phys_addr_t pgd)
 {
-	__raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, LRU */
 	__raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
 
 	__sysmmu_tlb_invalidate(sfrbase);
@@ -305,7 +315,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 					itype, base, addr);
 		if (data->domain)
 			ret = report_iommu_fault(data->domain,
-					data->dev, addr, itype);
+					data->master, addr, itype);
 	}
 
 	/* fault is not recovered by fault handler */
@@ -323,120 +333,152 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
+static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 {
-	unsigned long flags;
-	bool disabled = false;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	if (!set_sysmmu_inactive(data))
-		goto finish;
-
 	if (!IS_ERR(data->clk_master))
 		clk_enable(data->clk_master);
 
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
+	__raw_writel(0, data->sfrbase + REG_MMU_CFG);
 
 	clk_disable(data->clk);
 	if (!IS_ERR(data->clk_master))
 		clk_disable(data->clk_master);
-
-	disabled = true;
-	data->pgtable = 0;
-	data->domain = NULL;
-finish:
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	if (disabled)
-		dev_dbg(data->sysmmu, "Disabled\n");
-	else
-		dev_dbg(data->sysmmu, "%d times left to be disabled\n",
-					data->activations);
-
-	return disabled;
 }
 
-/* __exynos_sysmmu_enable: Enables System MMU
- *
- * returns -error if an error occurred and System MMU is not enabled,
- * 0 if the System MMU has been just enabled and 1 if System MMU was already
- * enabled before.
- */
-static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
-			phys_addr_t pgtable, struct iommu_domain *domain)
+static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 {
-	int ret = 0;
+	bool disabled;
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	if (!set_sysmmu_active(data)) {
-		if (WARN_ON(pgtable != data->pgtable)) {
-			ret = -EBUSY;
-			set_sysmmu_inactive(data);
-		} else {
-			ret = 1;
-		}
+	disabled = set_sysmmu_inactive(data);
+
+	if (disabled) {
+		data->pgtable = 0;
+		data->domain = NULL;
+
+		__sysmmu_disable_nocount(data);
 
-		dev_dbg(data->sysmmu, "Already enabled\n");
-		goto finish;
+		dev_dbg(data->sysmmu, "Disabled\n");
+	} else  {
+		dev_dbg(data->sysmmu, "%d times left to disable\n",
+					data->activations);
 	}
 
-	data->pgtable = pgtable;
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return disabled;
+}
 
+static void __sysmmu_init_config(struct sysmmu_drvdata *data)
+{
+	unsigned int cfg = 0;
+
+	__raw_writel(cfg, data->sfrbase + REG_MMU_CFG);
+}
+
+static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
+{
 	if (!IS_ERR(data->clk_master))
 		clk_enable(data->clk_master);
 	clk_enable(data->clk);
 
-	__sysmmu_set_ptbase(data->sfrbase, pgtable);
+	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+
+	__sysmmu_init_config(data);
+
+	__sysmmu_set_ptbase(data->sfrbase, data->pgtable);
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
 	if (!IS_ERR(data->clk_master))
 		clk_disable(data->clk_master);
+}
 
-	data->domain = domain;
+static int __sysmmu_enable(struct sysmmu_drvdata *data,
+			phys_addr_t pgtable, struct iommu_domain *domain)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (set_sysmmu_active(data)) {
+		data->pgtable = pgtable;
+		data->domain = domain;
+
+		__sysmmu_enable_nocount(data);
+
+		dev_dbg(data->sysmmu, "Enabled\n");
+	} else {
+		ret = (pgtable == data->pgtable) ? 1 : -EBUSY;
+
+		dev_dbg(data->sysmmu, "already enabled\n");
+	}
+
+	if (WARN_ON(ret < 0))
+		set_sysmmu_inactive(data); /* decrement count */
 
-	dev_dbg(data->sysmmu, "Enabled\n");
-finish:
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
 
-int exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable)
+/* __exynos_sysmmu_enable: Enables System MMU
+ *
+ * returns -error if an error occurred and System MMU is not enabled,
+ * 0 if the System MMU has been just enabled and 1 if System MMU was already
+ * enabled before.
+ */
+static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
+				  struct iommu_domain *domain)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-	int ret;
+	int ret = 0;
+	unsigned long flags;
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct sysmmu_drvdata *data;
 
-	BUG_ON(!memblock_is_memory(pgtable));
+	BUG_ON(!has_sysmmu(dev));
 
-	ret = pm_runtime_get_sync(data->sysmmu);
-	if (ret < 0) {
-		dev_dbg(data->sysmmu, "Failed to enable\n");
-		return ret;
-	}
+	spin_lock_irqsave(&owner->lock, flags);
 
-	ret = __exynos_sysmmu_enable(data, pgtable, NULL);
-	if (WARN_ON(ret < 0)) {
-		pm_runtime_put(data->sysmmu);
-		dev_err(data->sysmmu, "Already enabled with page table %#x\n",
-			data->pgtable);
-	} else {
-		data->dev = dev;
-	}
+	data = dev_get_drvdata(owner->sysmmu);
+
+	ret = __sysmmu_enable(data, pgtable, domain);
+	if (ret >= 0)
+		data->master = dev;
+
+	spin_unlock_irqrestore(&owner->lock, flags);
 
 	return ret;
 }
 
+int exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable)
+{
+	BUG_ON(!memblock_is_memory(pgtable));
+
+	return __exynos_sysmmu_enable(dev, pgtable, NULL);
+}
+
 static bool exynos_sysmmu_disable(struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-	bool disabled;
+	unsigned long flags;
+	bool disabled = true;
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct sysmmu_drvdata *data;
+
+	BUG_ON(!has_sysmmu(dev));
 
-	disabled = __exynos_sysmmu_disable(data);
-	pm_runtime_put(data->sysmmu);
+	spin_lock_irqsave(&owner->lock, flags);
+
+	data = dev_get_drvdata(owner->sysmmu);
+
+	disabled = __sysmmu_disable(data);
+	if (disabled)
+		data->master = NULL;
+
+	spin_unlock_irqrestore(&owner->lock, flags);
 
 	return disabled;
 }
@@ -444,11 +486,13 @@ static bool exynos_sysmmu_disable(struct device *dev)
 static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 					size_t size)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	unsigned long flags;
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct sysmmu_drvdata *data;
 
-	spin_lock_irqsave(&data->lock, flags);
+	data = dev_get_drvdata(owner->sysmmu);
 
+	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data)) {
 		unsigned int maj;
 		unsigned int num_inv = 1;
@@ -478,19 +522,21 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 		if (!IS_ERR(data->clk_master))
 			clk_disable(data->clk_master);
 	} else {
-		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
+		dev_dbg(dev, "disabled. Skipping TLB invalidation @ %#x\n",
+			iova);
 	}
-
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 void exynos_sysmmu_tlb_invalidate(struct device *dev)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	unsigned long flags;
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct sysmmu_drvdata *data;
 
-	spin_lock_irqsave(&data->lock, flags);
+	data = dev_get_drvdata(owner->sysmmu);
 
+	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data)) {
 		if (!IS_ERR(data->clk_master))
 			clk_enable(data->clk_master);
@@ -501,13 +547,12 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 		if (!IS_ERR(data->clk_master))
 			clk_disable(data->clk_master);
 	} else {
-		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
+		dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 	}
-
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static int exynos_sysmmu_probe(struct platform_device *pdev)
+static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
 	int irq, ret;
 	struct device *dev = &pdev->dev;
@@ -560,7 +605,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
-	INIT_LIST_HEAD(&data->node);
 
 	platform_set_drvdata(pdev, data);
 
@@ -569,11 +613,17 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver exynos_sysmmu_driver = {
-	.probe		= exynos_sysmmu_probe,
-	.driver		= {
+static const struct of_device_id sysmmu_of_match[] __initconst = {
+	{ .compatible	= "samsung,exynos-sysmmu", },
+	{ },
+};
+
+static struct platform_driver exynos_sysmmu_driver __refdata = {
+	.probe	= exynos_sysmmu_probe,
+	.driver	= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.of_match_table	= sysmmu_of_match,
 	}
 };
 
@@ -625,7 +675,7 @@ err_pgtable:
 static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct sysmmu_drvdata *data;
+	struct exynos_iommu_owner *owner;
 	unsigned long flags;
 	int i;
 
@@ -633,11 +683,14 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each_entry(data, &priv->clients, node) {
-		while (!exynos_sysmmu_disable(data->dev))
+	list_for_each_entry(owner, &priv->clients, client) {
+		while (!exynos_sysmmu_disable(owner->dev))
 			; /* until System MMU is actually disabled */
 	}
 
+	while (!list_empty(&priv->clients))
+		list_del_init(priv->clients.next);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
@@ -654,27 +707,18 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 static int exynos_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *priv = domain->priv;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
 	int ret;
 
-	ret = pm_runtime_get_sync(data->sysmmu);
-	if (ret < 0)
-		return ret;
-
-	ret = 0;
-
 	spin_lock_irqsave(&priv->lock, flags);
 
-	ret = __exynos_sysmmu_enable(data, pagetable, domain);
-
+	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
 	if (ret == 0) {
-		/* 'data->node' must not be appeared in priv->clients */
-		BUG_ON(!list_empty(&data->node));
-		data->dev = dev;
-		list_add_tail(&data->node, &priv->clients);
+		list_add_tail(&owner->client, &priv->clients);
+		owner->domain = domain;
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -682,7 +726,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	if (ret < 0) {
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
 					__func__, &pagetable);
-		pm_runtime_put(data->sysmmu);
 		return ret;
 	}
 
@@ -695,40 +738,30 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct exynos_iommu_owner *owner;
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct list_head *pos;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
-	bool found = false;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each(pos, &priv->clients) {
-		if (list_entry(pos, struct sysmmu_drvdata, node) == data) {
-			found = true;
+	list_for_each_entry(owner, &priv->clients, client) {
+		if (owner == dev->archdata.iommu) {
+			if (exynos_sysmmu_disable(dev)) {
+				list_del_init(&owner->client);
+				owner->domain = NULL;
+			}
 			break;
 		}
 	}
 
-	if (!found)
-		goto finish;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (__exynos_sysmmu_disable(data)) {
+	if (owner == dev->archdata.iommu)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
 					__func__, &pagetable);
-		list_del_init(&data->node);
-
-	} else {
-		dev_dbg(dev, "%s: Detaching IOMMU with pgtable %pa delayed",
-					__func__, &pagetable);
-	}
-
-finish:
-	spin_unlock_irqrestore(&priv->lock, flags);
-
-	if (found)
-		pm_runtime_put(data->sysmmu);
+	else
+		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
 }
 
 static sysmmu_pte_t *alloc_lv2entry(sysmmu_pte_t *sent, sysmmu_iova_t iova,
@@ -855,7 +888,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 					unsigned long l_iova, size_t size)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct sysmmu_drvdata *data;
+	struct exynos_iommu_owner *owner;
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
 	sysmmu_pte_t *ent;
 	size_t err_pgsize;
@@ -917,8 +950,8 @@ done:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(data, &priv->clients, node)
-		sysmmu_tlb_invalidate_entry(data->dev, iova, size);
+	list_for_each_entry(owner, &priv->clients, client)
+		sysmmu_tlb_invalidate_entry(owner->dev, iova, size);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return size;
-- 
1.7.9.5
