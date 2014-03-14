From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs for
	a master H/W
Date: Fri, 14 Mar 2014 14:10:50 +0900
Message-ID: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
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

Some master device descriptor like fimc-is which is an abstraction
of very complex H/W may have multiple System MMUs. For those devices,
the design of the link between System MMU and its master H/W is needed
to be reconsidered.

A link structure, sysmmu_list_data is introduced that provides a link
to master H/W and that has a pointer to the device descriptor of a
System MMU. Given a device descriptor of a master H/W, it is possible
to traverse all System MMUs that must be controlled along with the
master H/W.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |  534 ++++++++++++++++++++++++++----------------
 1 file changed, 333 insertions(+), 201 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 84ba29a..7489343 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -128,6 +128,10 @@
 #define __master_clk_disable(data)	__clk_gate_ctrl(data, clk_master, dis)
 
 #define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
+#define for_each_sysmmu_list(dev, list_data)				\
+	list_for_each_entry(list_data,					\
+		&((struct exynos_iommu_owner *)dev->archdata.iommu)->mmu_list, \
+		entry)
 
 static struct kmem_cache *lv2table_kmem_cache;
 
@@ -181,7 +185,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 struct exynos_iommu_owner {
 	struct list_head client; /* entry of exynos_iommu_domain.clients */
 	struct device *dev;
-	struct device *sysmmu;
+	struct list_head mmu_list;  /* list of sysmmu_list_data.entry */
 	struct iommu_domain *domain;
 	void *vmm_data;         /* IO virtual memory manager's data */
 	spinlock_t lock;        /* Lock to preserve consistency of System MMU */
@@ -195,6 +199,11 @@ struct exynos_iommu_domain {
 	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
 };
 
+struct sysmmu_list_data {
+	struct list_head entry; /* entry of exynos_iommu_owner.mmu_list */
+	struct device *sysmmu;
+};
+
 struct sysmmu_drvdata {
 	struct device *sysmmu;	/* System MMU's device descriptor */
 	struct device *master;	/* Owner of system MMU */
@@ -205,6 +214,7 @@ struct sysmmu_drvdata {
 	rwlock_t lock;
 	struct iommu_domain *domain;
 	bool runtime_active;
+	bool suspended;
 	unsigned long pgtable;
 };
 
@@ -471,28 +481,39 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 }
 
 /* __exynos_sysmmu_enable: Enables System MMU
- *
- * returns -error if an error occurred and System MMU is not enabled,
- * 0 if the System MMU has been just enabled and 1 if System MMU was already
- * enabled before.
- */
+*
+* returns -error if an error occurred and System MMU is not enabled,
+* 0 if the System MMU has been just enabled and 1 if System MMU was already
+* enabled before.
+*/
 static int __exynos_sysmmu_enable(struct device *dev, unsigned long pgtable,
 				  struct iommu_domain *domain)
 {
 	int ret = 0;
 	unsigned long flags;
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
+	struct sysmmu_list_data *list;
 
 	BUG_ON(!has_sysmmu(dev));
 
 	spin_lock_irqsave(&owner->lock, flags);
 
-	data = dev_get_drvdata(owner->sysmmu);
-
-	ret = __sysmmu_enable(data, pgtable, domain);
-	if (ret >= 0)
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
 		data->master = dev;
+		ret = __sysmmu_enable(data, pgtable, domain);
+		if (ret < 0) {
+			struct sysmmu_list_data *iter;
+			for_each_sysmmu_list(dev, iter) {
+				if (iter->sysmmu == list->sysmmu)
+					break;
+				data = dev_get_drvdata(iter->sysmmu);
+				__sysmmu_disable(data);
+				data->master = NULL;
+			}
+			break;
+		}
+	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
 
@@ -511,17 +532,19 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	unsigned long flags;
 	bool disabled = true;
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
+	struct sysmmu_list_data *list;
 
 	BUG_ON(!has_sysmmu(dev));
 
 	spin_lock_irqsave(&owner->lock, flags);
 
-	data = dev_get_drvdata(owner->sysmmu);
-
-	disabled = __sysmmu_disable(data);
-	if (disabled)
-		data->master = NULL;
+	/* Every call to __sysmmu_disable() must return same result */
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		disabled = __sysmmu_disable(data);
+		if (disabled)
+			data->master = NULL;
+	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
 
@@ -533,185 +556,276 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	unsigned long flags;
-	struct sysmmu_drvdata *data;
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	read_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) && data->runtime_active) {
-		unsigned int num_inv = 1;
+	struct sysmmu_list_data *list;
 
-		__master_clk_enable(data);
-
-		/*
-		 * L2TLB invalidation required
-		 * 4KB page: 1 invalidation
-		 * 64KB page: 16 invalidation
-		 * 1MB page: 64 invalidation
-		 * because it is set-associative TLB
-		 * with 8-way and 64 sets.
-		 * 1MB page can be cached in one of all sets.
-		 * 64KB page can be one of 16 consecutive sets.
-		 */
-		if (__sysmmu_version(data, NULL) == 2) /* major version number */
-			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
+	spin_lock_irqsave(&owner->lock, flags);
 
-		if (sysmmu_block(data->sfrbase)) {
-			__sysmmu_tlb_invalidate_entry(data->sfrbase, iova,
-							num_inv);
-			sysmmu_unblock(data->sfrbase);
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		read_lock(&data->lock);
+		if (is_sysmmu_active(data) && data->runtime_active) {
+			unsigned int num_inv = 1;
+
+			__master_clk_enable(data);
+
+			/*
+			 * L2TLB invalidation required
+			 * 4KB page: 1 invalidation
+			 * 64KB page: 16 invalidation
+			 * 1MB page: 64 invalidation
+			 * because it is set-associative TLB
+			 * with 8-way and 64 sets.
+			 * 1MB page can be cached in one of all sets.
+			 * 64KB page can be one of 16 consecutive sets.
+			 */
+			if (__sysmmu_version(data, NULL) == 2)
+				num_inv = min_t(unsigned int,
+						size / PAGE_SIZE, 64);
+
+			if (sysmmu_block(data->sfrbase)) {
+				__sysmmu_tlb_invalidate_entry(data->sfrbase,
+								iova, num_inv);
+				sysmmu_unblock(data->sfrbase);
+			}
+			__master_clk_disable(data);
+		} else {
+			dev_dbg(dev,
+				"disabled. Skipping TLB invalidation @ %#lx\n",
+				iova);
 		}
-		__master_clk_disable(data);
-	} else {
-		dev_dbg(dev, "disabled. Skipping TLB invalidation @ %#lx\n",
-			iova);
+
+		read_unlock(&data->lock);
 	}
-	read_unlock_irqrestore(&data->lock, flags);
+
+	spin_unlock_irqrestore(&owner->lock, flags);
 }
 
 void exynos_sysmmu_tlb_invalidate(struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	unsigned long flags;
-	struct sysmmu_drvdata *data;
+	struct sysmmu_list_data *list;
 
-	data = dev_get_drvdata(owner->sysmmu);
+	spin_lock_irqsave(&owner->lock, flags);
 
-	read_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) && data->runtime_active) {
-		__master_clk_enable(data);
-		if (sysmmu_block(data->sfrbase)) {
-			__sysmmu_tlb_invalidate(data->sfrbase);
-			sysmmu_unblock(data->sfrbase);
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		read_lock(&data->lock);
+		if (is_sysmmu_active(data) && data->runtime_active) {
+			__master_clk_enable(data);
+			if (sysmmu_block(data->sfrbase)) {
+				__sysmmu_tlb_invalidate(data->sfrbase);
+				sysmmu_unblock(data->sfrbase);
+			}
+			__master_clk_disable(data);
+		} else {
+			dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 		}
-		__master_clk_disable(data);
-	} else {
-		dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
+		read_unlock(&data->lock);
 	}
-	read_unlock_irqrestore(&data->lock, flags);
+
+	spin_unlock_irqrestore(&owner->lock, flags);
 }
 
