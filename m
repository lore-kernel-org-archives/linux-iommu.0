From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 07/22] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Mon, 12 Sep 2016 17:13:45 +0100
Message-ID: <434c1741a9852e23c8a0dc70efac52ef4f7c4c04.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we can properly describe the mapping between PCI RIDs and
stream IDs via "iommu-map", and have it fed it to the driver
automatically via of_xlate(), rework the SMMUv3 driver to benefit from
that, and get rid of the current misuse of the "iommus" binding.

Since having of_xlate wired up means that masters will now be given the
appropriate DMA ops, we also need to make sure that default domains work
properly. This necessitates dispensing with the "whole group at a time"
notion for attaching to a domain, as devices which share a group get
attached to the group's default domain one by one as they are initially
probed.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- Convert to updated fwspec mechanism
---
 drivers/iommu/arm-smmu-v3.c | 304 +++++++++++++++++++-------------------------
 1 file changed, 131 insertions(+), 173 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d7fef5f99bfc..15ba80db6465 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -30,6 +30,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -610,12 +611,9 @@ struct arm_smmu_device {
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 };
 
-/* SMMU private data for an IOMMU group */
-struct arm_smmu_group {
+/* SMMU private data for each master */
+struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
-	struct arm_smmu_domain		*domain;
-	int				num_sids;
-	u32				*sids;
 	struct arm_smmu_strtab_ent	ste;
 };
 
@@ -1555,20 +1553,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return ret;
 }
 
-static struct arm_smmu_group *arm_smmu_group_get(struct device *dev)
-{
-	struct iommu_group *group;
-	struct arm_smmu_group *smmu_group;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return NULL;
-
-	smmu_group = iommu_group_get_iommudata(group);
-	iommu_group_put(group);
-	return smmu_group;
-}
-
 static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 {
 	__le64 *step;
@@ -1591,27 +1575,17 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
-static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
+static int arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
 	int i;
-	struct arm_smmu_domain *smmu_domain = smmu_group->domain;
-	struct arm_smmu_strtab_ent *ste = &smmu_group->ste;
-	struct arm_smmu_device *smmu = smmu_group->smmu;
+	struct arm_smmu_master_data *master = fwspec->iommu_priv;
+	struct arm_smmu_device *smmu = master->smmu;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		ste->s1_cfg = &smmu_domain->s1_cfg;
-		ste->s2_cfg = NULL;
-		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
-	} else {
-		ste->s1_cfg = NULL;
-		ste->s2_cfg = &smmu_domain->s2_cfg;
-	}
-
-	for (i = 0; i < smmu_group->num_sids; ++i) {
-		u32 sid = smmu_group->sids[i];
+	for (i = 0; i < fwspec->num_ids; ++i) {
+		u32 sid = fwspec->ids[i];
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
-		arm_smmu_write_strtab_ent(smmu, sid, step, ste);
+		arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
 	}
 
 	return 0;
@@ -1619,13 +1593,11 @@ static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
 
 static void arm_smmu_detach_dev(struct device *dev)
 {
-	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 
-	smmu_group->ste.bypass = true;
-	if (arm_smmu_install_ste_for_group(smmu_group) < 0)
+	master->ste.bypass = true;
+	if (arm_smmu_install_ste_for_dev(dev->iommu_fwspec) < 0)
 		dev_warn(dev, "failed to install bypass STE\n");
-
-	smmu_group->domain = NULL;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1633,16 +1605,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	int ret = 0;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_strtab_ent *ste;
 
-	if (!smmu_group)
+	if (!dev->iommu_fwspec)
 		return -ENOENT;
 
+	master = dev->iommu_fwspec->iommu_priv;
+	smmu = master->smmu;
+	ste = &master->ste;
+
 	/* Already attached to a different domain? */
-	if (smmu_group->domain && smmu_group->domain != smmu_domain)
+	if (!ste->bypass)
 		arm_smmu_detach_dev(dev);
 
-	smmu = smmu_group->smmu;
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -1661,21 +1637,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
-	/* Group already attached to this domain? */
-	if (smmu_group->domain)
-		goto out_unlock;
+	ste->bypass = false;
+	ste->valid = true;
 
-	smmu_group->domain	= smmu_domain;
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		ste->s1_cfg = &smmu_domain->s1_cfg;
+		ste->s2_cfg = NULL;
+		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
+	} else {
+		ste->s1_cfg = NULL;
+		ste->s2_cfg = &smmu_domain->s2_cfg;
+	}
 
-	/*
-	 * FIXME: This should always be "false" once we have IOMMU-backed
-	 * DMA ops for all devices behind the SMMU.
-	 */
-	smmu_group->ste.bypass	= domain->type == IOMMU_DOMAIN_DMA;
-
-	ret = arm_smmu_install_ste_for_group(smmu_group);
+	ret = arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
 	if (ret < 0)
-		smmu_group->domain = NULL;
+		ste->valid = false;
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
@@ -1734,40 +1710,19 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ret;
 }
 
-static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *sidp)
+static struct platform_driver arm_smmu_driver;
+
+static int arm_smmu_match_node(struct device *dev, void *data)
 {
-	*(u32 *)sidp = alias;
-	return 0; /* Continue walking */
+	return dev->of_node == data;
 }
 
