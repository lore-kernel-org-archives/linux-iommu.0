From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Rework runtime PM links management
Date: Fri, 15 Sep 2017 13:05:08 +0200
Message-ID: <1505473508-10094-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170915110514eucas1p207463649130d3a9522a50c292b0d2521@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

add_device is a bit more suitable for establishing runtime PM links than
the xlate callback. This change also makes it possible to implement proper
cleanup - in remove_device callback.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index f596fcc32898..91c548d49b92 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -263,6 +263,7 @@ struct exynos_iommu_domain {
 struct sysmmu_drvdata {
 	struct device *sysmmu;		/* SYSMMU controller device */
 	struct device *master;		/* master device (owner) */
+	struct device_link *link;	/* runtime PM link to master */
 	void __iomem *sfrbase;		/* our registers */
 	struct clk *clk;		/* SYSMMU's clock */
 	struct clk *aclk;		/* SYSMMU's aclk clock */
@@ -1250,6 +1251,8 @@ static struct iommu_group *get_device_iommu_group(struct device *dev)
 
 static int exynos_iommu_add_device(struct device *dev)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct sysmmu_drvdata *data;
 	struct iommu_group *group;
 
 	if (!has_sysmmu(dev))
@@ -1260,6 +1263,15 @@ static int exynos_iommu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	list_for_each_entry(data, &owner->controllers, owner_node) {
+		/*
+		 * SYSMMU will be runtime activated via device link
+		 * (dependency) to its master device, so there are no
+		 * direct calls to pm_runtime_get/put in this driver.
+		 */
+		data->link = device_link_add(dev, data->sysmmu,
+					     DL_FLAG_PM_RUNTIME);
+	}
 	iommu_group_put(group);
 
 	return 0;
@@ -1268,6 +1280,7 @@ static int exynos_iommu_add_device(struct device *dev)
 static void exynos_iommu_remove_device(struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct sysmmu_drvdata *data;
 
 	if (!has_sysmmu(dev))
 		return;
@@ -1283,6 +1296,9 @@ static void exynos_iommu_remove_device(struct device *dev)
 		}
 	}
 	iommu_group_remove_device(dev);
+
+	list_for_each_entry(data, &owner->controllers, owner_node)
+		device_link_del(data->link);
 }
 
 static int exynos_iommu_of_xlate(struct device *dev,
@@ -1316,13 +1332,6 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	list_add_tail(&data->owner_node, &owner->controllers);
 	data->master = dev;
 
-	/*
-	 * SYSMMU will be runtime activated via device link (dependency) to its
-	 * master device, so there are no direct calls to pm_runtime_get/put
-	 * in this driver.
-	 */
-	device_link_add(dev, data->sysmmu, DL_FLAG_PM_RUNTIME);
-
 	return 0;
 }
 
-- 
1.9.1
