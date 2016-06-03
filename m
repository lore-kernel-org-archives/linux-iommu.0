From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 5/7] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Fri,  3 Jun 2016 18:15:40 +0100
Message-ID: <55aa94e099f00fd586077c45d4c4fd1c010981d9.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we can properly describe the mapping between PCI RIDs and
stream IDs via "iommu-map", and have it fed it to the driver
automatically via of_xlate(), rework the SMMUv3 driver to benefit from
that. Initially, this just gets rid of the misuse of the "iommus"
binding without changing the driver's existing level of functionality,
but does at least pave the way to extending it more easily in future.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New.

 drivers/iommu/arm-smmu-v3.c | 119 +++++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 94b68213c50d..7631639cc209 100644
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
@@ -638,6 +639,12 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+/* SMMU private data for each master */
+struct arm_smmu_master_data {
+	struct arm_smmu_device		*smmu;
+	u32				sid;
+};
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -1754,40 +1761,19 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ret;
 }
 
-static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *sidp)
-{
-	*(u32 *)sidp = alias;
-	return 0; /* Continue walking */
-}
-
 static void __arm_smmu_release_pci_iommudata(void *data)
 {
 	kfree(data);
 }
 
-static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
+static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
 {
-	struct device_node *of_node;
-	struct platform_device *smmu_pdev;
-	struct arm_smmu_device *smmu = NULL;
-	struct pci_bus *bus = pdev->bus;
+	struct platform_device *smmu_pdev = of_find_device_by_node(np);
 
-	/* Walk up to the root bus */
-	while (!pci_is_root_bus(bus))
-		bus = bus->parent;
-
-	/* Follow the "iommus" phandle from the host controller */
-	of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
-	if (!of_node)
+	if (!smmu_pdev)
 		return NULL;
 
-	/* See if we can find an SMMU corresponding to the phandle */
-	smmu_pdev = of_find_device_by_node(of_node);
-	if (smmu_pdev)
-		smmu = platform_get_drvdata(smmu_pdev);
-
-	of_node_put(of_node);
-	return smmu;
+	return platform_get_drvdata(smmu_pdev);
 }
 
 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
@@ -1804,23 +1790,41 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	int i, ret;
 	u32 sid, *sids;
-	struct pci_dev *pdev;
 	struct iommu_group *group;
+	struct device_node *np;
 	struct arm_smmu_group *smmu_group;
-	struct arm_smmu_device *smmu;
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_master_data *data = dev->archdata.iommu;
 
-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
+	if (!data)
 		return -ENODEV;
 
-	pdev = to_pci_dev(dev);
+	np = (struct device_node *)data->smmu;
+	smmu = data->smmu = arm_smmu_get_by_node(np);
+	of_node_put(np);
+	if (!smmu)
+		return -ENODEV;
+
+	sid = data->sid;
+
+	/* Check the SID is in range of the SMMU and our stream table */
+	if (!arm_smmu_sid_in_range(smmu, sid))
+		return -ERANGE;
+
+	/* Ensure l2 strtab is initialised */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		ret = arm_smmu_init_l2_strtab(smmu, sid);
+		if (ret)
+			return ret;
+	}
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
 	smmu_group = iommu_group_get_iommudata(group);
 	if (!smmu_group) {
-		smmu = arm_smmu_get_for_pci_dev(pdev);
+		smmu = arm_smmu_get_by_node(np);
 		if (!smmu) {
 			ret = -ENOENT;
 			goto out_remove_dev;
@@ -1840,27 +1844,12 @@ static int arm_smmu_add_device(struct device *dev)
 		smmu = smmu_group->smmu;
 	}
 
-	/* Assume SID == RID until firmware tells us otherwise */
-	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
 		if (smmu_group->sids[i] == sid)
 			goto out_put_group;
 	}
 
-	/* Check the SID is in range of the SMMU and our stream table */
-	if (!arm_smmu_sid_in_range(smmu, sid)) {
-		ret = -ERANGE;
-		goto out_remove_dev;
-	}
-
-	/* Ensure l2 strtab is initialised */
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		ret = arm_smmu_init_l2_strtab(smmu, sid);
-		if (ret)
-			goto out_remove_dev;
-	}
-
 	/* Resize the SID array for the group */
 	smmu_group->num_sids++;
 	sids = krealloc(smmu_group->sids, smmu_group->num_sids * sizeof(*sids),
@@ -1887,6 +1876,7 @@ out_remove_dev:
 
 static void arm_smmu_remove_device(struct device *dev)
 {
+	kfree(dev->archdata.iommu);
 	iommu_group_remove_device(dev);
 }
 
@@ -1934,6 +1924,34 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct arm_smmu_master_data *data;
+
+	/* We only support PCI, for now */
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
+	if (dev->archdata.iommu)
+		return -EEXIST;
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/*
+	 * The device_node stands in for the SMMU device at this point
+	 * since there's no guarantee the SMMU itself has probed yet.
+	 * By the time we see this again in an add_device callback, we'll
+	 * be in a position to fix it up with the real thing.
+	 */
+	data->smmu = (struct arm_smmu_device *)args->np;
+	data->sid = args->args[0];
+	dev->archdata.iommu = data;
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1947,6 +1965,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= pci_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.of_xlate		= arm_smmu_of_xlate,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -2697,6 +2716,14 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
+static int __init arm_smmu_of_init(struct device_node *np)
+{
+	of_iommu_set_ops(np, &arm_smmu_ops);
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
