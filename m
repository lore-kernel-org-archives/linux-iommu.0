From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Mon, 30 Jun 2014 11:52:07 +0100
Message-ID: <1404125530-17984-3-git-send-email-will.deacon@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404125530-17984-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch extends the ARM SMMU driver so that it can handle PCI master
devices in addition to platform devices described in the device tree.

The driver is informed about the PCI host controller in the DT via a
phandle to the host controller in the mmu-masters property. The host
controller is then added to the master tree for that SMMU, just like a
normal master (although it probably doesn't advertise any StreamIDs).

When a device is added to the PCI bus, we set the archdata.iommu pointer
for that device to describe its StreamID (actually its RequesterID for
the moment). This allows us to re-use our existing data structures using
the host controller of_node for everything apart from StreamID
configuration, where we reach into the archdata for the information we
require.

Cc: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 242 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 156 insertions(+), 86 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 81e8ec290756..e4eebc50612c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -39,6 +39,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -329,14 +330,7 @@ struct arm_smmu_smr {
 	u16				id;
 };
 
-struct arm_smmu_master {
-	struct device_node		*of_node;
-
-	/*
-	 * The following is specific to the master's position in the
-	 * SMMU chain.
-	 */
-	struct rb_node			node;
+struct arm_smmu_master_cfg {
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
 
@@ -347,6 +341,17 @@ struct arm_smmu_master {
 	struct arm_smmu_smr		*smrs;
 };
 
+struct arm_smmu_master {
+	struct device_node		*of_node;
+
+	/*
+	 * The following is specific to the master's position in the
+	 * SMMU chain.
+	 */
+	struct rb_node			node;
+	struct arm_smmu_master_cfg	cfg;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 	struct device_node		*parent_of_node;
@@ -437,6 +442,18 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static struct device *dev_get_master_dev(struct device *dev)
+{
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		while (!pci_is_root_bus(bus))
+			bus = bus->parent;
+		return bus->bridge->parent;
+	}
+
+	return dev;
+}
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -457,6 +474,18 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 	return NULL;
 }
 
+static struct arm_smmu_master_cfg *
+find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
+{
+	struct arm_smmu_master *master;
+
+	if (dev_is_pci(dev))
+		return dev->archdata.iommu;
+
+	master = find_smmu_master(smmu, dev_get_master_dev(dev)->of_node);
+	return master ? &master->cfg : NULL;
+}
+
 static int insert_smmu_master(struct arm_smmu_device *smmu,
 			      struct arm_smmu_master *master)
 {
@@ -508,11 +537,11 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	if (!master)
 		return -ENOMEM;
 
-	master->of_node		= masterspec->np;
-	master->num_streamids	= masterspec->args_count;
+	master->of_node			= masterspec->np;
+	master->cfg.num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
+	for (i = 0; i < master->cfg.num_streamids; ++i)
+		master->cfg.streamids[i] = masterspec->args[i];
 
 	return insert_smmu_master(smmu, master);
 }
@@ -537,6 +566,42 @@ out_unlock:
 	return parent;
 }
 
+static struct arm_smmu_device *find_parent_smmu_for_device(struct device *dev)
+{
+	struct arm_smmu_device *child, *parent, *smmu;
+	struct arm_smmu_master *master = NULL;
+	struct device_node *dev_node = dev_get_master_dev(dev)->of_node;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(parent, &arm_smmu_devices, list) {
+		smmu = parent;
+
+		/* Try to find a child of the current SMMU. */
+		list_for_each_entry(child, &arm_smmu_devices, list) {
+			if (child->parent_of_node == parent->dev->of_node) {
+				/* Does the child sit above our master? */
+				master = find_smmu_master(child, dev_node);
+				if (master) {
+					smmu = NULL;
+					break;
+				}
+			}
+		}
+
+		/* We found some children, so keep searching. */
+		if (!smmu) {
+			master = NULL;
+			continue;
+		}
+
+		master = find_smmu_master(smmu, dev_node);
+		if (master)
+			break;
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+	return master ? smmu : NULL;
+}
+
 static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
 	int idx;
@@ -855,7 +920,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct arm_smmu_device *device_smmu)
 {
 	int irq, ret, start;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
@@ -868,15 +934,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * early, and therefore check that the root SMMU does indeed have
 	 * a StreamID for the master in question.
 	 */
-	parent = dev->archdata.iommu;
+	parent = device_smmu;
 	smmu_domain->output_mask = -1;
 	do {
 		smmu = parent;
 		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
 	} while ((parent = find_parent_smmu(smmu)));
 
-	if (!find_smmu_master(smmu, dev->of_node)) {
-		dev_err(dev, "unable to find root SMMU for device\n");
+	if (!find_smmu_master_cfg(smmu, dev)) {
+		dev_err(dev, "unable to find root SMMU config for device\n");
 		return -ENODEV;
 	}
 
@@ -920,7 +986,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	root_cfg->smmu = smmu;
 	arm_smmu_init_context_bank(smmu_domain);
-	return ret;
+	smmu_domain->leaf_smmu = device_smmu;
+	return 0;
 
 out_free_context:
 	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
@@ -1056,7 +1123,7 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 }
 
 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
-					  struct arm_smmu_master *master)
+					  struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	struct arm_smmu_smr *smrs;
@@ -1065,18 +1132,18 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH))
 		return 0;
 
