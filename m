From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v4 07/12] iommu/exynos: change rwlock to spinlock
Date: Thu, 22 Nov 2012 20:33:21 +0900
Message-ID: <002801cdc8a5$2d68bbd0$883a3370$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, prathyush.k@samsung.com, 'Joerg Roedel' <joro@8bytes.org>, sw0312.kim@samsung.com, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

Since acquiring read_lock is not more frequent than write_lock, it is
not beneficial to use rwlock, this commit changes rwlock to spinlock.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0bb194e..e39ddac 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -184,7 +184,7 @@ struct sysmmu_drvdata {
 	struct clk *clk;
 	int activations;
 	struct sysmmu_version ver;
-	rwlock_t lock;
+	spinlock_t lock;
 	struct iommu_domain *domain;
 	sysmmu_fault_handler_t fault_handler;
 	unsigned long pgtable;
@@ -288,7 +288,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 	BUG_ON((base0 + size0) <= base0);
 	BUG_ON((size1 > 0) && ((base1 + size1) <= base1));
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (!is_sysmmu_active(data))
 		goto finish;
 
@@ -318,7 +318,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 		}
 	}
 finish:
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void __set_fault_handler(struct sysmmu_drvdata *data,
@@ -326,9 +326,9 @@ static void __set_fault_handler(struct sysmmu_drvdata *data,
 {
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	data->fault_handler = handler;
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 void exynos_sysmmu_set_fault_handler(struct device *dev,
@@ -376,7 +376,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	int i, ret = -ENOSYS;
 
-	read_lock(&data->lock);
+	spin_lock(&data->lock);
 
 	WARN_ON(!is_sysmmu_active(data));
 
@@ -420,7 +420,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbases[i]);
 
-	read_unlock(&data->lock);
+	spin_unlock(&data->lock);
 
 	return IRQ_HANDLED;
 }
@@ -431,7 +431,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	bool disabled = false;
 	int i;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (!set_sysmmu_inactive(data))
 		goto finish;
@@ -446,7 +446,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	data->pgtable = 0;
 	data->domain = NULL;
 finish:
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	if (disabled)
 		dev_dbg(data->sysmmu, "Disabled\n");
@@ -469,7 +469,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 	int i, ret = 0;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (!set_sysmmu_active(data)) {
 		if (WARN_ON(pgtable != data->pgtable)) {
@@ -506,7 +506,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 
 	dev_dbg(data->sysmmu, "Enabled\n");
 finish:
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
@@ -553,7 +553,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
 		int i;
@@ -569,7 +569,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 			"Disabled. Skipping invalidating TLB.\n");
 	}
 
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 void exynos_sysmmu_tlb_invalidate(struct device *dev)
@@ -577,7 +577,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
 		int i;
@@ -592,7 +592,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 			"Disabled. Skipping invalidating TLB.\n");
 	}
 
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static int __init __sysmmu_init_clock(struct device *sysmmu,
@@ -748,7 +748,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	ret = __sysmmu_setup(dev, data);
 	if (!ret) {
 		data->sysmmu = dev;
-		rwlock_init(&data->lock);
+		spin_lock_init(&data->lock);
 		INIT_LIST_HEAD(&data->node);
 
 		__set_fault_handler(data, &default_fault_handler);
-- 
1.8.0
