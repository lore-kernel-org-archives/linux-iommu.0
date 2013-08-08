From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v9 14/16] iommu/exynos: add support for power management
	subsystems.
Date: Thu, 08 Aug 2013 18:41:17 +0900
Message-ID: <003201ce941b$6e5a90e0$4b0fb2a0$@samsung.com>
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
To: 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds support for Advance Power Management and Runtime Power
Management.

Since System MMU is located in the same local power domain of its
master H/W, System MMU must be initialized before it is working if
its power domain was ever turned off. TLB invalidation according to
unmapping on page tables must also be performed while power domain is
turned on.

This patch ensures that resume and runtime_resume(restore_state)
functions in this driver is called before the calls to resume and
runtime_resume callback functions in the drivers of master H/Ws.
Likewise, suspend and runtime_suspend(save_state) functions in this
driver is called after the calls to suspend and runtime_suspend in the
drivers of master H/Ws.

In order to get benefit of this support, the master H/W and its System
MMU must resides in the same power domain in terms of Linux kernel. If
a master H/W does not use generic I/O power domain, its driver must
call iommu_attach_device() after its local power domain is turned on,
iommu_detach_device before turned off.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |  235 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 231 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 9e64483..56aead9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pm_domain.h>
 #include <linux/notifier.h>
 
 #include <asm/cacheflush.h>
@@ -186,6 +187,7 @@ struct sysmmu_drvdata {
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
+	bool runtime_active;
 	unsigned long pgtable;
 	void __iomem *sfrbases[0];
 };
@@ -438,7 +440,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 		data->pgtable = 0;
 		data->domain = NULL;
 
