From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/5] iommu/arm-smmu: to support probe deferral
Date: Tue, 21 Jul 2015 15:30:29 +0800
Message-ID: <1437463833-16112-2-git-send-email-thunder.leizhen@huawei.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437463833-16112-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 147 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 117 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4f09337..474eca4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -30,6 +30,8 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>

 #include "io-pgtable.h"

@@ -1741,32 +1743,37 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 	kfree(data);
 }

-static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
+static struct arm_smmu_device *find_smmu_by_device(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+
+	/* to ensure np is a smmu device node */
+	if (!of_iommu_get_ops(np))
+		return NULL;
+
+	return dev->archdata.iommu;
+}
+
+static struct arm_smmu_device *find_smmu_by_node(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return NULL;
+
+	return find_smmu_by_device(&pdev->dev);
+}
+
+static struct device *arm_smmu_get_pci_dev_root(struct pci_dev *pdev)
 {
-	struct device_node *of_node;
-	struct arm_smmu_device *curr, *smmu = NULL;
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
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev->of_node == of_node) {
-			smmu = curr;
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-	of_node_put(of_node);
-	return smmu;
+	return bus->bridge->parent;
 }

 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
@@ -1779,27 +1786,21 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
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
@@ -1819,8 +1820,6 @@ static int arm_smmu_add_device(struct device *dev)
 		smmu = smmu_group->smmu;
 	}

-	/* Assume SID == RID until firmware tells us otherwise */
-	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
 		if (smmu_group->sids[i] == sid)
@@ -1857,11 +1856,43 @@ static int arm_smmu_add_device(struct device *dev)

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

@@ -1909,7 +1940,58 @@ out_unlock:
 	return ret;
 }

+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	int ret;
+	struct arm_smmu_device *smmu;
+
+	/*
+	 * We can sure that args->np is a smmu device node, because this
+	 * function was called by of_xlate hook.
+	 *
+	 * And in arm_smmu_device_dt_probe:
+	 *	dev->archdata.iommu = smmu;
+	 *	of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);
+	 *
+	 * It seems impossible return NULL in normal times.
+	 */
+	smmu = find_smmu_by_node(args->np);
+	if (!smmu) {
+		dev_err(dev, "unknown error caused smmu driver crashed\n");
+		return -ENODEV;
+	}
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
@@ -2635,6 +2717,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);
+	dev->archdata.iommu = smmu;
+	of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);
+
 	return 0;

 out_free_structures:
@@ -2706,6 +2791,8 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);

+IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", NULL);
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
--
1.8.0
