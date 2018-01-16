From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
Date: Tue, 16 Jan 2018 21:25:39 +0800
Message-ID: <20180116132540.18939-13-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116132540.18939-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When the power domain is powered off, the IOMMU cannot be accessed and
register programming must be deferred until the power domain becomes
enabled.

Add runtime PM support, and use runtime PM device link from IOMMU to
master to startup and shutdown IOMMU.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 191 ++++++++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c2d3ac82184e..c8de1456a016 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -18,11 +18,13 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -98,6 +100,12 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct mutex pm_mutex; /* serializes power transitions */
+};
+
+struct rk_iommudata {
+	struct device_link *link; /* runtime PM link from IOMMU to master */
+	struct rk_iommu *iommu;
 };
 
 static struct device *dma_dev;
@@ -675,9 +683,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
 		iommu = list_entry(pos, struct rk_iommu, node);
-		rk_iommu_enable_clocks(iommu);
-		rk_iommu_zap_lines(iommu, iova, size);
-		rk_iommu_disable_clocks(iommu);
+
+		/* Only zap TLBs of IOMMUs that are powered on. */
+		if (pm_runtime_get_if_in_use(iommu->dev) > 0) {
+			rk_iommu_enable_clocks(iommu);
+			rk_iommu_zap_lines(iommu, iova, size);
+			rk_iommu_disable_clocks(iommu);
+
+			pm_runtime_put(iommu->dev);
+		}
 	}
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -875,28 +889,19 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
-	return dev->archdata.iommu;
+	struct rk_iommudata *data = dev->archdata.iommu;
+
+	return data ? data->iommu : NULL;
 }
 
-static void rk_iommu_detach_device(struct iommu_domain *domain,
-				   struct device *dev)
+static void rk_iommu_shutdown(struct rk_iommu *iommu)
 {
-	struct rk_iommu *iommu;
-	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
-	unsigned long flags;
 	int i;
 
-	/* Allow 'virtual devices' (eg drm) to detach from domain */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return;
-
-	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
-	list_del_init(&iommu->node);
-	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
-
 	/* Ignore error while disabling, just keep going */
 	WARN_ON(rk_iommu_enable_clocks(iommu));
+
+	mutex_lock(&iommu->pm_mutex);
 	rk_iommu_enable_stall(iommu);
 	rk_iommu_disable_paging(iommu);
 	for (i = 0; i < iommu->num_mmu; i++) {
@@ -904,46 +909,30 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
 	}
 	rk_iommu_disable_stall(iommu);
-	rk_iommu_disable_clocks(iommu);
+	mutex_unlock(&iommu->pm_mutex);
 
-	iommu->domain = NULL;
-
-	dev_dbg(dev, "Detached from iommu domain\n");
+	rk_iommu_disable_clocks(iommu);
 }
 
-static int rk_iommu_attach_device(struct iommu_domain *domain,
-				  struct device *dev)
+static int rk_iommu_startup(struct rk_iommu *iommu)
 {
-	struct rk_iommu *iommu;
+	struct iommu_domain *domain = iommu->domain;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
-	unsigned long flags;
 	int ret, i;
 
-	/*
-	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
-	 * Such a device does not belong to an iommu group.
-	 */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return 0;
-
-	if (iommu->domain)
-		rk_iommu_detach_device(iommu->domain, dev);
-
 	ret = rk_iommu_enable_clocks(iommu);
 	if (ret)
 		return ret;
 
+	mutex_lock(&iommu->pm_mutex);
 	ret = rk_iommu_enable_stall(iommu);
 	if (ret)
-		goto err_disable_clocks;
+		goto err_unlock_mutex;
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
 		goto err_disable_stall;
 
-	iommu->domain = domain;
-
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
 			       rk_domain->dt_dma);
@@ -955,21 +944,90 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		goto err_disable_stall;
 
-	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
-	list_add_tail(&iommu->node, &rk_domain->iommus);
-	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
-
-	dev_dbg(dev, "Attached to iommu domain\n");
-
 	rk_iommu_disable_stall(iommu);
+	mutex_unlock(&iommu->pm_mutex);
+
 	rk_iommu_disable_clocks(iommu);
 
 	return 0;
 
 err_disable_stall:
 	rk_iommu_disable_stall(iommu);
