From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 09/12] iommu/arm-smmu: Simplify mmu-masters handling
Date: Mon, 29 Feb 2016 13:46:18 +0000
Message-ID: <535593468d8489fa217513da4fa4ebcc6c8c57c6.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the preceding data reshuffles allowing SMMU instances to be looked
up directly wherever needed, we can now wipe out the last vestiges of
the global SMMU list. With mmu-masters lookup now a one-time thing
outside of any real hotpath, condense our stash of those out of the SMMU
instance data down to a single shared list, where they may await their
eventual deprecation.

This also seems like a good opportunity to move the parts only relevant
to the probe/remove routines down to live in that area of the code.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 231 +++++++++++++++++++----------------------------
 1 file changed, 91 insertions(+), 140 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5eaa8cf..91b0a1b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -301,7 +301,7 @@ struct arm_smmu_group_cfg {
 
 struct arm_smmu_master {
 	struct device_node		*of_node;
-	struct rb_node			node;
+	struct list_head		list;
 	struct arm_smmu_master_cfg	cfg;
 };
 
@@ -372,8 +372,8 @@ struct arm_smmu_domain {
 
 static struct iommu_ops arm_smmu_ops;
 
-static DEFINE_SPINLOCK(arm_smmu_devices_lock);
-static LIST_HEAD(arm_smmu_devices);
+static DEFINE_RWLOCK(arm_smmu_masters_lock);
+static LIST_HEAD(arm_smmu_masters);
 
 struct arm_smmu_option_prop {
 	u32 opt;
@@ -417,111 +417,20 @@ static struct device_node *dev_get_dev_node(struct device *dev)
 	return dev->of_node;
 }
 
-static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
-						struct device_node *dev_node)
+static struct arm_smmu_master *find_smmu_master(struct device_node *dev_node)
 {
-	struct rb_node *node = smmu->masters.rb_node;
-
-	while (node) {
-		struct arm_smmu_master *master;
-
-		master = container_of(node, struct arm_smmu_master, node);
-
-		if (dev_node < master->of_node)
-			node = node->rb_left;
-		else if (dev_node > master->of_node)
-			node = node->rb_right;
-		else
-			return master;
-	}
-
-	return NULL;
-}
-
-static int insert_smmu_master(struct arm_smmu_device *smmu,
-			      struct arm_smmu_master *master)
-{
-	struct rb_node **new, *parent;
-
-	new = &smmu->masters.rb_node;
-	parent = NULL;
-	while (*new) {
-		struct arm_smmu_master *this
-			= container_of(*new, struct arm_smmu_master, node);
-
-		parent = *new;
-		if (master->of_node < this->of_node)
-			new = &((*new)->rb_left);
-		else if (master->of_node > this->of_node)
-			new = &((*new)->rb_right);
-		else
-			return -EEXIST;
-	}
-
-	rb_link_node(&master->node, parent, new);
-	rb_insert_color(&master->node, &smmu->masters);
-	return 0;
-}
-
-static int register_smmu_master(struct arm_smmu_device *smmu,
-				struct of_phandle_args *masterspec)
-{
-	int i;
 	struct arm_smmu_master *master;
 
-	master = find_smmu_master(smmu, masterspec->np);
-	if (master) {
-		dev_err(smmu->dev,
-			"rejecting multiple registrations for master device %s\n",
-			masterspec->np->name);
-		return -EBUSY;
-	}
+	read_lock(&arm_smmu_masters_lock);
+	list_for_each_entry(master, &arm_smmu_masters, list)
+		if (master->of_node == dev_node)
+			goto out_unlock;
 
-	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
-		dev_err(smmu->dev,
-			"reached maximum number (%d) of stream IDs for master device %s\n",
-			MAX_MASTER_STREAMIDS, masterspec->np->name);
-		return -ENOSPC;
-	}
+	master = NULL;
 
-	master = devm_kzalloc(smmu->dev, sizeof(*master), GFP_KERNEL);
-	if (!master)
-		return -ENOMEM;
-
-	master->of_node			= masterspec->np;
-	master->cfg.num_streamids	= masterspec->args_count;
-
-	for (i = 0; i < master->cfg.num_streamids; ++i) {
-		u16 streamid = masterspec->args[i];
-
-		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
-		     (streamid >= smmu->num_mapping_groups)) {
-			dev_err(smmu->dev,
-				"stream ID for master device %s greater than maximum allowed (%d)\n",
-				masterspec->np->name, smmu->num_mapping_groups);
-			return -ERANGE;
-		}
-		master->cfg.streamids[i].id = streamid;
-		/* leave .mask 0; we don't currently share SMRs */
-	}
-	return insert_smmu_master(smmu, master);
-}
-
-static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
-{
-	struct arm_smmu_device *smmu;
-	struct arm_smmu_master *master = NULL;
-	struct device_node *dev_node = dev_get_dev_node(dev);
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(smmu, &arm_smmu_devices, list) {
-		master = find_smmu_master(smmu, dev_node);
-		if (master)
-			break;
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	return master ? smmu : NULL;
+out_unlock:
+	read_unlock(&arm_smmu_masters_lock);
+	return master;
 }
 
 static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
@@ -1327,36 +1236,26 @@ static int arm_smmu_init_pci_device(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_init_platform_device(struct arm_smmu_device *smmu,
-					 struct device *dev)
-{
-	struct arm_smmu_master *master;
-
-	master = find_smmu_master(smmu, dev_get_dev_node(dev));
-	dev->archdata.iommu = &master->cfg;
-
-	return 0;
-}
-
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
-	struct arm_smmu_device *smmu;
-	int ret;
+	struct arm_smmu_master *master;
 
 	if (dev->archdata.iommu)
 		return -EEXIST;
 
-	smmu = find_smmu_for_device(dev);
-	if (!smmu)
+	master = find_smmu_master(dev_get_dev_node(dev));
+	if (!master)
 		return -ENODEV;
 
-	if (dev_is_pci(dev))
-		ret = arm_smmu_init_pci_device(smmu, to_pci_dev(dev));
-	else
-		ret = arm_smmu_init_platform_device(smmu, dev);
-	if (ret)
-		return ret;
+	if (dev_is_pci(dev)) {
+		int ret = arm_smmu_init_pci_device(master->cfg.smmu,
+						   to_pci_dev(dev));
+		if (ret)
+			return ret;
+	} else {
+		dev->archdata.iommu = &master->cfg;
+	}
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
@@ -1752,19 +1651,79 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static void arm_smmu_remove_mmu_masters(struct arm_smmu_device *smmu)
 {
-	struct arm_smmu_master *master;
-	struct rb_node *node, *tmp;
+	struct arm_smmu_master *master, *tmp;
 
-	node = rb_first(&smmu->masters);
-	while (node) {
-		tmp = node;
-		node = rb_next(node);
-		master = container_of(tmp, struct arm_smmu_master, node);
+	write_lock(&arm_smmu_masters_lock);
+	list_for_each_entry_safe(master, tmp, &arm_smmu_masters, list) {
+		if (master->cfg.smmu != smmu)
+			continue;
 
-		rb_erase(tmp, &smmu->masters);
+		list_del(&master->list);
 		of_node_put(master->of_node);
 		devm_kfree(smmu->dev, master);
 	}
+	write_unlock(&arm_smmu_masters_lock);
+}
+
+static int insert_smmu_master(struct arm_smmu_master *master)
+{
+	struct arm_smmu_master *tmp;
+	int ret = -EEXIST;
+
+	write_lock(&arm_smmu_masters_lock);
+	list_for_each_entry(tmp, &arm_smmu_masters, list)
+		if (tmp->of_node == master->of_node)
+			goto out_unlock;
+
+	ret = 0;
+	list_add(&master->list, &arm_smmu_masters);
+out_unlock:
+	write_unlock(&arm_smmu_masters_lock);
+	return ret;
+}
+
+static int register_smmu_master(struct arm_smmu_device *smmu,
+				struct of_phandle_args *masterspec)
+{
+	int i;
+	struct arm_smmu_master *master;
+
+	master = find_smmu_master(masterspec->np);
+	if (master) {
+		dev_err(smmu->dev,
+			"rejecting multiple registrations for master device %s\n",
+			masterspec->np->name);
+		return -EBUSY;
+	}
+
+	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
+		dev_err(smmu->dev,
+			"reached maximum number (%d) of stream IDs for master device %s\n",
+			MAX_MASTER_STREAMIDS, masterspec->np->name);
+		return -ENOSPC;
+	}
+
+	master = devm_kzalloc(smmu->dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->of_node			= masterspec->np;
+	master->cfg.num_streamids	= masterspec->args_count;
+
+	for (i = 0; i < master->cfg.num_streamids; ++i) {
+		u16 streamid = masterspec->args[i];
+
+		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
+		     (streamid >= smmu->num_mapping_groups)) {
+			dev_err(smmu->dev,
+				"stream ID for master device %s greater than maximum allowed (%d)\n",
+				masterspec->np->name, smmu->num_mapping_groups);
+			return -ERANGE;
+		}
+		master->cfg.streamids[i].id = streamid;
+		/* leave .mask 0; we don't currently share SMRs */
+	}
+	return insert_smmu_master(master);
 }
 
 static int arm_smmu_probe_mmu_masters(struct arm_smmu_device *smmu)
@@ -1880,11 +1839,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_probe_mmu_masters(smmu);
-	INIT_LIST_HEAD(&smmu->list);
-	spin_lock(&arm_smmu_devices_lock);
-	list_add(&smmu->list, &arm_smmu_devices);
-	spin_unlock(&arm_smmu_devices_lock);
-
 	arm_smmu_device_reset(smmu);
 	return 0;
 
@@ -1903,9 +1857,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		return -ENODEV;
 
 	arm_smmu_remove_mmu_masters(smmu);
-	spin_lock(&arm_smmu_devices_lock);
-	list_del(&smmu->list);
-	spin_unlock(&arm_smmu_devices_lock);
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
-- 
2.7.2.333.g70bd996.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