-static int __init exynos_sysmmu_probe(struct platform_device *pdev)
+static int __init __sysmmu_init_clock(struct device *sysmmu,
+				      struct sysmmu_drvdata *data)
 {
-	int irq, ret;
-	struct device *dev = &pdev->dev;
-	struct sysmmu_drvdata *data;
-	struct resource *res;
-	struct device_node *node;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "Unable to find IOMEM region\n");
-		return -ENOENT;
-	}
-
-	data->sfrbase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->sfrbase))
-		return PTR_ERR(data->sfrbase);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_dbg(dev, "Unable to find IRQ resource\n");
-		return irq;
-	}
-
-	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
-				dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
-		return ret;
-	}
+	int ret;
 
-	data->clk = devm_clk_get(dev, "sysmmu");
+	data->clk = devm_clk_get(sysmmu, "sysmmu");
 	if (IS_ERR(data->clk)) {
-		dev_info(dev, "No gate clock found!\n");
-		data->clk = NULL;
+		if (PTR_ERR(data->clk) == -ENOENT) {
+			dev_info(sysmmu, "No gating clock found.\n");
+			data->clk = NULL;
+			return 0;
+		}
+
+		dev_err(sysmmu, "Failed get sysmmu clock\n");
+		return PTR_ERR(data->clk);
 	}
 
 	ret = clk_prepare(data->clk);
 	if (ret) {
-		dev_err(dev, "Failed to prepare clk\n");
+		dev_err(sysmmu, "Failed to prepare sysmmu clock\n");
 		return ret;
 	}
 
