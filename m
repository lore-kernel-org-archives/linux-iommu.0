From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 1/5] iommu/arm-smmu: to support probe deferral
Date: Thu, 15 Oct 2015 16:30:43 +0800
Message-ID: <1444897847-18040-2-git-send-email-thunder.leizhen@huawei.com>
References: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

For pci devices, only the root nodes have "iommus" property. So we
should traverse all of its sub nodes in of_xlate.

There exists two cases:
Case 1: .add_device(sub node) happened before .of_xlate(root node)
Case 2: .add_device(sub node) happened after  .of_xlate(root node)

(1).add_device
	if (!root->archdata.iommu)
		return -ENODEV;

(2).of_xlate
	root->archdata.iommu = smmu;
	/*
	 * Probe the pci devices deferred in phase (1)
	 */

(3).add_device
	/*
	 * After phase (2), it's not NULL
	 */
	if (!root->archdata.iommu)
		return -ENODEV;

	__arm_smmu_add_pci_device(pdev, root->archdata.iommu);

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 110 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5a36ef7..3a54af1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>

@@ -1742,29 +1743,15 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 	kfree(data);
 }

-static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
+static struct device *arm_smmu_get_pci_dev_root(struct pci_dev *pdev)
 {
-	struct device_node *of_node;
-	struct platform_device *smmu_pdev;
-	struct arm_smmu_device *smmu = NULL;
 	struct pci_bus *bus = pdev->bus;

 	/* Walk up to the root bus */
 	while (!pci_is_root_bus(bus))
 		bus = bus->parent;

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
+	return bus->bridge->parent;
 }

 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
@@ -1777,27 +1764,21 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }

-static int arm_smmu_add_device(struct device *dev)
+static int __arm_smmu_add_device(struct device *dev, u32 sid)
 {
 	int i, ret;
-	u32 sid, *sids;
-	struct pci_dev *pdev;
+	u32 *sids;
 	struct iommu_group *group;
 	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_device *smmu;

-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
-		return -ENODEV;
-
-	pdev = to_pci_dev(dev);
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);

 	smmu_group = iommu_group_get_iommudata(group);
 	if (!smmu_group) {
-		smmu = arm_smmu_get_for_pci_dev(pdev);
+		smmu = dev->archdata.iommu;
 		if (!smmu) {
 			ret = -ENOENT;
 			goto out_put_group;
@@ -1817,8 +1798,6 @@ static int arm_smmu_add_device(struct device *dev)
 		smmu = smmu_group->smmu;
 	}

-	/* Assume SID == RID until firmware tells us otherwise */
-	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
 		if (smmu_group->sids[i] == sid)
@@ -1855,11 +1834,43 @@ static int arm_smmu_add_device(struct device *dev)

 out_put_group:
 	iommu_group_put(group);
+	dev_err(dev, "failed to add into SMMU\n");
 	return ret;
 }

+static int __arm_smmu_add_pci_device(struct pci_dev *pdev, void *smmu)
+{
+	u32 sid;
+	struct device *dev = &pdev->dev;
+
+	/* Assume SID == RID until firmware tells us otherwise */
+	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
+
+	dev->archdata.iommu = smmu;
+
+	return __arm_smmu_add_device(dev, sid);
+}
+
+static int arm_smmu_add_device(struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct device *root;
+
+	/* only support pci devices hotplug */
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+	root = arm_smmu_get_pci_dev_root(pdev);
+	if (!root->archdata.iommu)
+		return -ENODEV;
+
+	return __arm_smmu_add_pci_device(pdev, root->archdata.iommu);
+}
+
 static void arm_smmu_remove_device(struct device *dev)
 {
+	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 }

@@ -1907,7 +1918,49 @@ out_unlock:
 	return ret;
 }

+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	int ret;
+	struct platform_device *pdev;
+	struct arm_smmu_device *smmu;
+
+	pdev = of_find_device_by_node(args->np);
+	if (!pdev)
+		return -EINVAL;
+
+	smmu = platform_get_drvdata(pdev);
+
+	if (!dev->archdata.iommu)
+		dev->archdata.iommu = smmu;
+
+	if (dev->archdata.iommu != smmu) {
+		dev_err(dev, "behinds more than one smmu\n");
+		return -EINVAL;
+	}
+
+	/* We only support PCI, for now */
+	if (!dev_is_pci(dev)) {
+		return -ENODEV;
+	} else {
+		struct device *root;
+		struct pci_dev *pdev = NULL;
+
+		for_each_pci_dev(pdev) {
+			root = arm_smmu_get_pci_dev_root(pdev);
+			if (root->of_node != dev->of_node)
+				continue;
+
+			ret = __arm_smmu_add_pci_device(pdev, smmu);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
+	.of_xlate		= arm_smmu_of_xlate,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
@@ -2687,6 +2740,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)

 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
+	of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);

 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
@@ -2750,6 +2804,8 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);

+IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", NULL);
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
 MODULE_LICENSE("GPL v2");
--
2.5.0
