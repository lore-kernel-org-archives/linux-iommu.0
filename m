From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [RFC PATCH 2/2] iommu/arm-smmu: Add support for the fsl-mc bus
Date: Wed, 29 Jun 2016 22:44:08 +0530
Message-ID: <1467220448-16764-2-git-send-email-nipun.gupta@nxp.com>
References: <1467220448-16764-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467220448-16764-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Implement bus specific support for the fsl-mc bus including
registering the arm_smmu_ops and bus specific smmu device init.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ab365ec..28d5dc8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -47,6 +47,9 @@
 
 #include <linux/amba/bus.h>
 
+/* Include path will be changed once FSL-MC support is out from staging */
+#include <../drivers/staging/fsl-mc/include/fsl_mc_smmu.h>
+
 #include "io-pgtable.h"
 
 /* Maximum number of stream IDs assigned to a single device */
@@ -447,6 +450,11 @@ static struct device_node *dev_get_dev_node(struct device *dev)
 		return bus->bridge->parent->of_node;
 	}
 
+	if (dev_is_fsl_mc(dev)) {
+		while (dev_is_fsl_mc(dev))
+			dev = dev->parent;
+	}
+
 	return dev->of_node;
 }
 
@@ -1443,6 +1451,32 @@ static int arm_smmu_init_platform_device(struct device *dev,
 	return 0;
 }
 
+static void __arm_smmu_release_fslmc_iommudata(void *data)
+{
+	kfree(data);
+}
+
+static int arm_smmu_init_fslmc_device(struct device *dev,
+				      struct iommu_group *group)
+{
+	struct arm_smmu_master_cfg *cfg;
+
+	cfg = iommu_group_get_iommudata(group);
+	if (!cfg) {
+		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+		if (!cfg)
+			return -ENOMEM;
+
+		cfg->streamids[0] = fslmc_dev_streamid(dev);
+		cfg->num_streamids = 1;
+
+		iommu_group_set_iommudata(group, cfg,
+					  __arm_smmu_release_fslmc_iommudata);
+	}
+
+	return 0;
+}
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
@@ -1467,6 +1501,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
+	else if (dev_is_fsl_mc(dev))
+		group = fslmc_device_group(dev);
 	else
 		group = generic_device_group(dev);
 
@@ -1475,6 +1511,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	if (dev_is_pci(dev))
 		ret = arm_smmu_init_pci_device(to_pci_dev(dev), group);
+	else if (dev_is_fsl_mc(dev))
+		ret = arm_smmu_init_fslmc_device(dev, group);
 	else
 		ret = arm_smmu_init_platform_device(dev, group);
 
@@ -2102,6 +2140,11 @@ static int __init arm_smmu_init(void)
 	}
 #endif
 
+#ifdef CONFIG_FSL_MC_BUS
+	if (!iommu_present(&fsl_mc_bus_type))
+		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+#endif
+
 	return 0;
 }
 
-- 
1.9.1