-	data->clk_master = devm_clk_get(dev, "master");
-	if (IS_ERR(data->clk_master))
+	data->clk_master = devm_clk_get(sysmmu, "master");
+	if (PTR_ERR(data->clk_master) == -ENOENT) {
 		data->clk_master = NULL;
+		return 0;
+	} else if (IS_ERR(data->clk_master)) {
+		dev_err(sysmmu, "Failed to get master clock\n");
+		clk_unprepare(data->clk);
+		return PTR_ERR(data->clk_master);
+	}
 
 	ret = clk_prepare(data->clk_master);
 	if (ret) {
 		clk_unprepare(data->clk);
-		dev_err(dev, "Failed to prepare master's clk\n");
+		dev_err(sysmmu, "Failed to prepare master clock\n");
 		return ret;
 	}
 
-	/* Relation between master and System MMU is 1:1. */
-	node = of_parse_phandle(dev->of_node, "mmu-masters", 0);
-	if (node) {
+	return 0;
+}
+
+static int __init __sysmmu_init_master(struct device *dev)
+{
+	int ret;
+	int i = 0;
+	struct device_node *node;
+
+	while ((node = of_parse_phandle(dev->of_node, "mmu-masters", i++))) {
 		struct platform_device *master = of_find_device_by_node(node);
+		struct exynos_iommu_owner *owner;
+		struct sysmmu_list_data *list_data;
 
 		if (!master) {
 			dev_err(dev, "%s: mmu-master '%s' not found\n",
 				__func__, node->name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 
-		if (master->dev.archdata.iommu != NULL) {
-			dev_err(dev, "%s: '%s' is master of other MMU\n",
-				__func__, node->name);
-			return -EINVAL;
+		owner = master->dev.archdata.iommu;
+		if (!owner) {
+			owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
+			if (!owner) {
+				dev_err(dev,
+				"%s: Failed to allocate owner structure\n",
+				__func__);
+				ret = -ENOMEM;
+				goto err;
+			}
+
+			INIT_LIST_HEAD(&owner->mmu_list);
+			INIT_LIST_HEAD(&owner->client);
+			owner->dev = &master->dev;
+			spin_lock_init(&owner->lock);
+
+			master->dev.archdata.iommu = owner;
 		}
 
+		list_data = devm_kzalloc(dev, sizeof(*list_data), GFP_KERNEL);
+		if (!list_data) {
+			dev_err(dev,
+				"%s: Failed to allocate sysmmu_list_data\n",
+				__func__);
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		INIT_LIST_HEAD(&list_data->entry);
+		list_data->sysmmu = dev;
+
 		/*
-		 * archdata.iommu will be initialized with exynos_iommu_client
-		 * in sysmmu_hook_driver_register().
+		 * System MMUs are attached in the order of the presence
+		 * in device tree
 		 */
-		master->dev.archdata.iommu = dev;
+		list_add_tail(&list_data->entry, &owner->mmu_list);
 	}
 
-	data->sysmmu = dev;
-	rwlock_init(&data->lock);
+	return 0;
+err:
+	while ((node = of_parse_phandle(dev->of_node, "mmu-masters", i++))) {
+		struct platform_device *master = of_find_device_by_node(node);
+		struct exynos_iommu_owner *owner;
+		struct sysmmu_list_data *list_data;
 
-	platform_set_drvdata(pdev, data);
+		if (!master)
+			continue;
 
-	pm_runtime_enable(dev);
-	data->runtime_active = !pm_runtime_enabled(dev);
+		owner = master->dev.archdata.iommu;
+		if (!owner)
+			continue;
 
-	dev_dbg(dev, "Probed and initialized\n");
-	return 0;
+		for_each_sysmmu_list(owner->dev, list_data) {
+			if (list_data->sysmmu == dev) {
+				list_del(&list_data->entry);
+				kfree(list_data);
+				break;
+			}
+		}
+	}
+
+	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sysmmu_suspend(struct device *dev)
+static int __init __sysmmu_setup(struct device *sysmmu,
+				 struct sysmmu_drvdata *data)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	unsigned long flags;
-	read_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) &&
-		(!pm_runtime_enabled(dev) || data->runtime_active))
-		__sysmmu_disable_nocount(data);
-	read_unlock_irqrestore(&data->lock, flags);
-	return 0;
+	int ret;
+
+	ret = __sysmmu_init_clock(sysmmu, data);
+	if (ret) {
+		dev_err(sysmmu, "Failed to initialize gating clocks\n");
+		return ret;
+	}
+
+	ret = __sysmmu_init_master(sysmmu);
+	if (ret) {
+		if (data->clk)
+			clk_unprepare(data->clk);
+		if (data->clk_master)
+			clk_unprepare(data->clk_master);
+		dev_err(sysmmu, "Failed to initialize master device.\n");
+	}
+
+	return ret;
 }
 
-static int sysmmu_resume(struct device *dev)
+static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	unsigned long flags;
-	read_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) &&
-		(!pm_runtime_enabled(dev) || data->runtime_active))
-		__sysmmu_enable_nocount(data);
-	read_unlock_irqrestore(&data->lock, flags);
-	return 0;
-}
-#endif
+	int irq, ret;
+	struct device *dev = &pdev->dev;
+	struct sysmmu_drvdata *data;
+	struct resource *res;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(dev, "Not enough memory for driver data\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "Unable to find IOMEM region\n");
+		return -ENOENT;
+	}
+
+	data->sfrbase = devm_request_and_ioremap(dev, res);
+	if (!data->sfrbase) {
+		dev_err(dev, "Unable to map IOMEM @ PA: %pa\n", &res->start);
+		return -EBUSY;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(dev, "Unable to find IRQ resource\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
+				dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	ret = __sysmmu_setup(dev, data);
+	if (!ret) {
+		data->runtime_active = !pm_runtime_enabled(dev);
+		data->sysmmu = dev;
+		rwlock_init(&data->lock);
 
-static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend, sysmmu_resume);
+		platform_set_drvdata(pdev, data);
+	}
+
+	return ret;
+}
 
 #ifdef CONFIG_OF
 static struct of_device_id sysmmu_of_match[] __initconst = {
@@ -729,7 +843,6 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver	= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
-		.pm		= &sysmmu_pm_ops,
 		.of_match_table	= of_match_ptr(sysmmu_of_match),
 	}
 };
