From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/10] iommu: Remove iommu_register_instance interface
Date: Fri,  3 Feb 2017 16:17:48 +0100
Message-ID: <1486135068-23994-11-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486135068-23994-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

And also move its remaining functionality to
iommu_device_register() and 'struct iommu_device'.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c  |  3 +--
 drivers/iommu/arm-smmu.c     |  4 ++--
 drivers/iommu/exynos-iommu.c |  2 --
 drivers/iommu/iommu.c        | 37 ++++++-------------------------------
 drivers/iommu/msm_iommu.c    |  2 --
 drivers/iommu/mtk_iommu.c    |  1 -
 include/linux/iommu.h        |  8 +-------
 include/linux/of_iommu.h     |  6 ------
 8 files changed, 10 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 37094b5..3b00a2e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2698,10 +2698,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 
 	smmu->iommu.ops = &arm_smmu_ops;
+	smmu->iommu.fwnode = dev->fwnode;
 	ret = iommu_device_register(&smmu->iommu);
 
-	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
-
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
 		pci_request_acs();
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 827e778..dbbd2f2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2112,7 +2112,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	smmu->iommu.ops = &arm_smmu_ops;
+	smmu->iommu.ops    = &arm_smmu_ops;
+	smmu->iommu.fwnode = dev->fwnode;
 
 	err = iommu_device_register(&smmu->iommu);
 	if (err) {
@@ -2120,7 +2121,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 90f0f52..839f6c1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -644,8 +644,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
-
 	return 0;
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 21061da..a7e14b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1647,43 +1647,18 @@ int iommu_request_dm_for_dev(struct device *dev)
 	return ret;
 }
 
-struct iommu_instance {
-	struct list_head list;
-	struct fwnode_handle *fwnode;
-	const struct iommu_ops *ops;
-};
-static LIST_HEAD(iommu_instance_list);
-static DEFINE_SPINLOCK(iommu_instance_lock);
-
-void iommu_register_instance(struct fwnode_handle *fwnode,
-			     const struct iommu_ops *ops)
-{
-	struct iommu_instance *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
-
-	if (WARN_ON(!iommu))
-		return;
-
-	of_node_get(to_of_node(fwnode));
-	INIT_LIST_HEAD(&iommu->list);
-	iommu->fwnode = fwnode;
-	iommu->ops = ops;
-	spin_lock(&iommu_instance_lock);
-	list_add_tail(&iommu->list, &iommu_instance_list);
-	spin_unlock(&iommu_instance_lock);
-}
-
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
-	struct iommu_instance *instance;
 	const struct iommu_ops *ops = NULL;
+	struct iommu_device *iommu;
 
-	spin_lock(&iommu_instance_lock);
-	list_for_each_entry(instance, &iommu_instance_list, list)
-		if (instance->fwnode == fwnode) {
-			ops = instance->ops;
+	spin_lock(&iommu_device_lock);
+	list_for_each_entry(iommu, &iommu_device_list, list)
+		if (iommu->fwnode == fwnode) {
+			ops = iommu->ops;
 			break;
 		}
-	spin_unlock(&iommu_instance_lock);
+	spin_unlock(&iommu_device_lock);
 	return ops;
 }
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 38d19f9..b89b47e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -810,8 +810,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
-
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 9fb7258..f0612aa 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -681,7 +681,6 @@ static int mtk_iommu_init_fn(struct device_node *np)
 		return ret;
 	}
 
-	of_iommu_set_ops(np, &mtk_iommu_ops);
 	return 0;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e53452f..3fac95e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -214,6 +214,7 @@ struct iommu_ops {
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
+	struct fwnode_handle *fwnode;
 	struct device dev;
 };
 
@@ -369,8 +370,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-void iommu_register_instance(struct fwnode_handle *fwnode,
-			     const struct iommu_ops *ops);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 #else /* CONFIG_IOMMU_API */
@@ -601,11 +600,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline void iommu_register_instance(struct fwnode_handle *fwnode,
-					   const struct iommu_ops *ops)
-{
-}
-
 static inline
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 66fcbc9..fc4add3 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,12 +31,6 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-static inline void of_iommu_set_ops(struct device_node *np,
-				    const struct iommu_ops *ops)
-{
-	iommu_register_instance(&np->fwnode, ops);
-}
-
 static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 {
 	return iommu_ops_from_fwnode(&np->fwnode);
-- 
1.9.1
