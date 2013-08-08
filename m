From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v9 12/16] iommu/exynos: add bus notifier for registering System
	MMU
Date: Thu, 08 Aug 2013 18:40:32 +0900
Message-ID: <003001ce941b$53a89cb0$faf9d610$@samsung.com>
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

When a device driver is registered, all constructs to handle System MMU
is prepared by bus notifier call.
This changes in how to retrieving System MMU from the device descriptor
of master H/W.

Previously archdata.iommu of master H/W contains the device descriptor
of System MMU and the device descriptor of System MMU has the list entry
of iommu_domain. In fact, System MMU is attached to iommu_domain.

This changes what is actually attached to iommu_domain.
archdata.iommu of master H/W contains ponter to the device descriptor
of System MMU and the list entry of iommu_domain.
Thus what attached to iommu_domain is now master H/W.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |  435 ++++++++++++++++++++++++++++--------------
 1 files changed, 291 insertions(+), 144 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 686e3c8..8240f7f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -27,6 +27,8 @@
 #include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/notifier.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
@@ -154,6 +156,14 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 	"UNKNOWN FAULT"
 };
 
+struct exynos_iommu_client {
+	struct list_head node;	/* entry of exynos_iommu_domain.clients */
+	struct device *dev;
+	spinlock_t lock;
+	int num_sysmmu;
+	struct device *sysmmu[0];
+};
+
 struct exynos_iommu_domain {
 	struct list_head clients; /* list of sysmmu_drvdata.node */
 	unsigned long *pgtable; /* lv1 page table, 16KB */
@@ -163,9 +173,8 @@ struct exynos_iommu_domain {
 };
 
 struct sysmmu_drvdata {
-	struct list_head node; /* entry of exynos_iommu_domain.clients */
 	struct device *sysmmu;	/* System MMU's device descriptor */
-	struct device *dev;	/* Owner of system MMU */
+	struct device *master;	/* Owner of system MMU */
 	int nsfrs;
 	struct clk *clk;
 	struct clk *clk_master;
@@ -246,7 +255,6 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
 static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 				       unsigned long pgd)
 {
-	__raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, LRU */
 	__raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
 
 	__sysmmu_tlb_invalidate(sfrbase);
@@ -336,12 +344,13 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
+	struct exynos_iommu_client *client = NULL;
 	enum exynos_sysmmu_inttype itype;
 	unsigned long addr = -1;
-
 	int i, ret = -ENOSYS;
 
-	read_lock(&data->lock);
+	if (data->master)
+		client = data->master->archdata.iommu;
 
 	WARN_ON(!is_sysmmu_active(data));
 
@@ -354,6 +363,9 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	}
 
 	clk_enable(data->clk_master);
+	if (client)
+		spin_lock(&client->lock);
+	read_lock(&data->lock);
 
 	if (i == data->nsfrs) {
 		itype = SYSMMU_FAULT_UNKNOWN;
@@ -368,7 +380,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	}
 
 	if (data->domain)
-		ret = report_iommu_fault(data->domain, data->dev,
+		ret = report_iommu_fault(data->domain, data->master,
 				addr, itype);
 
 	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
@@ -387,179 +399,246 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	clk_disable(data->clk_master);
 
 	read_unlock(&data->lock);
+	if (client)
+		spin_unlock(&client->lock);
 
 	return IRQ_HANDLED;
 }
 
-static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
+static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 {
-	unsigned long flags;
-	bool disabled = false;
 	int i;
 
-	write_lock_irqsave(&data->lock, flags);
+	clk_enable(data->clk_master);
+	for (i = 0; i < data->nsfrs; i++) {
+		__raw_writel(CTRL_DISABLE,
+				data->sfrbases[i] + REG_MMU_CTRL);
+		__raw_writel(0, data->sfrbases[i] + REG_MMU_CFG);
+	}
 
-	if (!set_sysmmu_inactive(data))
-		goto finish;
+	clk_disable(data->clk);
+	clk_disable(data->clk_master);
+}
 
-	clk_enable(data->clk_master);
+static bool __sysmmu_disable(struct sysmmu_drvdata *data)
+{
+	bool disabled;
+	unsigned long flags;
 
-	for (i = 0; i < data->nsfrs; i++)
-		__raw_writel(CTRL_DISABLE, data->sfrbases[i] + REG_MMU_CTRL);
+	write_lock_irqsave(&data->lock, flags);
 
-	clk_disable(data->clk_master);
+	disabled = set_sysmmu_inactive(data);
 
-	clk_disable(data->clk);
+	if (disabled) {
+		data->pgtable = 0;
+		data->domain = NULL;
 
-	disabled = true;
-	data->pgtable = 0;
-	data->domain = NULL;
-finish:
-	write_unlock_irqrestore(&data->lock, flags);
+		__sysmmu_disable_nocount(data);
 
-	if (disabled)
 		dev_dbg(data->sysmmu, "Disabled\n");
-	else
-		dev_dbg(data->sysmmu, "%d times left to be disabled\n",
+	} else  {
+		dev_dbg(data->sysmmu, "%d times left to disable\n",
 					data->activations);
+	}
+
+	write_unlock_irqrestore(&data->lock, flags);
 
 	return disabled;
 }
 
-/* __exynos_sysmmu_enable: Enables System MMU
- *
- * returns -error if an error occurred and System MMU is not enabled,
- * 0 if the System MMU has been just enabled and 1 if System MMU was already
- * enabled before.
- */
-static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
-			unsigned long pgtable, struct iommu_domain *domain)
+
+static void __sysmmu_init_config(struct sysmmu_drvdata *data, int idx)
 {
-	int i, ret = 0;
-	unsigned long flags;
+	unsigned long cfg = 0;
+	int maj, min = 0;
 
-	write_lock_irqsave(&data->lock, flags);
+	maj = __sysmmu_version(data, idx, &min);
+	if ((maj == 3) && (min > 1))
+		cfg |= CFG_FLPDCACHE;
 
-	if (!set_sysmmu_active(data)) {
-		if (WARN_ON(pgtable != data->pgtable)) {
-			ret = -EBUSY;
-			set_sysmmu_inactive(data);
-		} else {
-			ret = 1;
-		}
+	__raw_writel(cfg, data->sfrbases[idx] + REG_MMU_CFG);
+}
 
-		dev_dbg(data->sysmmu, "Already enabled\n");
-		goto finish;
-	}
+static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
+{
+	int i;
 
 	clk_enable(data->clk);
 
-	data->pgtable = pgtable;
-
 	clk_enable(data->clk_master);
 
 	for (i = 0; i < data->nsfrs; i++) {
-		unsigned int min;
+		__raw_writel(CTRL_BLOCK, data->sfrbases[i] + REG_MMU_CTRL);
 
-		__sysmmu_set_ptbase(data->sfrbases[i], pgtable);
+		__sysmmu_init_config(data, i);
 
-		if ((__sysmmu_version(data, i, &min) == 3) && (min > 1)) {
-			unsigned long cfg;
-			cfg = __raw_readl(data->sfrbases[i] + REG_MMU_CFG);
-			__raw_writel(cfg | CFG_FLPDCACHE,
-					data->sfrbases[i] + REG_MMU_CFG);
-		}
+		__sysmmu_set_ptbase(data->sfrbases[i], data->pgtable);
 
 		__raw_writel(CTRL_ENABLE, data->sfrbases[i] + REG_MMU_CTRL);
 	}
 
 	clk_disable(data->clk_master);
+}
 
-	data->domain = domain;
+static int __sysmmu_enable(struct sysmmu_drvdata *data,
+			unsigned long pgtable, struct iommu_domain *domain)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	write_lock_irqsave(&data->lock, flags);
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
 	write_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
 
+/* __exynos_sysmmu_enable: Enables System MMU
+ *
+ * returns -error if an error occurred and System MMU is not enabled,
+ * 0 if the System MMU has been just enabled and 1 if System MMU was already
+ * enabled before.
+ */
+static int __exynos_sysmmu_enable(struct device *dev, unsigned long pgtable,
+				  struct iommu_domain *domain)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int i;
+
+	if (WARN_ON(!client))
+		return -ENODEV;
+
+	spin_lock_irqsave(&client->lock, flags);
+
+	for (i = 0; i < client->num_sysmmu; i++) {
+		struct sysmmu_drvdata *data =
+				dev_get_drvdata(client->sysmmu[i]);
+		ret = __sysmmu_enable(data, pgtable, domain);
+		if (ret < 0) {
+			int j;
+			for (j = 0; j < i; j++)
+				__sysmmu_disable(data);
+			break;
+		} else {
+			data->master = dev;
+		}
+	}
+
+	spin_unlock_irqrestore(&client->lock, flags);
+
+	return ret;
+}
+
 int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 	int ret;
 
 	BUG_ON(!memblock_is_memory(pgtable));
 
