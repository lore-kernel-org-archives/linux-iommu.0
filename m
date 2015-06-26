From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/8] iommu/arm-smmu: add support for non-pci devices
Date: Fri, 26 Jun 2015 16:33:02 +0800
Message-ID: <1435307584-9812-7-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

Now, we only support a master with only one stream id. It will cover most
hardware platforms and coding so easy.

Please refer Documentation\devicetree\bindings\iommu\iommu.txt on how to
bind device tree.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 arch/arm64/include/asm/device.h |  2 +
 drivers/iommu/arm-smmu-v3.c     | 88 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef25..225e4f9 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -20,6 +20,8 @@ struct dev_archdata {
 	struct dma_map_ops *dma_ops;
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
+	struct device_node *of_smmu;
+	u32 sid;
 #endif
 	bool dma_coherent;
 };
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 483c918..87c3d9b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -30,9 +30,14 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <linux/of_iommu.h>

 #include "io-pgtable.h"

+/* Maximum number of stream IDs assigned to a single device */
+#define MAX_MASTER_STREAMIDS		1
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL_SHIFT		27
@@ -608,6 +613,22 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }

+static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
+{
+	struct arm_smmu_device *smmu;
+
+	spin_lock(&arm_smmu_devices_lock);
+	list_for_each_entry(smmu, &arm_smmu_devices, list) {
+		if (smmu->dev->of_node == dev->archdata.of_smmu) {
+			spin_unlock(&arm_smmu_devices_lock);
+			return smmu;
+		}
+	}
+	spin_unlock(&arm_smmu_devices_lock);
+
+	return NULL;
+}
+
 /* Low-level queue manipulation functions */
 static bool queue_full(struct arm_smmu_queue *q)
 {
@@ -1760,9 +1781,36 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_device *smmu;

-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
-		return -ENODEV;
+	if (!dev_is_pci(dev)) {
+		smmu = find_smmu_for_device(dev);
+		if (!smmu)
+			return -ENODEV;
+
+		group = iommu_group_alloc();
+		if (IS_ERR(group)) {
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+			return PTR_ERR(group);
+		}
+
+		ret = iommu_group_add_device(group, dev);
+		if (ret)
+			goto out_put_group;
+
+		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
+		if (!smmu_group) {
+			ret = -ENOMEM;
+			goto out_put_group;
+		}
+
+		smmu_group->ste.valid = true;
+		smmu_group->smmu = smmu;
+		iommu_group_set_iommudata(group, smmu_group,
+						__arm_smmu_release_iommudata);
+
+		sid = dev->archdata.sid;
+
+		goto handle_stream_id;
+	}

 	pdev = to_pci_dev(dev);
 	group = iommu_group_get_for_dev(dev);
@@ -1793,6 +1841,8 @@ static int arm_smmu_add_device(struct device *dev)

 	/* Assume SID == RID until firmware tells us otherwise */
 	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
+
+handle_stream_id:
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
 		if (smmu_group->sids[i] == sid)
@@ -1881,7 +1931,23 @@ out_unlock:
 	return ret;
 }

+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	if (args->args_count > MAX_MASTER_STREAMIDS) {
+		dev_err(dev,
+			"reached maximum number (%d) of stream IDs for master device %s\n",
+			MAX_MASTER_STREAMIDS, dev->of_node->name);
+		return -ENOSPC;
+	}
+
+	dev->archdata.of_smmu = args->np;
+	dev->archdata.sid = args->args[0];
+
+	return 0;
+}
+
 static struct iommu_ops arm_smmu_ops = {
+	.of_xlate		= arm_smmu_of_xlate,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
@@ -2655,6 +2721,14 @@ static int __init arm_smmu_init(void)
 	if (ret)
 		return ret;

+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+
 	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 }

@@ -2666,6 +2740,14 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);

+static int arm_smmu_of_iommu_init(struct device_node *np)
+{
+	of_iommu_set_ops(np, &arm_smmu_ops);
+
+	return 0;
+}
+IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", arm_smmu_of_iommu_init);
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
--
1.8.0
