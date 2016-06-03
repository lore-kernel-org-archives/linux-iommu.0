From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 7/7] iommu/arm-smmu: Support non-PCI devices with SMMUv3
Date: Fri,  3 Jun 2016 18:15:42 +0100
Message-ID: <42a8a71932f766d70ea9dcae5d11d5f33dcc3652.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the device <-> stream ID relationship suitably abstracted and
of_xlate() hooked up, we no longer have any PCI-specifics in play,
so adding support for the simpler kinds of platform device (a single
unique stream ID each) becomes trivial; let's do it!

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New. Consider this one "extra bonus material" as I'm not sure there
    are even any suitable devices on our model to test it with (it
    _should_ be OK, given that I know the basic infrastructure on either
    side works...)

 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/arm-smmu-v3.c | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ad0860383cb3..d1c66afefeed 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -308,7 +308,7 @@ config ARM_SMMU
 
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
-	depends on ARM64 && PCI
+	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 28dcc5ca237e..6379f0ab24fc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -35,6 +35,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include <linux/amba/bus.h>
+
 #include "io-pgtable.h"
 
 /* MMIO registers */
@@ -1773,6 +1775,22 @@ static void arm_smmu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *arm_smmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	/*
+	 * We've currently no means of grouping non-PCI masters, so
+	 * there'd better not be any non-unique stream IDs in the DT...
+	 */
+	if (dev_is_pci(dev))
+		group = pci_device_group(dev);
+	else
+		group = generic_device_group(dev);
+
+	return group;
+}
+
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
@@ -1821,10 +1839,6 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	struct arm_smmu_master_data *data;
 
-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
-		return -ENODEV;
-
 	if (dev->archdata.iommu)
 		return -EEXIST;
 
@@ -1855,7 +1869,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
-	.device_group		= pci_device_group,
+	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
@@ -2598,7 +2612,17 @@ static int __init arm_smmu_init(void)
 	if (ret)
 		return ret;
 
-	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+#ifdef CONFIG_PCI
+	ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+	if (ret)
+		return ret;
+#endif
+#ifdef CONFIG_ARM_AMBA
+	ret = bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+	if (ret)
+		return ret;
+#endif
+	return bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
 }
 
 static void __exit arm_smmu_exit(void)
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