-	if (master->smrs)
+	if (cfg->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
+	smrs = kmalloc(sizeof(*smrs) * cfg->num_streamids, GFP_KERNEL);
 	if (!smrs) {
-		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
-			master->num_streamids, master->of_node->name);
+		dev_err(smmu->dev, "failed to allocate %d SMRs\n",
+			cfg->num_streamids);
 		return -ENOMEM;
 	}
 
 	/* Allocate the SMRs on the root SMMU */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
 						  smmu->num_mapping_groups);
 		if (IS_ERR_VALUE(idx)) {
@@ -1087,18 +1154,18 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 		smrs[i] = (struct arm_smmu_smr) {
 			.idx	= idx,
 			.mask	= 0, /* We don't currently share SMRs */
-			.id	= master->streamids[i],
+			.id	= cfg->streamids[i],
 		};
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
 			  smrs[i].mask << SMR_MASK_SHIFT;
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
 	}
 
-	master->smrs = smrs;
+	cfg->smrs = smrs;
 	return 0;
 
 err_free_smrs:
@@ -1109,44 +1176,44 @@ err_free_smrs:
 }
 
 static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
-				      struct arm_smmu_master *master)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
-	struct arm_smmu_smr *smrs = master->smrs;
+	struct arm_smmu_smr *smrs = cfg->smrs;
 
 	/* Invalidate the SMRs before freeing back to the allocator */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(idx));
 		__arm_smmu_free_bitmap(smmu->smr_map, idx);
 	}
 
-	master->smrs = NULL;
+	cfg->smrs = NULL;
 	kfree(smrs);
 }
 
 static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
-					   struct arm_smmu_master *master)
+					   struct arm_smmu_master_cfg *cfg)
 {
 	int i;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	for (i = 0; i < master->num_streamids; ++i) {
-		u16 sid = master->streamids[i];
+	for (i = 0; i < cfg->num_streamids; ++i) {
+		u16 sid = cfg->streamids[i];
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
 	}
 }
 
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
-				      struct arm_smmu_master *master)
+				      struct arm_smmu_master_cfg *cfg)
 {
 	int i, ret;
 	struct arm_smmu_device *parent, *smmu = smmu_domain->root_cfg.smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	ret = arm_smmu_master_configure_smrs(smmu, master);
+	ret = arm_smmu_master_configure_smrs(smmu, cfg);
 	if (ret)
 		return ret;
 
@@ -1161,14 +1228,14 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH)
 			continue;
 
-		arm_smmu_bypass_stream_mapping(smmu, master);
+		arm_smmu_bypass_stream_mapping(smmu, cfg);
 		smmu = parent;
 	}
 
 	/* Now we're at the root, time to point at our context bank */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
-		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
+		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 		s2cr = S2CR_TYPE_TRANS |
 		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
 		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
@@ -1178,7 +1245,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 }
 
 static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
-					  struct arm_smmu_master *master)
+					  struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;
 
