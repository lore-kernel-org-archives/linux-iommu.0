From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu: Drop the of_iommu_{set/get}_ops() interface
Date: Tue,  3 Jan 2017 17:34:56 +0000
Message-ID: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the introduction of the new iommu_{register/get}_instance()
interface in commit e4f10ffe4c9b ("iommu: Make of_iommu_set/get_ops() DT
agnostic") (based on struct fwnode_handle as look-up token, so firmware
agnostic) to register IOMMU instances with the core IOMMU layer there is
no reason to keep the old OF based interface around any longer.

Convert all the IOMMU drivers (and OF IOMMU core code) that rely on the
of_iommu_{set/get}_ops() to the new kernel interface to register/retrieve
IOMMU instances and remove the of_iommu_{set/get}_ops() remaining glue
code in order to complete the interface rework.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Exynos, msm and mtk code compile tested only owing to lack of
test platforms, I would appreciate some help in testing this
patch on those platforms before merging it even if it is just
a simple interface conversion.

Thanks,
Lorenzo

 drivers/iommu/exynos-iommu.c |  2 +-
 drivers/iommu/msm_iommu.c    |  2 +-
 drivers/iommu/mtk_iommu.c    |  2 +-
 drivers/iommu/of_iommu.c     |  4 ++--
 include/linux/of_iommu.h     | 11 -----------
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57ba0d3..b79e4c4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -628,7 +628,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
+	iommu_register_instance(dev->fwnode, &exynos_iommu_ops);
 
 	return 0;
 }
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b09692b..9cd3cee 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -737,7 +737,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
-	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
+	iommu_register_instance(pdev->dev.fwnode, &msm_iommu_ops);
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1479c76..0596ab2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -655,7 +655,7 @@ static int mtk_iommu_init_fn(struct device_node *np)
 		return ret;
 	}
 
-	of_iommu_set_ops(np, &mtk_iommu_ops);
+	iommu_register_instance(&np->fwnode, &mtk_iommu_ops);
 	return 0;
 }
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 0f57ddc..d7f480a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -127,7 +127,7 @@ static const struct iommu_ops
 			   "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
 		return NULL;
 
-	ops = of_iommu_get_ops(iommu_spec.np);
+	ops = iommu_get_instance(&iommu_spec.np->fwnode);
 	if (!ops || !ops->of_xlate ||
 	    iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
 	    ops->of_xlate(&pdev->dev, &iommu_spec))
@@ -157,7 +157,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   "#iommu-cells", idx,
 					   &iommu_spec)) {
 		np = iommu_spec.np;
-		ops = of_iommu_get_ops(np);
+		ops = iommu_get_instance(&np->fwnode);
 
 		if (!ops || !ops->of_xlate ||
 		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 6a7fc50..13394ac 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,17 +31,6 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-static inline void of_iommu_set_ops(struct device_node *np,
-				    const struct iommu_ops *ops)
-{
-	iommu_register_instance(&np->fwnode, ops);
-}
-
-static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
-{
-	return iommu_get_instance(&np->fwnode);
-}
-
 extern struct of_device_id __iommu_of_table;
 
 typedef int (*of_iommu_init_fn)(struct device_node *);
-- 
2.10.0
