From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 12/19] iommu/arm-smmu: Streamline SMMU data lookups
Date: Tue, 23 Aug 2016 20:05:23 +0100
Message-ID: <0da78f70b0c9ff99d63e67ea1c99ebf86ad53fb2.1471975357.git.robin.murphy@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Simplify things somewhat by stashing our arm_smmu_device instance in
drvdata, so that it's readily available to our driver model callbacks.
Then we can excise the private list entirely, since the driver core
already has a perfectly good list of SMMU devices we can use in the one
instance we actually need to. Finally, make a further modest code saving
with the relatively new of_device_get_match_data() helper.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 44 +++++++++++---------------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9066fd1399d4..bd6f8bdc7086 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -370,8 +371,6 @@ struct arm_smmu_device {
 	u32				num_context_irqs;
 	unsigned int			*irqs;
 
-	struct list_head		list;
-
 	u32				cavium_id_base; /* Specific to Cavium */
 };
 
@@ -409,9 +408,6 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
-static DEFINE_SPINLOCK(arm_smmu_devices_lock);
-static LIST_HEAD(arm_smmu_devices);
-
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -478,6 +474,8 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 	return err;
 }
 
+static struct platform_driver arm_smmu_driver;
+
 static int arm_smmu_register_legacy_master(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
@@ -495,19 +493,16 @@ static int arm_smmu_register_legacy_master(struct device *dev)
 	}
 
 	it.node = np;
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(smmu, &arm_smmu_devices, list) {
-		err = __find_legacy_master_phandle(smmu->dev, &data);
-		if (err)
-			break;
-	}
-	spin_unlock(&arm_smmu_devices_lock);
+	err = driver_for_each_device(&arm_smmu_driver.driver, NULL, &data,
+				     __find_legacy_master_phandle);
 	of_node_put(np);
 	if (err == 0)
 		return -ENODEV;
 	if (err < 0)
 		return err;
 
+	smmu = dev_get_drvdata(data);
+
 	if (it.cur_count > MAX_MASTER_STREAMIDS) {
 		dev_err(smmu->dev,
 			"reached maximum number (%d) of stream IDs for master device %s\n",
@@ -1791,7 +1786,6 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct arm_smmu_match_data *data;
 	struct resource *res;
 	struct arm_smmu_device *smmu;
@@ -1805,8 +1799,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
-	of_id = of_match_node(arm_smmu_of_match, dev->of_node);
-	data = of_id->data;
+	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
 
@@ -1879,36 +1872,21 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
-	INIT_LIST_HEAD(&smmu->list);
-	spin_lock(&arm_smmu_devices_lock);
-	list_add(&smmu->list, &arm_smmu_devices);
-	spin_unlock(&arm_smmu_devices_lock);
-
+	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	return 0;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 	int i;
-	struct device *dev = &pdev->dev;
-	struct arm_smmu_device *curr, *smmu = NULL;
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev == dev) {
-			smmu = curr;
-			list_del(&smmu->list);
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
 
 	if (!smmu)
 		return -ENODEV;
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
-		dev_err(dev, "removing device with active domains!\n");
+		dev_err(&pdev->dev, "removing device with active domains!\n");
 
 	for (i = 0; i < smmu->num_global_irqs; ++i)
 		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