@@ -1186,18 +1253,19 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
 	 */
-	arm_smmu_bypass_stream_mapping(smmu, master);
-	arm_smmu_master_free_smrs(smmu, master);
+	arm_smmu_bypass_stream_mapping(smmu, cfg);
+	arm_smmu_master_free_smrs(smmu, cfg);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = -EINVAL;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *device_smmu = dev->archdata.iommu;
-	struct arm_smmu_master *master;
+	struct arm_smmu_device *device_smmu;
+	struct arm_smmu_master_cfg *cfg;
 	unsigned long flags;
 
+	device_smmu = dev_get_master_dev(dev)->archdata.iommu;
 	if (!device_smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
 		return -ENXIO;
@@ -1210,11 +1278,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_lock_irqsave(&smmu_domain->lock, flags);
 	if (!smmu_domain->leaf_smmu) {
 		/* Now that we have a master, we can finalise the domain */
-		ret = arm_smmu_init_domain_context(domain, dev);
+		ret = arm_smmu_init_domain_context(domain, dev, device_smmu);
 		if (IS_ERR_VALUE(ret))
 			goto err_unlock;
-
-		smmu_domain->leaf_smmu = device_smmu;
 	} else if (smmu_domain->leaf_smmu != device_smmu) {
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
@@ -1225,11 +1291,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	/* Looks ok, so add the device to the domain */
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (!master)
+	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	if (!cfg)
 		return -ENODEV;
 
-	return arm_smmu_domain_add_master(smmu_domain, master);
+	return arm_smmu_domain_add_master(smmu_domain, cfg);
 
 err_unlock:
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
@@ -1239,11 +1305,11 @@ err_unlock:
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_master *master;
+	struct arm_smmu_master_cfg *cfg;
 
-	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
-	if (master)
-		arm_smmu_domain_remove_master(smmu_domain, master);
+	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	if (cfg)
+		arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
 
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
@@ -1549,10 +1615,15 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 	return !!(cap & caps);
 }
 
+static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	*((u16 *)data) = alias;
+	return 0; /* Continue walking */
+}
+
 static int arm_smmu_add_device(struct device *dev)
 {
-	struct arm_smmu_device *child, *parent, *smmu;
-	struct arm_smmu_master *master = NULL;
+	struct arm_smmu_device *smmu;
 	struct iommu_group *group;
 	int ret;
 
@@ -1561,35 +1632,8 @@ static int arm_smmu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list) {
-		smmu = parent;
-
-		/* Try to find a child of the current SMMU. */
-		list_for_each_entry(child, &arm_smmu_devices, list) {
-			if (child->parent_of_node == parent->dev->of_node) {
-				/* Does the child sit above our master? */
-				master = find_smmu_master(child, dev->of_node);
-				if (master) {
-					smmu = NULL;
-					break;
-				}
-			}
-		}
-
-		/* We found some children, so keep searching. */
-		if (!smmu) {
-			master = NULL;
-			continue;
-		}
-
-		master = find_smmu_master(smmu, dev->of_node);
-		if (master)
-			break;
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	if (!master)
+	smmu = find_parent_smmu_for_device(dev);
+	if (!smmu)
 		return -ENODEV;
 
 	group = iommu_group_alloc();
@@ -1598,15 +1642,36 @@ static int arm_smmu_add_device(struct device *dev)
 		return PTR_ERR(group);
 	}
 
+	if (dev_is_pci(dev)) {
+		struct arm_smmu_master_cfg *cfg;
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+		if (!cfg) {
+			ret = -ENOMEM;
+			goto out_put_group;
+		}
+
+		cfg->num_streamids = 1;
+		pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
+				       &cfg->streamids[0]);
+		dev->archdata.iommu = cfg;
+	} else {
+		dev->archdata.iommu = smmu;
+	}
+
 	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-	dev->archdata.iommu = smmu;
 
+out_put_group:
+	iommu_group_put(group);
 	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
 {
+	if (dev_is_pci(dev))
+		kfree(dev->archdata.iommu);
+
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 }
@@ -2050,6 +2115,11 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 #endif
 
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type))
+		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+#endif
+
 	return 0;
 }
 
-- 
2.0.0
