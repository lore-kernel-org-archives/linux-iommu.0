From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 19/31] iommu/exynos: change rwlock to spinlock
Date: Sun, 27 Apr 2014 13:07:51 +0530
Message-ID: <1398584283-22846-20-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, tomasz.figa@gmail.com, pullip.cho@samsung.com, a.motakis@virtualopensystems.com, grundler@chromium.org, joro@8bytes.org, prathyush.k@samsung.com, rahul.sharma@samsung.com, sachin.kamat@linaro.org, supash.ramaswamy@linaro.org, Varun.Sethi@freescale.com, s.nawrocki@samsung.com, t.figa@samsung.com, joshi@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

Since acquiring read_lock is not more frequent than write_lock, it is
not beneficial to use rwlock, this commit changes rwlock to spinlock.

Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c2e6365..c9076e1 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -200,7 +200,7 @@ struct sysmmu_drvdata {
 	struct clk *clk;
 	struct clk *clk_master;
 	int activations;
-	rwlock_t lock;
+	spinlock_t lock;
 	struct iommu_domain *domain;
 	bool powered_on;
 	bool suspended;
@@ -323,12 +323,13 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	unsigned long addr = -1;
 	int ret = -ENOSYS;
 
-	read_lock(&data->lock);
-
 	WARN_ON(!is_sysmmu_active(data));
 
+	spin_lock(&data->lock);
+
 	if (!IS_ERR(data->clk_master))
 		clk_enable(data->clk_master);
+
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -362,7 +363,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (!IS_ERR(data->clk_master))
 		clk_disable(data->clk_master);
 
-	read_unlock(&data->lock);
+	spin_unlock(&data->lock);
 
 	return IRQ_HANDLED;
 }
@@ -385,7 +386,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 	bool disabled;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	disabled = set_sysmmu_inactive(data);
 
@@ -402,7 +403,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 					data->activations);
 	}
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return disabled;
 }
@@ -452,7 +453,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	int ret = 0;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
 		data->domain = domain;
@@ -470,7 +471,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	if (WARN_ON(ret < 0))
 		set_sysmmu_inactive(data); /* decrement count */
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
@@ -557,7 +558,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
-		read_lock(&data->lock);
+		spin_lock(&data->lock);
 		if (is_sysmmu_active(data) && data->powered_on) {
 			unsigned int num_inv = 1;
 
@@ -592,7 +593,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 				iova);
 		}
 
-		read_unlock(&data->lock);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
@@ -608,7 +609,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
-		read_lock(&data->lock);
+		spin_lock(&data->lock);
 		if (is_sysmmu_active(data) && data->powered_on) {
 			if (!IS_ERR(data->clk_master))
 				clk_enable(data->clk_master);
@@ -621,7 +622,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 		} else {
 			dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 		}
-		read_unlock(&data->lock);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&owner->lock, flags);
@@ -813,7 +814,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	if (!ret) {
 		data->powered_on = !pm_runtime_enabled(dev);
 		data->sysmmu = dev;
-		rwlock_init(&data->lock);
+		spin_lock_init(&data->lock);
 
 		platform_set_drvdata(pdev, data);
 	}
@@ -1264,12 +1265,12 @@ static int sysmmu_pm_genpd_suspend(struct device *dev)
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
 		unsigned long flags;
-		write_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (!data->suspended && is_sysmmu_active(data) &&
 			(!pm_runtime_enabled(dev) || data->powered_on))
 			__sysmmu_disable_nocount(data);
 		data->suspended = true;
-		write_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
 	return 0;
@@ -1282,12 +1283,12 @@ static int sysmmu_pm_genpd_resume(struct device *dev)
 	for_each_sysmmu_list(dev, list) {
 		struct sysmmu_drvdata *data = dev_get_drvdata(list->sysmmu);
 		unsigned long flags;
-		write_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (data->suspended && is_sysmmu_active(data) &&
 			(!pm_runtime_enabled(dev) || data->powered_on))
 			__sysmmu_enable_nocount(data);
 		data->suspended = false;
-		write_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
 	return pm_generic_resume(dev);
@@ -1439,12 +1440,12 @@ static int sysmmu_hook_driver_register(struct notifier_block *nb,
 					dev_get_drvdata(list->sysmmu);
 			unsigned long flags;
 
-			write_lock_irqsave(&data->lock, flags);
+			spin_lock_irqsave(&data->lock, flags);
 			if (is_sysmmu_active(data) && !data->powered_on)
 				__sysmmu_enable_nocount(data);
 			data->powered_on = true;
 			pm_runtime_disable(data->sysmmu);
-			write_unlock_irqrestore(&data->lock, flags);
+			spin_unlock_irqrestore(&data->lock, flags);
 		}
 		break;
 	}
-- 
1.7.9.5
