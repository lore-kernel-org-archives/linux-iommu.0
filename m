From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 21/27] iommu/exynos: change rwlock to spinlock
Date: Fri, 14 Mar 2014 14:11:40 +0900
Message-ID: <20140314141140.8c05452abfa2375b739845d6@samsung.com>
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

Since acquiring read_lock is not more frequent than write_lock, it is
not beneficial to use rwlock, this commit changes rwlock to spinlock.

Reviewed-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7489343..543ea2e0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -211,7 +211,7 @@ struct sysmmu_drvdata {
 	struct clk *clk;
 	struct clk *clk_master;
 	int activations;
-	rwlock_t lock;
+	spinlock_t lock;
 	struct iommu_domain *domain;
 	bool runtime_active;
 	bool suspended;
@@ -334,11 +334,12 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	unsigned long addr = -1;
 	int ret = -ENOSYS;
 
-	read_lock(&data->lock);
-
 	WARN_ON(!is_sysmmu_active(data));
 
+	spin_lock(&data->lock);
+
 	__master_clk_enable(data);
+
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -371,7 +372,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	__master_clk_disable(data);
 
-	read_unlock(&data->lock);
+	spin_unlock(&data->lock);
 
 	return IRQ_HANDLED;
 }
@@ -392,7 +393,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 	bool disabled;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	disabled = set_sysmmu_inactive(data);
 
@@ -409,7 +410,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 					data->activations);
 	}
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return disabled;
 }
@@ -457,7 +458,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	int ret = 0;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
 		data->domain = domain;
@@ -475,7 +476,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	if (WARN_ON(ret < 0))
 		set_sysmmu_inactive(data); /* decrement count */
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
@@ -562,7 +563,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
-		read_lock(&data->lock);
+		spin_lock(&data->lock);
 		if (is_sysmmu_active(data) && data->runtime_active) {
 			unsigned int num_inv = 1;
 
@@ -594,7 +595,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 				iova);
 		}
 
-		read_unlock(&data->lock);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
@@ -610,7 +611,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
-		read_lock(&data->lock);
+		spin_lock(&data->lock);
 		if (is_sysmmu_active(data) && data->runtime_active) {
 			__master_clk_enable(data);
 			if (sysmmu_block(data->sfrbase)) {
@@ -621,7 +622,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 		} else {
 			dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 		}
-		read_unlock(&data->lock);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
@@ -819,7 +820,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	if (!ret) {
 		data->runtime_active = !pm_runtime_enabled(dev);
 		data->sysmmu = dev;
-		rwlock_init(&data->lock);
+		spin_lock_init(&data->lock);
 
 		platform_set_drvdata(pdev, data);
 	}
@@ -1269,12 +1270,12 @@ static int sysmmu_pm_genpd_suspend(struct device *dev)
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
 		unsigned long flags;
-		write_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (!data->suspended && is_sysmmu_active(data) &&
 			(!pm_runtime_enabled(dev) || data->runtime_active))
 			__sysmmu_disable_nocount(data);
 		data->suspended = true;
-		write_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
 	return 0;
@@ -1288,12 +1289,12 @@ static int sysmmu_pm_genpd_resume(struct device *dev)
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
 		unsigned long flags;
-		write_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (data->suspended && is_sysmmu_active(data) &&
 			(!pm_runtime_enabled(dev) || data->runtime_active))
 			__sysmmu_enable_nocount(data);
 		data->suspended = false;
-		write_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
 	return pm_generic_resume(dev);
@@ -1448,12 +1449,12 @@ static int sysmmu_hook_driver_register(struct notifier_block *nb,
 					dev_get_drvdata(list->sysmmu);
 			unsigned long flags;
 
-			write_lock_irqsave(&data->lock, flags);
+			spin_lock_irqsave(&data->lock, flags);
 			if (is_sysmmu_active(data) && !data->runtime_active)
 				__sysmmu_enable_nocount(data);
 			data->runtime_active = true;
 			pm_runtime_disable(data->sysmmu);
-			write_unlock_irqrestore(&data->lock, flags);
+			spin_unlock_irqrestore(&data->lock, flags);
 		}
 
 		break;
-- 
1.7.9.5
