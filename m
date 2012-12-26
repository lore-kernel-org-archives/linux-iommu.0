From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 04/12] iommu/exynos: change rwlock to spinlock
Date: Wed, 26 Dec 2012 10:53:42 +0900
Message-ID: <003701cde30b$d5754430$805fcc90$%cho@samsung.com>
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

Since acquiring read_lock is not more frequent than write_lock, it is
not beneficial to use rwlock, this commit changes rwlock to spinlock.

Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 58d2a24..5847508 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -166,7 +166,7 @@ struct sysmmu_drvdata {
 	void __iomem **sfrbases;
 	struct clk *clk[2];
 	int activations;
-	rwlock_t lock;
+	spinlock_t lock;
 	struct iommu_domain *domain;
 	unsigned long pgtable;
 };
@@ -249,7 +249,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 	BUG_ON((base0 + size0) <= base0);
 	BUG_ON((size1 > 0) && ((base1 + size1) <= base1));
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (!is_sysmmu_active(data))
 		goto finish;
 
@@ -279,7 +279,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 		}
 	}
 finish:
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void __show_fault_information(unsigned long *pgtable, unsigned long iova,
@@ -312,7 +312,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	int i, ret = -ENOSYS;
 
-	read_lock(&data->lock);
+	spin_lock(&data->lock);
 
 	WARN_ON(!is_sysmmu_active(data));
 
@@ -354,7 +354,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	sysmmu_unblock(data->sfrbases[i]);
 
-	read_unlock(&data->lock);
+	spin_unlock(&data->lock);
 
 	return IRQ_HANDLED;
 }
@@ -365,7 +365,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	bool disabled = false;
 	int i;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (!set_sysmmu_inactive(data))
 		goto finish;
@@ -382,7 +382,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	data->pgtable = 0;
 	data->domain = NULL;
 finish:
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	if (disabled)
 		dev_dbg(data->sysmmu, "(%s) Disabled\n", data->dbgname);
@@ -405,7 +405,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 	int i, ret = 0;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (!set_sysmmu_active(data)) {
 		if (WARN_ON(pgtable != data->pgtable)) {
@@ -444,7 +444,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 
 	dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
 finish:
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
@@ -491,7 +491,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
 		int i;
@@ -508,7 +508,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 			data->dbgname);
 	}
 
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 void exynos_sysmmu_tlb_invalidate(struct device *dev)
@@ -516,7 +516,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
 		int i;
@@ -532,7 +532,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 			data->dbgname);
 	}
 
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
@@ -629,7 +629,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->sysmmu = dev;
-	rwlock_init(&data->lock);
+	spin_lock_init(&data->lock);
 	INIT_LIST_HEAD(&data->node);
 
 	if (dev->parent)
-- 
1.8.0
