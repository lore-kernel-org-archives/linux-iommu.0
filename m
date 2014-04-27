From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v12 09/31] iommu/exynos: remove dbgname from drvdata of a
 System MMU
Date: Sun, 27 Apr 2014 13:07:41 +0530
Message-ID: <1398584283-22846-10-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch removes dbgname member from sysmmu_drvdata structure.
Kernel message for debugging already has the name of a single
System MMU node. It also removes some compilation warnings.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   54 +++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)
 mode change 100644 => 100755 drivers/iommu/exynos-iommu.c

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
old mode 100644
new mode 100755
index a15216f..1af2d23
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -169,7 +169,6 @@ struct sysmmu_drvdata {
 	struct list_head node; /* entry of exynos_iommu_domain.clients */
 	struct device *sysmmu;	/* System MMU's device descriptor */
 	struct device *dev;	/* Owner of system MMU */
-	char *dbgname;
 	void __iomem *sfrbase;
 	struct clk *clk;
 	int activations;
@@ -320,8 +319,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
 		__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
 	else
-		dev_dbg(data->sysmmu, "(%s) %s is not handled.\n",
-				data->dbgname, sysmmu_fault_name[itype]);
+		dev_dbg(data->sysmmu, "%s is not handled.\n",
+				sysmmu_fault_name[itype]);
 
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
@@ -353,10 +352,10 @@ finish:
 	write_unlock_irqrestore(&data->lock, flags);
 
 	if (disabled)
-		dev_dbg(data->sysmmu, "(%s) Disabled\n", data->dbgname);
+		dev_dbg(data->sysmmu, "Disabled\n");
 	else
-		dev_dbg(data->sysmmu, "(%s) %d times left to be disabled\n",
-					data->dbgname, data->activations);
+		dev_dbg(data->sysmmu, "%d times left to be disabled\n",
+					data->activations);
 
 	return disabled;
 }
@@ -383,7 +382,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 			ret = 1;
 		}
 
-		dev_dbg(data->sysmmu, "(%s) Already enabled\n", data->dbgname);
+		dev_dbg(data->sysmmu, "Already enabled\n");
 		goto finish;
 	}
 
@@ -398,7 +397,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 
 	data->domain = domain;
 
-	dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
+	dev_dbg(data->sysmmu, "Enabled\n");
 finish:
 	write_unlock_irqrestore(&data->lock, flags);
 
@@ -414,16 +413,15 @@ int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
 
 	ret = pm_runtime_get_sync(data->sysmmu);
 	if (ret < 0) {
-		dev_dbg(data->sysmmu, "(%s) Failed to enable\n", data->dbgname);
+		dev_dbg(data->sysmmu, "Failed to enable\n");
 		return ret;
 	}
 
 	ret = __exynos_sysmmu_enable(data, pgtable, NULL);
 	if (WARN_ON(ret < 0)) {
 		pm_runtime_put(data->sysmmu);
-		dev_err(data->sysmmu,
-			"(%s) Already enabled with page table %#lx\n",
-			data->dbgname, data->pgtable);
+		dev_err(data->sysmmu, "Already enabled with page table %#lx\n",
+			data->pgtable);
 	} else {
 		data->dev = dev;
 	}
@@ -473,9 +471,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
-		dev_dbg(data->sysmmu,
-			"(%s) Disabled. Skipping invalidating TLB.\n",
-			data->dbgname);
+		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
 
 	read_unlock_irqrestore(&data->lock, flags);
@@ -494,9 +490,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
-		dev_dbg(data->sysmmu,
-			"(%s) Disabled. Skipping invalidating TLB.\n",
-			data->dbgname);
+		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
 
 	read_unlock_irqrestore(&data->lock, flags);
@@ -559,7 +553,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
+	dev_dbg(dev, "Initialized\n");
 	return 0;
 err_irq:
 	free_irq(platform_get_irq(pdev, 0), data);
@@ -659,6 +653,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 	struct exynos_iommu_domain *priv = domain->priv;
+	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
 	int ret;
 
@@ -682,15 +677,15 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	if (ret < 0) {
-		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#lx\n",
-				__func__, __pa(priv->pgtable));
+		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
+					__func__, &pagetable);
 		pm_runtime_put(data->sysmmu);
 	} else if (ret > 0) {
-		dev_dbg(dev, "%s: IOMMU with pgtable 0x%lx already attached\n",
-					__func__, __pa(priv->pgtable));
+		dev_dbg(dev, "%s: IOMMU with pgtable %pa already attached\n",
+					__func__, &pagetable);
 	} else {
-		dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n",
-					__func__, __pa(priv->pgtable));
+		dev_dbg(dev, "%s: Attached new IOMMU with pgtable %pa\n",
+					__func__, &pagetable);
 	}
 
 	return ret;
@@ -702,6 +697,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
 	struct exynos_iommu_domain *priv = domain->priv;
 	struct list_head *pos;
+	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
 	unsigned long flags;
 	bool found = false;
 
@@ -718,13 +714,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 		goto finish;
 
 	if (__exynos_sysmmu_disable(data)) {
-		dev_dbg(dev, "%s: Detached IOMMU with pgtable %#lx\n",
-					__func__, __pa(priv->pgtable));
+		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
+					__func__, &pagetable);
 		list_del_init(&data->node);
 
 	} else {
-		dev_dbg(dev, "%s: Detaching IOMMU with pgtable %#lx delayed",
-					__func__, __pa(priv->pgtable));
+		dev_dbg(dev, "%s: Detaching IOMMU with pgtable %pa delayed",
+					__func__, &pagetable);
 	}
 
 finish:
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
