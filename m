From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RFC][PATCH] iommu/arm: Add hotplugged devices support for arm-smmu.
Date: Sun, 9 Mar 2014 00:35:40 +0530
Message-ID: <1394305540-16352-1-git-send-email-Varun.Sethi@freescale.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently the ARM SMMU driver only considers the bus master devices in the device
tree. The master device and stream ID information is maintained per SMMU. Currently
there is no mechanism for representing this information in case of PCI or hot
plugged devices.

This RFC patch proposes a mechanism for representing this information for hot
plugged/PCI devices.

Patch doesn't contain the add_device callback modification for hot plug devices.
This would be bus specific and would be responsible for populating the hot plug
devices masters list for the SMMU.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   93 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d9ab39..6c10df4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -327,6 +327,9 @@ struct arm_smmu_master {
 	 * SMMU chain.
 	 */
 	struct rb_node			node;
+	/* Following fields correspond to the hot plug masters */
+	struct list_head			hotplug_masters_node;
+	struct device			*dev;
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
 
@@ -371,6 +374,12 @@ struct arm_smmu_device {
 
 	struct list_head		list;
 	struct rb_root			masters;
+	/*
+	 * Hot plug master list and lock to
+	 * protect the list.
+	 */
+	struct list_head		hotplug_masters_list;
+	spinlock_t			lock;
 };
 
 struct arm_smmu_cfg {
@@ -401,6 +410,31 @@ struct arm_smmu_domain {
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
+static int is_device_hotplug(struct device *dev)
+{
+	return (dev->bus != &platform_bus_type) &&
+		 (dev->bus != &amba_bustype);
+}
+
+static struct arm_smmu_master *find_smmu_hotplug_master(struct arm_smmu_device *smmu,
+							struct device *dev)
+{
+	struct arm_smmu_master *master;
+	unsigned long flags;
+	bool found = 0;
+
+	spin_lock_irqsave(&smmu->lock, flags);
+	list_for_each_entry(master, &smmu->hotplug_masters_list,
+			    hotplug_masters_node)
+		if (master->dev == dev) {
+			found = 1;
+			break;
+		}
+	spin_unlock_irqrestore(&smmu->lock, flags);
+
+	return found ? master : NULL;
+}
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -421,6 +455,36 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 	return NULL;
 }
 
+static int remove_smmu_hotplug_master(struct arm_smmu_device *smmu,
+				      struct device *dev)
+{
+	unsigned long flags;
+	struct arm_smmu_master *master, *tmp;
+	bool found = 0;
+
+	spin_lock_irqsave(&smmu->lock, flags);
+	list_for_each_entry_safe(master, tmp, &smmu->hotplug_masters_list,
+				 hotplug_masters_node)
+		if (master->dev == dev) {
+			found = 1;
+			list_del(&master->hotplug_masters_node);
+			break;
+		}
+	spin_unlock_irqrestore(&smmu->lock, flags);
+
+	return found ? 0 : -ENODEV;
+}
+
+static void insert_smmu_hotplug_master(struct arm_smmu_device *smmu,
+				       struct arm_smmu_master *master)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->lock, flags);
+	list_add(&master->hotplug_masters_node, &smmu->hotplug_masters_list);
+	spin_unlock_irqrestore(&smmu->lock, flags);
+}
+
 static int insert_smmu_master(struct arm_smmu_device *smmu,
 			      struct arm_smmu_master *master)
 {
@@ -816,6 +880,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }
 
+static struct arm_smmu_master *get_smmu_master(struct arm_smmu_device *smmu,
+					struct device *dev)
+{
+	if (is_device_hotplug(dev))
+		return find_smmu_hotplug_master(smmu, dev);
+	else
+		return find_smmu_master(smmu, dev->of_node);
+}
+
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 					struct device *dev)
 {
@@ -837,7 +910,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
 	} while ((parent = find_parent_smmu(smmu)));
 
-	if (!find_smmu_master(smmu, dev->of_node)) {
+	if (!get_smmu_master(smmu, dev)) {
 		dev_err(dev, "unable to find root SMMU for device\n");
 		return -ENODEV;
 	}
@@ -1188,7 +1261,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	/* Looks ok, so add the device to the domain */
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
+	master = get_smmu_master(smmu_domain->leaf_smmu, dev);
 	if (!master)
 		return -ENODEV;
 
@@ -1204,7 +1277,7 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_master *master;
 
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
+	master = get_smmu_master(smmu_domain->leaf_smmu, dev);
 	if (master)
 		arm_smmu_domain_remove_master(smmu_domain, master);
 }
@@ -1570,6 +1643,15 @@ static int arm_smmu_add_device(struct device *dev)
 
 static void arm_smmu_remove_device(struct device *dev)
 {
+	if (is_device_hotplug(dev)) {
+		int ret;
+		struct arm_smmu_device *smmu = dev->archdata.iommu;
+
+		ret = remove_smmu_hotplug_master(smmu, dev);
+		WARN_ON(ret);
+		iommu_group_remove_device(dev);
+	}
+
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 }
@@ -1864,6 +1946,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	i = 0;
 	smmu->masters = RB_ROOT;
+
+	/* Intialize the hot plug masters list here */
+	INIT_LIST_HEAD(&smmu->hotplug_masters_list);
+	spin_lock_init(&smmu->lock);
+
 	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
 					   "#stream-id-cells", i,
 					   &masterspec)) {
-- 
1.7.9.5