-static void __arm_smmu_release_pci_iommudata(void *data)
+static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
 {
-	kfree(data);
-}
-
-static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
-{
-	struct device_node *of_node;
-	struct platform_device *smmu_pdev;
-	struct arm_smmu_device *smmu = NULL;
-	struct pci_bus *bus = pdev->bus;
-
-	/* Walk up to the root bus */
-	while (!pci_is_root_bus(bus))
-		bus = bus->parent;
-
-	/* Follow the "iommus" phandle from the host controller */
-	of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
-	if (!of_node)
-		return NULL;
-
-	/* See if we can find an SMMU corresponding to the phandle */
-	smmu_pdev = of_find_device_by_node(of_node);
-	if (smmu_pdev)
-		smmu = platform_get_drvdata(smmu_pdev);
-
-	of_node_put(of_node);
-	return smmu;
+	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
+						np, arm_smmu_match_node);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
 }
 
 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
@@ -1780,94 +1735,74 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static struct iommu_ops arm_smmu_ops;
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
-	u32 sid, *sids;
-	struct pci_dev *pdev;
-	struct iommu_group *group;
-	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_data *master;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_group *group;
 
-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
+	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return -ENODEV;
-
-	pdev = to_pci_dev(dev);
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	smmu_group = iommu_group_get_iommudata(group);
-	if (!smmu_group) {
-		smmu = arm_smmu_get_for_pci_dev(pdev);
-		if (!smmu) {
-			ret = -ENOENT;
-			goto out_remove_dev;
-		}
-
-		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
-		if (!smmu_group) {
-			ret = -ENOMEM;
-			goto out_remove_dev;
-		}
-
-		smmu_group->ste.valid	= true;
-		smmu_group->smmu	= smmu;
-		iommu_group_set_iommudata(group, smmu_group,
-					  __arm_smmu_release_pci_iommudata);
+	/*
+	 * We _can_ actually withstand dodgy bus code re-calling add_device()
+	 * without an intervening remove_device()/of_xlate() sequence, but
+	 * we're not going to do so quietly...
+	 */
+	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
+		master = fwspec->iommu_priv;
+		smmu = master->smmu;
 	} else {
-		smmu = smmu_group->smmu;
+		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
+		if (!smmu)
+			return -ENODEV;
+		master = kzalloc(sizeof(*master), GFP_KERNEL);
+		if (!master)
+			return -ENOMEM;
+
+		master->smmu = smmu;
+		fwspec->iommu_priv = master;
 	}
 
-	/* Assume SID == RID until firmware tells us otherwise */
-	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
-	for (i = 0; i < smmu_group->num_sids; ++i) {
-		/* If we already know about this SID, then we're done */
-		if (smmu_group->sids[i] == sid)
-			goto out_put_group;
+	/* Check the SIDs are in range of the SMMU and our stream table */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u32 sid = fwspec->ids[i];
+
+		if (!arm_smmu_sid_in_range(smmu, sid))
+			return -ERANGE;
+
+		/* Ensure l2 strtab is initialised */
+		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+			ret = arm_smmu_init_l2_strtab(smmu, sid);
+			if (ret)
+				return ret;
+		}
 	}
 
-	/* Check the SID is in range of the SMMU and our stream table */
-	if (!arm_smmu_sid_in_range(smmu, sid)) {
-		ret = -ERANGE;
-		goto out_remove_dev;
-	}
+	group = iommu_group_get_for_dev(dev);
+	if (!IS_ERR(group))
+		iommu_group_put(group);
 
-	/* Ensure l2 strtab is initialised */
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		ret = arm_smmu_init_l2_strtab(smmu, sid);
-		if (ret)
-			goto out_remove_dev;
-	}
-
-	/* Resize the SID array for the group */
-	smmu_group->num_sids++;
-	sids = krealloc(smmu_group->sids, smmu_group->num_sids * sizeof(*sids),
-			GFP_KERNEL);
-	if (!sids) {
-		smmu_group->num_sids--;
-		ret = -ENOMEM;
-		goto out_remove_dev;
-	}
-
-	/* Add the new SID */
-	sids[smmu_group->num_sids - 1] = sid;
-	smmu_group->sids = sids;
-
-out_put_group:
-	iommu_group_put(group);
-	return 0;
-
-out_remove_dev:
-	iommu_group_remove_device(dev);
-	iommu_group_put(group);
-	return ret;
+	return PTR_ERR_OR_ZERO(group);
 }
 
 static void arm_smmu_remove_device(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct arm_smmu_master_data *master;
+
+	if (!fwspec || fwspec->ops != &arm_smmu_ops)
+		return;
+
+	master = fwspec->iommu_priv;
+	if (master && master->ste.valid)
+		arm_smmu_detach_dev(dev);
 	iommu_group_remove_device(dev);
+	kfree(master);
+	iommu_fwspec_free(dev);
 }
 
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
@@ -1914,6 +1849,15 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	/* We only support PCI, for now */
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1928,6 +1872,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= pci_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.of_xlate		= arm_smmu_of_xlate,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -2662,7 +2607,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, smmu);
 
 	/* Reset the device */
-	return arm_smmu_device_reset(smmu, bypass);
+	ret = arm_smmu_device_reset(smmu, bypass);
+	if (ret)
+		return ret;
+
+	/* And we're up. Go go go! */
+	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+	pci_request_acs();
+	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
@@ -2690,22 +2642,14 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
-	struct device_node *np;
-	int ret;
+	static bool registered;
+	int ret = 0;
 
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = platform_driver_register(&arm_smmu_driver);
-	if (ret)
-		return ret;
-
-	pci_request_acs();
-
-	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+	if (!registered) {
+		ret = platform_driver_register(&arm_smmu_driver);
+		registered = !ret;
+	}
+	return ret;
 }
 
 static void __exit arm_smmu_exit(void)
@@ -2716,6 +2660,20 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
+static int __init arm_smmu_of_init(struct device_node *np)
+{
+	int ret = arm_smmu_init();
+
+	if (ret)
+		return ret;
+
+	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
+		return -ENODEV;
+
+	return 0;
+}
+IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.8.1.dirty
