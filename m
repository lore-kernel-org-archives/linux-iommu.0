From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 11/13] iommu/rockchip: Use OF_IOMMU to attach devices
	automatically
Date: Tue, 16 Jan 2018 21:25:38 +0800
Message-ID: <20180116132540.18939-12-jeffy.chen@rock-chips.com>
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

Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
which allows attaching master devices to their IOMMUs automatically
according to DT properties.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 116 +++++++++++------------------------------
 1 file changed, 31 insertions(+), 85 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 51e4f982c4a6..c2d3ac82184e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -874,18 +875,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
-	struct iommu_group *group;
-	struct device *iommu_dev;
-	struct rk_iommu *rk_iommu;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return NULL;
-	iommu_dev = iommu_group_get_iommudata(group);
-	rk_iommu = dev_get_drvdata(iommu_dev);
-	iommu_group_put(group);
-
-	return rk_iommu;
+	return dev->archdata.iommu;
 }
 
 static void rk_iommu_detach_device(struct iommu_domain *domain,
@@ -1065,74 +1055,22 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 		iommu_put_dma_cookie(&rk_domain->domain);
 }
 
-static bool rk_iommu_is_dev_iommu_master(struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	int ret;
-
-	/*
-	 * An iommu master has an iommus property containing a list of phandles
-	 * to iommu nodes, each with an #iommu-cells property with value 0.
-	 */
-	ret = of_count_phandle_with_args(np, "iommus", "#iommu-cells");
-	return (ret > 0);
-}
-
-static int rk_iommu_group_set_iommudata(struct iommu_group *group,
-					struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct platform_device *pd;
-	int ret;
-	struct of_phandle_args args;
-
-	/*
-	 * An iommu master has an iommus property containing a list of phandles
-	 * to iommu nodes, each with an #iommu-cells property with value 0.
-	 */
-	ret = of_parse_phandle_with_args(np, "iommus", "#iommu-cells", 0,
-					 &args);
-	if (ret) {
-		dev_err(dev, "of_parse_phandle_with_args(%pOF) => %d\n",
-			np, ret);
-		return ret;
-	}
-	if (args.args_count != 0) {
-		dev_err(dev, "incorrect number of iommu params found for %pOF (found %d, expected 0)\n",
-			args.np, args.args_count);
-		return -EINVAL;
-	}
-
-	pd = of_find_device_by_node(args.np);
-	of_node_put(args.np);
-	if (!pd) {
-		dev_err(dev, "iommu %pOF not found\n", args.np);
-		return -EPROBE_DEFER;
-	}
-
-	/* TODO(djkurtz): handle multiple slave iommus for a single master */
-	iommu_group_set_iommudata(group, &pd->dev, NULL);
-
-	return 0;
-}
-
 static int rk_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 	struct rk_iommu *iommu;
 
-	if (!rk_iommu_is_dev_iommu_master(dev))
+	iommu = rk_iommu_from_dev(dev);
+	if (!iommu)
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
+	iommu_group_put(group);
 
-	iommu = rk_iommu_from_dev(dev);
-	if (iommu)
-		iommu_device_link(&iommu->iommu, dev);
+	iommu_device_link(&iommu->iommu, dev);
 
-	iommu_group_put(group);
 	return 0;
 }
 
@@ -1140,37 +1078,40 @@ static void rk_iommu_remove_device(struct device *dev)
 {
 	struct rk_iommu *iommu;
 
-	if (!rk_iommu_is_dev_iommu_master(dev))
-		return;
-
 	iommu = rk_iommu_from_dev(dev);
-	if (iommu)
-		iommu_device_unlink(&iommu->iommu, dev);
+	if (!iommu)
+		return;
 
+	iommu_device_unlink(&iommu->iommu, dev);
 	iommu_group_remove_device(dev);
 }
 
 static struct iommu_group *rk_iommu_device_group(struct device *dev)
 {
 	struct iommu_group *group;
-	int ret;
 
 	group = iommu_group_get(dev);
-	if (!group) {
+	if (!group)
 		group = iommu_group_alloc();
-		if (IS_ERR(group))
-			return group;
-	}
-
-	ret = rk_iommu_group_set_iommudata(group, dev);
-	if (ret)
-		goto err_put_group;
 
 	return group;
+}
 
-err_put_group:
-	iommu_group_put(group);
-	return ERR_PTR(ret);
+static int rk_iommu_of_xlate(struct device *dev,
+			     struct of_phandle_args *args)
+{
+	struct platform_device *iommu_dev;
+
+	iommu_dev = of_find_device_by_node(args->np);
+	if (!iommu_dev) {
+		dev_err(dev, "iommu %pOF not found\n", args->np);
+		return -ENODEV;
+	}
+
+	dev->archdata.iommu = platform_get_drvdata(iommu_dev);
+	of_dev_put(iommu_dev);
+
+	return 0;
 }
 
 static const struct iommu_ops rk_iommu_ops = {
@@ -1186,6 +1127,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.iova_to_phys = rk_iommu_iova_to_phys,
 	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
+	.of_xlate = rk_iommu_of_xlate,
 };
 
 static int rk_iommu_probe(struct platform_device *pdev)
@@ -1246,6 +1188,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		goto err_put_clocks;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
+	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
+
 	err = iommu_device_register(&iommu->iommu);
 	if (err)
 		goto err_remove_sysfs;
@@ -1307,6 +1251,8 @@ static void __exit rk_iommu_exit(void)
 subsys_initcall(rk_iommu_init);
 module_exit(rk_iommu_exit);
 
+IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu", NULL);
+
 MODULE_DESCRIPTION("IOMMU API for Rockchip");
 MODULE_AUTHOR("Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org> and Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>");
 MODULE_ALIAS("platform:rockchip-iommu");
-- 
2.11.0
