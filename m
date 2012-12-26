From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 08/12] iommu/exynos: add support for runtime pm and
	suspend/resume
Date: Wed, 26 Dec 2012 10:54:08 +0900
Message-ID: <003b01cde30b$e49c8220$add58660$%cho@samsung.com>
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
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This change enables the client device drivers not to care about
the state of System MMU since the internal state of System MMU
is controlled by the runtime PM and suspend/resume callback functions.

Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 176 ++++++++++++++++++++++---------------------
 1 file changed, 89 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a0e5ee1..c3c5b7b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -187,6 +187,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct iommu_domain *domain;
 	unsigned long pgtable;
+	bool runtime_active;
 	void __iomem *sfrbases[0];
 };
 
@@ -409,7 +410,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 		data->pgtable = 0;
 		data->domain = NULL;
 
-		__sysmmu_disable_nocount(data);
+		if (data->runtime_active)
+			__sysmmu_disable_nocount(data);
 
 		dev_dbg(data->sysmmu, "Disabled\n");
 	} else  {
@@ -422,30 +424,6 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 	return disabled;
 }
 
-static bool __exynos_sysmmu_disable(struct device *dev)
-{
-	unsigned long flags;
-	bool disabled = true;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct device *sysmmu;
-
-	BUG_ON(!has_sysmmu(dev));
-
-	spin_lock_irqsave(&owner->lock, flags);
-
-	/* Every call to __sysmmu_disable() must return same result */
-	for_each_sysmmu(dev, sysmmu) {
-		struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
-		disabled = __sysmmu_disable(data);
-		if (disabled)
-			data->master = NULL;
-	}
-
-	spin_unlock_irqrestore(&owner->lock, flags);
-
-	return disabled;
-}
-
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 {
 	int i;
@@ -481,7 +459,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 		data->pgtable = pgtable;
 		data->domain = domain;
 
-		__sysmmu_enable_nocount(data);
+		if (data->runtime_active)
+			__sysmmu_enable_nocount(data);
 
 		dev_dbg(data->sysmmu, "Enabled\n");
 	} else {
@@ -537,42 +516,31 @@ static int __exynos_sysmmu_enable(struct device *dev, unsigned long pgtable,
 
 int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
 {
-	int ret;
-	struct device *sysmmu;
-
 	BUG_ON(!memblock_is_memory(pgtable));
 
-	for_each_sysmmu(dev, sysmmu) {
-		ret = pm_runtime_get_sync(sysmmu);
-		if (ret < 0)
-			break;
-	}
-
-	if (ret < 0) {
-		struct device *start;
-		for_each_sysmmu_until(dev, start, sysmmu)
-			pm_runtime_put(start);
-
-		return ret;
-	}
-
-	ret = __exynos_sysmmu_enable(dev, pgtable, NULL);
-	if (ret < 0)
-		for_each_sysmmu(dev, sysmmu)
-			pm_runtime_put(sysmmu);
-
-	return ret;
+	return __exynos_sysmmu_enable(dev, pgtable, NULL);
 }
 
 bool exynos_sysmmu_disable(struct device *dev)
 {
-	bool disabled;
+	unsigned long flags;
+	bool disabled = true;
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct device *sysmmu;
 
-	disabled = __exynos_sysmmu_disable(dev);
+	BUG_ON(!has_sysmmu(dev));
+
+	spin_lock_irqsave(&owner->lock, flags);
+
+	/* Every call to __sysmmu_disable() must return same result */
+	for_each_sysmmu(dev, sysmmu) {
+		struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
+		disabled = __sysmmu_disable(drvdata);
+		if (disabled)
+			drvdata->master = NULL;
+	}
 
-	for_each_sysmmu(dev, sysmmu)
-		pm_runtime_put(sysmmu);
+	spin_unlock_irqrestore(&owner->lock, flags);
 
 	return disabled;
 }
@@ -588,7 +556,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 		data = dev_get_drvdata(sysmmu);
 
 		spin_lock_irqsave(&data->lock, flags);
-		if (is_sysmmu_active(data)) {
+		if (is_sysmmu_active(data) &&
+				data->runtime_active) {
 			int i;
 			for (i = 0; i < data->nsfrs; i++) {
 				if (sysmmu_block(data->sfrbases[i])) {
@@ -817,7 +786,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		data->sysmmu = dev;
 		spin_lock_init(&data->lock);
 
-		pm_runtime_enable(dev);
+		data->runtime_active = !pm_runtime_enabled(dev);
 
 		platform_set_drvdata(pdev, data);
 
@@ -828,6 +797,64 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned long flags;
+	spin_lock_irqsave(&drvdata->lock, flags);
+	if (is_sysmmu_active(drvdata) &&
+		(!pm_runtime_enabled(dev) || drvdata->runtime_active))
+		__sysmmu_disable_nocount(drvdata);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	return 0;
+}
+
+static int sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned long flags;
+	spin_lock_irqsave(&drvdata->lock, flags);
+	if (is_sysmmu_active(drvdata) &&
+		(!pm_runtime_enabled(dev) || drvdata->runtime_active)) {
+		__sysmmu_enable_nocount(drvdata);
+	}
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static int sysmmu_runtime_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned long flags;
+	spin_lock_irqsave(&drvdata->lock, flags);
+	if (is_sysmmu_active(drvdata))
+		__sysmmu_disable_nocount(drvdata);
+	drvdata->runtime_active = false;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	return 0;
+}
+
+static int sysmmu_runtime_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(dev);
+	unsigned long flags;
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->runtime_active = true;
+	if (is_sysmmu_active(drvdata))
+		__sysmmu_enable_nocount(drvdata);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops __pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sysmmu_suspend, sysmmu_resume)
+	SET_RUNTIME_PM_OPS(sysmmu_runtime_suspend, sysmmu_runtime_resume, NULL)
+};
+
 /*
  * Descriptions of Device Tree node for System MMU
  *
@@ -865,6 +892,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.pm		= &__pm_ops,
 		.of_match_table = of_match_ptr(sysmmu_of_match),
 	}
 };
@@ -939,13 +967,9 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_for_each_entry_safe(owner, n, &priv->clients, client) {
-		struct device *sysmmu;
-		while (!__exynos_sysmmu_disable(owner->dev))
+		while (!exynos_sysmmu_disable(owner->dev))
 			; /* until System MMU is actually disabled */
 		list_del_init(&owner->client);
-
-		for_each_sysmmu(owner->dev, sysmmu)
-			pm_runtime_put(sysmmu);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -968,7 +992,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	struct exynos_iommu_domain *priv = domain->priv;
 	unsigned long flags;
 	int ret;
-	struct device *sysmmu;
 
 	if (WARN_ON(!list_empty(&owner->client))) {
 		bool found = false;
@@ -993,20 +1016,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 	}
 
-	for_each_sysmmu(dev, sysmmu) {
-		ret = pm_runtime_get_sync(sysmmu);
-		if (ret < 0)
-			break;
-	}
-
-	if (ret < 0) {
-		struct device *start;
-		for_each_sysmmu_until(dev, start, sysmmu)
-			pm_runtime_put(start);
-
-		return ret;
-	}
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
@@ -1021,15 +1030,12 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#lx\n",
 				__func__, __pa(priv->pgtable));
-		for_each_sysmmu(dev, sysmmu)
-			pm_runtime_put(sysmmu);
-	} else {
+	else
 		dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n",
 					__func__, __pa(priv->pgtable));
-	}
 
 	return ret;
 }
@@ -1045,7 +1051,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 
 	list_for_each_entry_safe(owner, n, &priv->clients, client) {
 		if (owner == dev->archdata.iommu) {
-			if (__exynos_sysmmu_disable(dev))
+			if (exynos_sysmmu_disable(dev))
 				list_del_init(&owner->client);
 			else
 				BUG();
@@ -1055,14 +1061,10 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (owner == dev->archdata.iommu) {
-		struct device *sysmmu;
+	if (owner == dev->archdata.iommu)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %#lx\n",
 					__func__, __pa(priv->pgtable));
-		for_each_sysmmu(dev, sysmmu)
-			pm_runtime_put(sysmmu);
-
-	} else
+	else
 		dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
 }
 
-- 
1.8.0