@@ -1146,52 +1259,78 @@ subsys_initcall(exynos_iommu_init);
 #ifdef CONFIG_PM_SLEEP
 static int sysmmu_pm_genpd_suspend(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct sysmmu_list_data *list;
 	int ret;
 
 	ret = pm_generic_suspend(dev);
 	if (ret)
 		return ret;
 
-	return pm_generic_suspend(owner->sysmmu);
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		unsigned long flags;
+		write_lock_irqsave(&data->lock, flags);
+		if (!data->suspended && is_sysmmu_active(data) &&
+			(!pm_runtime_enabled(dev) || data->runtime_active))
+			__sysmmu_disable_nocount(data);
+		data->suspended = true;
+		write_unlock_irqrestore(&data->lock, flags);
+	}
+
+	return 0;
 }
 
 static int sysmmu_pm_genpd_resume(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	int ret;
 
-	ret = pm_generic_resume(owner->sysmmu);
-	if (ret)
-		return ret;
+	struct sysmmu_list_data *list;
+
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		unsigned long flags;
+		write_lock_irqsave(&data->lock, flags);
+		if (data->suspended && is_sysmmu_active(data) &&
+			(!pm_runtime_enabled(dev) || data->runtime_active))
+			__sysmmu_enable_nocount(data);
+		data->suspended = false;
+		write_unlock_irqrestore(&data->lock, flags);
+	}
 
 	return pm_generic_resume(dev);
 }
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
-static void sysmmu_restore_state(struct device *sysmmu)
+static void sysmmu_restore_state(struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
-	unsigned long flags;
+	struct sysmmu_list_data *list;
+
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		unsigned long flags;
 
-	spin_lock_irqsave(&data->lock, flags);
-	data->runtime_active = true;
-	if (is_sysmmu_active(data))
-		__sysmmu_enable_nocount(data);
-	spin_unlock_irqrestore(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
+		if (!data->runtime_active && is_sysmmu_active(data))
+			__sysmmu_enable_nocount(data);
+		data->runtime_active = true;
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
 }
 
-static void sysmmu_save_state(struct device *sysmmu)
+static void sysmmu_save_state(struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
-	unsigned long flags;
+	struct sysmmu_list_data *list;
 
-	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data))
-		__sysmmu_disable_nocount(data);
-	data->runtime_active = false;
-	spin_unlock_irqrestore(&data->lock, flags);
+	for_each_sysmmu_list(dev, list) {
+		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
+		unsigned long flags;
+
+		spin_lock_irqsave(&data->lock, flags);
+		if (data->runtime_active && is_sysmmu_active(data))
+			__sysmmu_disable_nocount(data);
+		data->runtime_active = false;
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
 }
 
 static int sysmmu_pm_genpd_save_state(struct device *dev)
