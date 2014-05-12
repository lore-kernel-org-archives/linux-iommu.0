From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v13 08/19] iommu/exynos: remove dbgname from drvdata of a
	System MMU
Date: Mon, 12 May 2014 11:44:53 +0530
Message-ID: <1399875304-19948-9-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1399875304-19948-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch removes dbgname member from sysmmu_drvdata structure.
Kernel message for debugging already has the name of a single
System MMU node. It also removes some compilation warnings.

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index ef771a2..be7a7b9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -170,7 +170,6 @@ struct sysmmu_drvdata {
 	struct list_head node; /* entry of exynos_iommu_domain.clients */
 	struct device *sysmmu;	/* System MMU's device descriptor */
 	struct device *dev;	/* Owner of system MMU */
-	char *dbgname;
 	void __iomem *sfrbase;
 	struct clk *clk;
 	int activations;
@@ -321,8 +320,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
 		__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
 	else
-		dev_dbg(data->sysmmu, "(%s) %s is not handled.\n",
-				data->dbgname, sysmmu_fault_name[itype]);
+		dev_dbg(data->sysmmu, "%s is not handled.\n",
+				sysmmu_fault_name[itype]);
 
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
@@ -354,10 +353,10 @@ finish:
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
@@ -384,7 +383,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 			ret = 1;
 		}
 
-		dev_dbg(data->sysmmu, "(%s) Already enabled\n", data->dbgname);
+		dev_dbg(data->sysmmu, "Already enabled\n");
 		goto finish;
 	}
 
@@ -399,7 +398,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 
 	data->domain = domain;
 
-	dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
+	dev_dbg(data->sysmmu, "Enabled\n");
 finish:
 	write_unlock_irqrestore(&data->lock, flags);
 
@@ -415,16 +414,15 @@ int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
 
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
-			"(%s) Already enabled with page table %#x\n",
-			data->dbgname, data->pgtable);
+		dev_err(data->sysmmu, "Already enabled with page table %#x\n",
+			data->pgtable);
 	} else {
 		data->dev = dev;
 	}
@@ -474,9 +472,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
-		dev_dbg(data->sysmmu,
-			"(%s) Disabled. Skipping invalidating TLB.\n",
-			data->dbgname);
+		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
 
 	read_unlock_irqrestore(&data->lock, flags);
@@ -495,9 +491,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
-		dev_dbg(data->sysmmu,
-			"(%s) Disabled. Skipping invalidating TLB.\n",
-			data->dbgname);
+		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
 
 	read_unlock_irqrestore(&data->lock, flags);
@@ -560,7 +554,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
+	dev_dbg(dev, "Initialized\n");
 	return 0;
 err_irq:
 	free_irq(platform_get_irq(pdev, 0), data);
-- 
1.7.9.5