-		__sysmmu_disable_nocount(data);
+		if (data->runtime_active)
+			__sysmmu_disable_nocount(data);
 
 		dev_dbg(data->sysmmu, "Disabled\n");
 	} else  {
@@ -505,7 +508,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 		data->pgtable = pgtable;
 		data->domain = domain;
 
-		__sysmmu_enable_nocount(data);
+		if (data->runtime_active)
+			__sysmmu_enable_nocount(data);
 
 		dev_dbg(data->sysmmu, "Enabled\n");
 	} else {
@@ -609,7 +613,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 		data = dev_get_drvdata(client->sysmmu[i]);
 
 		read_lock_irqsave(&data->lock, flags);
-		if (is_sysmmu_active(data)) {
+		if (is_sysmmu_active(data) && data->runtime_active) {
 			int i;
 			clk_enable(data->clk_master);
 			for (i = 0; i < data->nsfrs; i++)
@@ -637,7 +641,8 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 		data = dev_get_drvdata(client->sysmmu[i]);
 
 		read_lock_irqsave(&data->lock, flags);
-		if (is_sysmmu_active(data)) {
+		if (is_sysmmu_active(data) &&
+				data->runtime_active) {
 			int i;
 			for (i = 0; i < data->nsfrs; i++) {
 				clk_enable(data->clk_master);
@@ -711,6 +716,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_enable(dev);
+
 	data->sysmmu = dev;
 
 	data->clk = devm_clk_get(dev, "sysmmu");
@@ -736,6 +743,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->runtime_active = !pm_runtime_enabled(dev);
+
 	rwlock_init(&data->lock);
 
 	platform_set_drvdata(pdev, data);
@@ -744,6 +753,34 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
+	read_lock_irqsave(&data->lock, flags);
+	if (is_sysmmu_active(data) &&
+		(!pm_runtime_enabled(dev) || data->runtime_active))
+		__sysmmu_disable_nocount(data);
+	read_unlock_irqrestore(&data->lock, flags);
+	return 0;
+}
+
+static int sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
+	read_lock_irqsave(&data->lock, flags);
+	if (is_sysmmu_active(data) &&
+		(!pm_runtime_enabled(dev) || data->runtime_active))
+		__sysmmu_enable_nocount(data);
+	read_unlock_irqrestore(&data->lock, flags);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend, sysmmu_resume);
+
 #ifdef CONFIG_OF
 static struct of_device_id sysmmu_of_match[] __initconst = {
 	{ .compatible	= "samsung,exynos4210-sysmmu", },
@@ -756,6 +793,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver	= {
 		.owner		= THIS_MODULE,
 		.name		= "exynos-sysmmu",
+		.pm		= &sysmmu_pm_ops,
 		.of_match_table	= of_match_ptr(sysmmu_of_match),
 	}
 };
@@ -1141,6 +1179,163 @@ static int __init exynos_iommu_init(void)
 }
 subsys_initcall(exynos_iommu_init);
 
+#ifdef CONFIG_PM_SLEEP
+static int sysmmu_pm_genpd_suspend(struct device *dev)
+{
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < client->num_sysmmu; i++) {
+		ret = pm_generic_suspend(client->sysmmu[i]);
+		if (ret)
+			break;
+	}
+
+	if (!ret)
+		ret = pm_generic_suspend(dev);
+
+	if (ret) {
+		int j;
+
+		for (j = 0; j < i; j++)
+			pm_generic_resume(client->sysmmu[j]);
+	}
+
+	return ret;
+}
+
+static int sysmmu_pm_genpd_resume(struct device *dev)
+{
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < client->num_sysmmu; i++) {
+		ret = pm_generic_resume(client->sysmmu[i]);
+		if (ret)
+			break;
+	}
+
+	if (!ret)
+		ret = pm_generic_resume(dev);
+
+	if (ret) {
+		int j;
+
+		for (j = 0; j < i; j++)
+			pm_generic_suspend(client->sysmmu[j]);
+	}
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM_RUNTIME
+static void sysmmu_restore_state(struct device *sysmmu)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	data->runtime_active = true;
+	if (is_sysmmu_active(data))
+		__sysmmu_enable_nocount(data);
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void sysmmu_save_state(struct device *sysmmu)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (is_sysmmu_active(data))
+		__sysmmu_disable_nocount(data);
+	data->runtime_active = false;
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int sysmmu_pm_genpd_save_state(struct device *dev)
+{
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int (*cb)(struct device *__dev);
+	int i;
+
+	if (dev->type && dev->type->pm)
+		cb = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm)
+		cb = dev->class->pm->runtime_suspend;
+	else if (dev->bus && dev->bus->pm)
+		cb = dev->bus->pm->runtime_suspend;
+	else
+		cb = NULL;
+
+	if (!cb && dev->driver && dev->driver->pm)
+		cb = dev->driver->pm->runtime_suspend;
+
+	if (cb) {
+		int ret;
+
+		ret = cb(dev);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < client->num_sysmmu; i++)
+		sysmmu_save_state(client->sysmmu[i]);
+
+	return 0;
+}
+
+static int sysmmu_pm_genpd_restore_state(struct device *dev)
+{
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int (*cb)(struct device *__dev);
+	int i;
+
+	if (dev->type && dev->type->pm)
+		cb = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm)
+		cb = dev->class->pm->runtime_resume;
+	else if (dev->bus && dev->bus->pm)
+		cb = dev->bus->pm->runtime_resume;
+	else
+		cb = NULL;
+
+	if (!cb && dev->driver && dev->driver->pm)
+		cb = dev->driver->pm->runtime_resume;
+
+	for (i = 0; i < client->num_sysmmu; i++)
+		sysmmu_restore_state(client->sysmmu[i]);
+
+	if (cb) {
+		int ret;
+		ret = cb(dev);
+		if (ret) {
+			for (i = 0; i < client->num_sysmmu; i++)
+				sysmmu_save_state(client->sysmmu[i]);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+struct gpd_dev_ops sysmmu_devpm_ops = {
+#ifdef CONFIG_PM_RUNTIME
+	.save_state = &sysmmu_pm_genpd_save_state,
+	.restore_state = &sysmmu_pm_genpd_restore_state,
+#endif
+#ifdef CONFIG_PM_SLEEP
+	.suspend = &sysmmu_pm_genpd_suspend,
+	.resume = &sysmmu_pm_genpd_resume,
+#endif
+};
+#endif /* CONFIG_PM_GENERIC_DOMAINS */
+
 static int sysmmu_hook_driver_register(struct notifier_block *nb,
 					unsigned long val,
 					void *p)
@@ -1197,12 +1392,44 @@ static int sysmmu_hook_driver_register(struct notifier_block *nb,
 			return -ENODEV;
 		}
 
+		i = pm_genpd_add_callbacks(dev, &sysmmu_devpm_ops, NULL);
+		if (i && (i != -ENOSYS)) {
+			dev_err(dev,
+				"Failed to register 'dev_pm_ops' for iommu\n");
+			devm_kfree(dev, client);
+			return i;
+		}
+
 		dev->archdata.iommu = client;
 		break;
 	}
+	case BUS_NOTIFY_BOUND_DRIVER:
+	{
+		struct exynos_iommu_client *client = dev->archdata.iommu;
+		if (dev->archdata.iommu &&
+				(!pm_runtime_enabled(dev) ||
+					 IS_ERR(dev_to_genpd(dev)))) {
+			int i;
+			for (i = 0; i < client->num_sysmmu; i++) {
+				struct sysmmu_drvdata *data;
+				pm_runtime_disable(client->sysmmu[i]);
+				data = dev_get_drvdata(client->sysmmu[i]);
+				if (!data)
+					continue;
+				data->runtime_active =
+					!pm_runtime_enabled(data->sysmmu);
+				if (data->runtime_active &&
+						is_sysmmu_active(data))
+					__sysmmu_enable_nocount(data);
+			}
+		}
+		break;
+	}
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 	{
 		if (dev->archdata.iommu) {
+			__pm_genpd_remove_callbacks(dev, false);
+
 			devm_kfree(dev, dev->archdata.iommu);
 			dev->archdata.iommu = NULL;
 		}
-- 
1.7.2.5