@@ -1216,7 +1355,7 @@ static int sysmmu_pm_genpd_save_state(struct device *dev)
 		ret = cb(dev);
 
 	if (ret == 0)
-		sysmmu_save_state(client->sysmmu);
+		sysmmu_save_state(dev);
 
 	return ret;
 }
@@ -1239,13 +1378,13 @@ static int sysmmu_pm_genpd_restore_state(struct device *dev)
 	if (!cb && dev->driver && dev->driver->pm)
 		cb = dev->driver->pm->runtime_resume;
 
-	sysmmu_restore_state(client->sysmmu);
+	sysmmu_restore_state(dev);
 
 	if (cb)
 		ret = cb(dev);
 
 	if (ret)
-		sysmmu_save_state(client->sysmmu);
+		sysmmu_restore_state(dev);
 
 	return ret;
 }
@@ -1280,58 +1419,51 @@ static int sysmmu_hook_driver_register(struct notifier_block *nb,
 	switch (val) {
 	case BUS_NOTIFY_BIND_DRIVER:
 	{
-		struct exynos_iommu_owner *owner;
-		int ret;
-
-		BUG_ON(!dev_get_drvdata(dev->archdata.iommu));
-
-		owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
-		if (!owner) {
-			dev_err(dev, "No Memory for exynos_iommu_owner\n");
-			dev->archdata.iommu = NULL;
-			return -ENOMEM;
-		}
-
-		owner->dev = dev;
-		INIT_LIST_HEAD(&owner->client);
-		owner->sysmmu = dev->archdata.iommu;
-
-		ret = pm_genpd_add_callbacks(dev, &sysmmu_devpm_ops, NULL);
-		if (ret && (ret != -ENOSYS)) {
-			dev_err(dev,
+		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS) && dev->pm_domain) {
+			int ret = pm_genpd_add_callbacks(
+					dev, &sysmmu_devpm_ops, NULL);
+			if (ret && (ret != -ENOSYS)) {
+				dev_err(dev,
 				"Failed to register 'dev_pm_ops' for iommu\n");
-			devm_kfree(dev, owner);
-			dev->archdata.iommu = NULL;
-			return ret;
+				return ret;
+			}
 		}
 
-		dev->archdata.iommu = owner;
 		break;
 	}
 	case BUS_NOTIFY_BOUND_DRIVER:
 	{
-		struct exynos_iommu_owner *owner = dev->archdata.iommu;
-		if (!pm_runtime_enabled(dev)) {
+		struct sysmmu_list_data *list;
+
+		/* OK if runtime PM is enabled with genpd for dev */
+		if (pm_runtime_enabled(dev) && dev->pm_domain)
+			break;
+
+		/*
+		 * System MMU will be permanently enabled if the master H/W is
+		 * neither registered to a power domain nor runtime PM enabled.
+		 */
+		for_each_sysmmu_list(dev, list) {
 			struct sysmmu_drvdata *data =
-					dev_get_drvdata(owner->sysmmu);
-			if (pm_runtime_enabled(data->sysmmu)) {
-				data->runtime_active = true;
-				if (is_sysmmu_active(data))
-					__sysmmu_enable_nocount(data);
-				pm_runtime_disable(data->sysmmu);
-			}
+					dev_get_drvdata(list->sysmmu);
+			unsigned long flags;
+
+			write_lock_irqsave(&data->lock, flags);
+			if (is_sysmmu_active(data) && !data->runtime_active)
+				__sysmmu_enable_nocount(data);
+			data->runtime_active = true;
+			pm_runtime_disable(data->sysmmu);
+			write_unlock_irqrestore(&data->lock, flags);
 		}
+
 		break;
 	}
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 	{
 		struct exynos_iommu_owner *owner = dev->archdata.iommu;
-		struct device *sysmmu = owner->sysmmu;
 		if (WARN_ON(!list_empty(&owner->client)))
 			iommu_detach_device(owner->domain, dev);
 		__pm_genpd_remove_callbacks(dev, false);
-		devm_kfree(dev, owner);
-		dev->archdata.iommu = sysmmu;
 		break;
 	}
 	} /* switch (val) */
-- 
1.7.9.5