-err_disable_clocks:
+err_unlock_mutex:
+	mutex_unlock(&iommu->pm_mutex);
 	rk_iommu_disable_clocks(iommu);
+	return ret;
+}
+
+static void rk_iommu_detach_device(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct rk_iommu *iommu;
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+
+	/* Allow 'virtual devices' (eg drm) to detach from domain */
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu)
+		return;
+
+	dev_dbg(dev, "Detaching from iommu domain\n");
+
+	/* iommu already detached */
+	if (iommu->domain != domain)
+		return;
+
+	iommu->domain = NULL;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_del_init(&iommu->node);
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+
+	if (pm_runtime_get_if_in_use(iommu->dev) > 0) {
+		rk_iommu_shutdown(iommu);
+		pm_runtime_put(iommu->dev);
+	}
+}
+
+static int rk_iommu_attach_device(struct iommu_domain *domain,
+		struct device *dev)
+{
+	struct rk_iommu *iommu;
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
+	 * Such a device does not belong to an iommu group.
+	 */
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu)
+		return 0;
+
+	dev_dbg(dev, "Attaching to iommu domain\n");
+
+	/* iommu already attached */
+	if (iommu->domain == domain)
+		return 0;
+
+	if (iommu->domain)
+		rk_iommu_detach_device(iommu->domain, dev);
+
+	iommu->domain = domain;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_add_tail(&iommu->node, &rk_domain->iommus);
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+
+	if (pm_runtime_get_if_in_use(iommu->dev) <= 0)
+		return 0;
+
+	ret = rk_iommu_startup(iommu);
+	if (ret)
+		rk_iommu_detach_device(data->domain, dev);
+
+	pm_runtime_put(iommu->dev);
 
 	return ret;
 }
@@ -1059,6 +1117,7 @@ static int rk_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev->archdata.iommu;
 
 	iommu = rk_iommu_from_dev(dev);
 	if (!iommu)
@@ -1070,6 +1129,7 @@ static int rk_iommu_add_device(struct device *dev)
 	iommu_group_put(group);
 
 	iommu_device_link(&iommu->iommu, dev);
+	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
 
 	return 0;
 }
@@ -1077,11 +1137,13 @@ static int rk_iommu_add_device(struct device *dev)
 static void rk_iommu_remove_device(struct device *dev)
 {
 	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev->archdata.iommu;
 
 	iommu = rk_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 
+	device_link_del(data->link);
 	iommu_device_unlink(&iommu->iommu, dev);
 	iommu_group_remove_device(dev);
 }
@@ -1101,6 +1163,11 @@ static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
 	struct platform_device *iommu_dev;
+	struct rk_iommudata *data;
+
+	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	iommu_dev = of_find_device_by_node(args->np);
 	if (!iommu_dev) {
@@ -1108,7 +1175,9 @@ static int rk_iommu_of_xlate(struct device *dev,
 		return -ENODEV;
 	}
 
-	dev->archdata.iommu = platform_get_drvdata(iommu_dev);
+	data->iommu = platform_get_drvdata(iommu_dev);
+	dev->archdata.iommu = data;
+
 	of_dev_put(iommu_dev);
 
 	return 0;
@@ -1204,6 +1273,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
 
+	pm_runtime_enable(dev);
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1216,6 +1287,8 @@ static int rk_iommu_remove(struct platform_device *pdev)
 {
 	struct rk_iommu *iommu = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	rk_iommu_put_clocks(iommu);
@@ -1223,6 +1296,27 @@ static int rk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rk_iommu_suspend(struct device *dev)
+{
+	struct rk_iommu *iommu = dev_get_drvdata(dev);
+
+	rk_iommu_shutdown(iommu);
+	return 0;
+}
+
+static int __maybe_unused rk_iommu_resume(struct device *dev)
+{
+	struct rk_iommu *iommu = dev_get_drvdata(dev);
+
+	return rk_iommu_startup(iommu);
+}
+
+static const struct dev_pm_ops rk_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_iommu_suspend, rk_iommu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1235,6 +1329,7 @@ static struct platform_driver rk_iommu_driver = {
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
+		   .pm = &rk_iommu_pm_ops,
 		   .suppress_bind_attrs = true,
 	},
 };
-- 
2.11.0