-	ret = __exynos_sysmmu_enable(data, pgtable, NULL);
-	if (WARN_ON(ret < 0)) {
-		dev_err(data->sysmmu,
-			"Already enabled with page table %#lx\n",
-			data->pgtable);
-	} else {
-		data->dev = dev;
-	}
+	ret = __exynos_sysmmu_enable(dev, pgtable, NULL);
 
 	return ret;
 }
 
 static bool exynos_sysmmu_disable(struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-	bool disabled;
+	unsigned long flags;
+	bool disabled = true;
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int i;
+
+	if (WARN_ON(!client))
+		return true;
 
-	disabled = __exynos_sysmmu_disable(data);
+	spin_lock_irqsave(&client->lock, flags);
+
+	/* Every call to __sysmmu_disable() must return same result */
+	for (i = 0; i < client->num_sysmmu; i++) {
+		struct sysmmu_drvdata *data =
+				dev_get_drvdata(client->sysmmu[i]);
+		disabled = __sysmmu_disable(data);
+		if (disabled)
+			data->master = NULL;
+	}
+
+	spin_unlock_irqrestore(&client->lock, flags);
 
 	return disabled;
 }
 
 static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 {
-	unsigned long flags;
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int i;
 
-	read_lock_irqsave(&data->lock, flags);
+	for (i = 0; i < client->num_sysmmu; i++) {
+		unsigned long flags;
+		struct sysmmu_drvdata *data;
 
-	if (is_sysmmu_active(data)) {
-		int i;
-		clk_enable(data->clk_master);
-		for (i = 0; i < data->nsfrs; i++) {
-			if (sysmmu_block(data->sfrbases[i])) {
+		data = dev_get_drvdata(client->sysmmu[i]);
+
+		read_lock_irqsave(&data->lock, flags);
+		if (is_sysmmu_active(data)) {
+			int i;
+			clk_enable(data->clk_master);
+			for (i = 0; i < data->nsfrs; i++)
 				__sysmmu_tlb_invalidate_entry(
 						data->sfrbases[i], iova);
-				sysmmu_unblock(data->sfrbases[i]);
-			}
+			clk_disable(data->clk_master);
+		} else {
+			dev_dbg(dev,
+				"disabled. Skipping TLB invalidation @ %#lx\n",
+				iova);
 		}
-		clk_disable(data->clk_master);
-	} else {
-		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
+		read_unlock_irqrestore(&data->lock, flags);
 	}
-
-	read_unlock_irqrestore(&data->lock, flags);
 }
 
 void exynos_sysmmu_tlb_invalidate(struct device *dev)
 {
-	unsigned long flags;
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-
-	read_lock_irqsave(&data->lock, flags);
+	struct exynos_iommu_client *client = dev->archdata.iommu;
+	int i;
 
-	if (is_sysmmu_active(data)) {
-		int i;
-		clk_enable(data->clk_master);
-		for (i = 0; i < data->nsfrs; i++) {
-			if (sysmmu_block(data->sfrbases[i])) {
-				__sysmmu_tlb_invalidate(data->sfrbases[i]);
-				sysmmu_unblock(data->sfrbases[i]);
+	for (i = 0; i < client->num_sysmmu; i++) {
+		unsigned long flags;
+		struct sysmmu_drvdata *data;
+
+		data = dev_get_drvdata(client->sysmmu[i]);
+
+		read_lock_irqsave(&data->lock, flags);
+		if (is_sysmmu_active(data)) {
+			int i;
+			for (i = 0; i < data->nsfrs; i++) {
+				clk_enable(data->clk_master);
+				if (sysmmu_block(data->sfrbases[i])) {
+					__sysmmu_tlb_invalidate(
+							data->sfrbases[i]);
+					sysmmu_unblock(data->sfrbases[i]);
+				}
+				clk_disable(data->clk_master);
 			}
+		} else {
+			dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 		}
-		clk_disable(data->clk_master);
-	} else {
-		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
+		read_unlock_irqrestore(&data->lock, flags);
 	}
-
-	read_unlock_irqrestore(&data->lock, flags);
 }
 
 static int __init exynos_sysmmu_probe(struct platform_device *pdev)
@@ -619,6 +698,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->sysmmu = dev;
+
 	data->clk = devm_clk_get(dev, "sysmmu");
 	if (IS_ERR(data->clk)) {
 		dev_info(dev, "No gate clock found!\n");
@@ -643,7 +723,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	rwlock_init(&data->lock);
-	INIT_LIST_HEAD(&data->node);
 
 	platform_set_drvdata(pdev, data);
 	dev_dbg(dev, "Probed and initialized\n");
@@ -715,7 +794,7 @@ err_pgtable:
 static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct sysmmu_drvdata *data;
+	struct exynos_iommu_client *client;
 	unsigned long flags;
 	int i;
 
@@ -723,11 +802,14 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each_entry(data, &priv->clients, node) {
-		while (!exynos_sysmmu_disable(data->dev))
+	list_for_each_entry(client, &priv->clients, node) {
+		while (!exynos_sysmmu_disable(client->dev))
 			; /* until System MMU is actually disabled */
 	}
 
+	while (!list_empty(&priv->clients))
+		list_del_init(priv->clients.next);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
@@ -744,34 +826,26 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 static int exynos_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct exynos_iommu_client *client = dev->archdata.iommu;
 	struct exynos_iommu_domain *priv = domain->priv;
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	ret = __exynos_sysmmu_enable(data, __pa(priv->pgtable), domain);
-
-	if (ret == 0) {
-		/* 'data->node' must not be appeared in priv->clients */
-		BUG_ON(!list_empty(&data->node));
-		data->dev = dev;
-		list_add_tail(&data->node, &priv->clients);
-	}
+	ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
+	if (ret == 0)
+		list_add_tail(&client->node, &priv->clients);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#lx\n",
 				__func__, __pa(priv->pgtable));
-	} else if (ret > 0) {
-		dev_dbg(dev, "%s: IOMMU with pgtable 0x%lx already attached\n",
-					__func__, __pa(priv->pgtable));
-	} else {
-		dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n",
-					__func__, __pa(priv->pgtable));
-	}
+	else
+		dev_dbg(dev, "%s: Attached IOMMU with pgtable 0x%lx%s\n",
+					__func__, __pa(priv->pgtable),
+					(ret == 0) ? "" : ", again");
 
 	return ret;
 }
@@ -779,36 +853,27 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
+	struct exynos_iommu_client *client = NULL;
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct list_head *pos;
 	unsigned long flags;
-	bool found = false;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	list_for_each(pos, &priv->clients) {
-		if (list_entry(pos, struct sysmmu_drvdata, node) == data) {
-			found = true;
+	list_for_each_entry(client, &priv->clients, node) {
+		if (client == dev->archdata.iommu) {
+			if (exynos_sysmmu_disable(dev))
+				list_del_init(&client->node);
 			break;
 		}
 	}
 
-	if (!found)
-		goto finish;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (__exynos_sysmmu_disable(data)) {
+	if (client == dev->archdata.iommu)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %#lx\n",
 					__func__, __pa(priv->pgtable));
-		list_del_init(&data->node);
-
-	} else {
-		dev_dbg(dev, "%s: Detaching IOMMU with pgtable %#lx delayed",
-					__func__, __pa(priv->pgtable));
-	}
-
-finish:
-	spin_unlock_irqrestore(&priv->lock, flags);
+	else
+		dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
 }
 
 static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
@@ -920,7 +985,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 					       unsigned long iova, size_t size)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
-	struct sysmmu_drvdata *data;
+	struct exynos_iommu_client *client;
 	unsigned long flags;
 	unsigned long *ent;
 	size_t err_pgsize;
@@ -981,8 +1046,8 @@ done:
 	spin_unlock_irqrestore(&priv->pgtablelock, flags);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(data, &priv->clients, node)
-		sysmmu_tlb_invalidate_entry(data->dev, iova);
+	list_for_each_entry(client, &priv->clients, node)
+		sysmmu_tlb_invalidate_entry(client->dev, iova);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return size;
@@ -1061,3 +1126,85 @@ static int __init exynos_iommu_init(void)
 	return ret;
 }
 subsys_initcall(exynos_iommu_init);
+
+static int sysmmu_hook_driver_register(struct notifier_block *nb,
+					unsigned long val,
+					void *p)
+{
+	struct device *dev = p;
+
+	switch (val) {
+	case BUS_NOTIFY_BIND_DRIVER:
+	{
+		int i = 0;
+		int size = 0;
+		const __be32 *phandle;
+		struct exynos_iommu_client *client;
+
+		phandle = of_get_property(dev->of_node, "iommu", &size);
+		if (!phandle)
+			break;
+
+		size = size / sizeof(*phandle); /* number of elements */
+
+		client = devm_kzalloc(dev, sizeof(*client) * size, GFP_KERNEL);
+		if (!client) {
+			dev_err(dev, "No Memory for exynos_iommu_client\n");
+			return -ENOMEM;
+		}
+
+		client->num_sysmmu = size;
+		client->dev = dev;
+		INIT_LIST_HEAD(&client->node);
+		spin_lock_init(&client->lock);
+
+		for (i = 0; i < size; i++) {
+			struct device_node *np;
+			struct platform_device *sysmmu;
+
+			/* this always success: see above of_find_property() */
+			np = of_parse_phandle(dev->of_node, "iommu", i);
+
+			sysmmu = of_find_device_by_node(np);
+			if (!sysmmu) {
+				dev_err(dev,
+					"sysmmu node '%s' is not found\n",
+					np->name);
+				break;
+			}
+
+			client->sysmmu[i] = &sysmmu->dev;
+		}
+
+		if (i < size) {
+			while (--i >= 0)
+				of_node_put(client->sysmmu[i]->of_node);
+			devm_kfree(dev, client);
+			return -ENODEV;
+		}
+
+		dev->archdata.iommu = client;
+		break;
+	}
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+	{
+		if (dev->archdata.iommu) {
+			devm_kfree(dev, dev->archdata.iommu);
+			dev->archdata.iommu = NULL;
+		}
+		break;
+	}
+	} /* switch (val) */
+
+	return 0;
+}
+
+static struct notifier_block sysmmu_notifier = {
+	.notifier_call = &sysmmu_hook_driver_register,
+};
+
+static int __init exynos_iommu_prepare(void)
+{
+	return bus_register_notifier(&platform_bus_type, &sysmmu_notifier);
+}
+arch_initcall(exynos_iommu_prepare);
-- 
1.7.2.5
