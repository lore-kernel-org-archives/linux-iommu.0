From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 07/12] iommu/arm-smmu: Factor out mmu-masters handling
Date: Mon, 29 Feb 2016 13:46:16 +0000
Message-ID: <c2ba73b6e6c4df89b4739ac4e759f925c0bcd6ec.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Reorder the SMMU probe routine slightly to separate probing and
configuring the SMMU itself from processing the mmu-masters property,
and break the handling of the latter out into self-contained functions.

In preparation for changes to come, the failure mode is changed slightly
such that instead of a malformed mmu-masters property aborting the whole
SMMU device probe, we instead roll back any association with those
master devices and let the SMMU itself continue without them.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 88 ++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 514ae2d..6f7c531 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -465,7 +465,6 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 }
 
 static int register_smmu_master(struct arm_smmu_device *smmu,
-				struct device *dev,
 				struct of_phandle_args *masterspec)
 {
 	int i;
@@ -473,20 +472,20 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 
 	master = find_smmu_master(smmu, masterspec->np);
 	if (master) {
-		dev_err(dev,
+		dev_err(smmu->dev,
 			"rejecting multiple registrations for master device %s\n",
 			masterspec->np->name);
 		return -EBUSY;
 	}
 
 	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
-		dev_err(dev,
+		dev_err(smmu->dev,
 			"reached maximum number (%d) of stream IDs for master device %s\n",
 			MAX_MASTER_STREAMIDS, masterspec->np->name);
 		return -ENOSPC;
 	}
 
-	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
+	master = devm_kzalloc(smmu->dev, sizeof(*master), GFP_KERNEL);
 	if (!master)
 		return -ENOMEM;
 
@@ -498,7 +497,7 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 
 		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
 		     (streamid >= smmu->num_mapping_groups)) {
-			dev_err(dev,
+			dev_err(smmu->dev,
 				"stream ID for master device %s greater than maximum allowed (%d)\n",
 				masterspec->np->name, smmu->num_mapping_groups);
 			return -ERANGE;
@@ -1730,14 +1729,53 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static void arm_smmu_remove_mmu_masters(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_master *master;
+	struct rb_node *node, *tmp;
+
+	node = rb_first(&smmu->masters);
+	while (node) {
+		tmp = node;
+		node = rb_next(node);
+		master = container_of(tmp, struct arm_smmu_master, node);
+
+		rb_erase(tmp, &smmu->masters);
+		of_node_put(master->of_node);
+		devm_kfree(smmu->dev, master);
+	}
+}
+
+static int arm_smmu_probe_mmu_masters(struct arm_smmu_device *smmu)
+{
+	struct of_phandle_args masterspec;
+	int err, i = 0;
+
+	while (!of_parse_phandle_with_args(smmu->dev->of_node, "mmu-masters",
+			"#stream-id-cells", i,
+			&masterspec)) {
+		err = register_smmu_master(smmu, &masterspec);
+		if (err)
+			break;
+		i++;
+	}
+
+	if (err) {
+		dev_err(smmu->dev, "failed to register mmu-masters\n");
+		arm_smmu_remove_mmu_masters(smmu);
+	} else if (i) {
+		dev_info(smmu->dev, "registered %d mmu-masters\n", i);
+	}
+
+	return err;
+}
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct resource *res;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	struct rb_node *node;
-	struct of_phandle_args masterspec;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -1796,22 +1834,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	i = 0;
-	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
-		if (err) {
-			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
-			goto out_put_masters;
-		}
-
-		i++;
-	}
-	dev_notice(dev, "registered %d master devices\n", i);
-
 	parse_driver_options(smmu);
 
 	if (smmu->version > ARM_SMMU_V1 &&
@@ -1819,8 +1841,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		dev_err(dev,
 			"found only %d context interrupt(s) but %d required\n",
 			smmu->num_context_irqs, smmu->num_context_banks);
-		err = -ENODEV;
-		goto out_put_masters;
+		return -ENODEV;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
@@ -1837,6 +1858,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, smmu);
+	arm_smmu_probe_mmu_masters(smmu);
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
@@ -1848,14 +1870,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 out_free_irqs:
 	while (i--)
 		free_irq(smmu->irqs[i], smmu);
-
-out_put_masters:
-	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master
-			= container_of(node, struct arm_smmu_master, node);
-		of_node_put(master->of_node);
-	}
-
 	return err;
 }
 
@@ -1863,21 +1877,15 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 	int i;
-	struct rb_node *node;
 
 	if (!smmu)
 		return -ENODEV;
 
+	arm_smmu_remove_mmu_masters(smmu);
 	spin_lock(&arm_smmu_devices_lock);
 	list_del(&smmu->list);
 	spin_unlock(&arm_smmu_devices_lock);
 
-	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master
-			= container_of(node, struct arm_smmu_master, node);
-		of_node_put(master->of_node);
-	}
-
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
-- 
2.7.2.333.g70bd996.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
