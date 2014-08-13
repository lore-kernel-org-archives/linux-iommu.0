From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 4/6] iommu/arm-smmu: implement generic DT bindings
Date: Tue, 12 Aug 2014 17:51:37 -0700
Message-ID: <1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Generic IOMMU device tree bindings were recently added in
["devicetree: Add generic IOMMU device tree bindings"]. Implement the
bindings in the ARM SMMU driver.

See Documentation/devicetree/bindings/iommu/iommu.txt for the bindings
themselves.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 87 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 63c6707fad..22e25f3172 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -538,25 +538,32 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+struct iommus_entry {
+	struct list_head list;
+	struct device_node *node;
+	u16 streamids[MAX_MASTER_STREAMIDS];
+	int num_sids;
+};
+
 static int register_smmu_master(struct arm_smmu_device *smmu,
-				struct device *dev,
-				struct of_phandle_args *masterspec)
+				struct iommus_entry *entry)
 {
 	int i;
 	struct arm_smmu_master *master;
+	struct device *dev = smmu->dev;
 
-	master = find_smmu_master(smmu, masterspec->np);
+	master = find_smmu_master(smmu, entry->node);
 	if (master) {
 		dev_err(dev,
 			"rejecting multiple registrations for master device %s\n",
-			masterspec->np->name);
+			entry->node->name);
 		return -EBUSY;
 	}
 
-	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
+	if (entry->num_sids > MAX_MASTER_STREAMIDS) {
 		dev_err(dev,
 			"reached maximum number (%d) of stream IDs for master device %s\n",
-			MAX_MASTER_STREAMIDS, masterspec->np->name);
+			MAX_MASTER_STREAMIDS, entry->node->name);
 		return -ENOSPC;
 	}
 
@@ -564,15 +571,58 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	if (!master)
 		return -ENOMEM;
 
-	master->of_node			= masterspec->np;
-	master->cfg.num_streamids	= masterspec->args_count;
+	master->of_node			= entry->node;
+	master->cfg.num_streamids	= entry->num_sids;
 
 	for (i = 0; i < master->cfg.num_streamids; ++i)
-		master->cfg.streamids[i] = masterspec->args[i];
+		master->cfg.streamids[i] = entry->streamids[i];
 
 	return insert_smmu_master(smmu, master);
 }
 
+static int arm_smmu_parse_iommus_properties(struct arm_smmu_device *smmu,
+					int *num_masters)
+{
+	struct of_phandle_args iommuspec;
+	struct device_node *dn;
+
+	for_each_node_with_property(dn, "iommus") {
+		int arg_ind = 0;
+		struct iommus_entry *entry, *n;
+		LIST_HEAD(iommus);
+
+		while (!of_parse_phandle_with_args(dn, "iommus", "#iommu-cells",
+							arg_ind, &iommuspec)) {
+			int i;
+
+			list_for_each_entry(entry, &iommus, list)
+				if (entry->node == dn)
+					break;
+			if (&entry->list == &iommus) {
+				entry = devm_kzalloc(smmu->dev, sizeof(*entry),
+						GFP_KERNEL);
+				if (!entry)
+					return -ENOMEM;
+				entry->node = dn;
+				list_add(&entry->list, &iommus);
+			}
+			entry->num_sids = iommuspec.args_count;
+			for (i = 0; i < entry->num_sids; ++i)
+				entry->streamids[i] = iommuspec.args[i];
+			arg_ind++;
+		}
+
+		list_for_each_entry_safe(entry, n, &iommus, list) {
+			register_smmu_master(smmu, entry);
+			(*num_masters)++;
+			list_del(&entry->list);
+			devm_kfree(smmu->dev, entry);
+		}
+	}
+
+	return 0;
+}
+
 static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
@@ -2196,8 +2246,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
-	struct of_phandle_args masterspec;
-	int num_irqs, i, err;
+	int num_irqs, i, err, num_masters;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2251,19 +2300,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	i = 0;
 	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
-		if (err) {
-			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
-			goto out_put_masters;
-		}
+	err = arm_smmu_parse_iommus_properties(smmu, &num_masters);
+	if (err)
+		goto out_put_masters;
 
-		i++;
-	}
-	dev_notice(dev, "registered %d master devices\n", i);
+	dev_notice(dev, "registered %d master devices\n", num_masters);
 
 	err = arm_smmu_init_regulators(smmu);
 	if (err)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
