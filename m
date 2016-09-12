From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 08/22] iommu/arm-smmu: Support non-PCI devices with SMMUv3
Date: Mon, 12 Sep 2016 17:13:46 +0100
Message-ID: <a35b94e1fd034ccfd146c819ae71734f3fe075a7.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the device <-> stream ID relationship suitably abstracted and
of_xlate() hooked up, the PCI dependency now looks, and is, entirely
arbitrary. Any bus using the of_dma_configure() mechanism will work,
so extend support to the platform and AMBA buses which do just that.

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/arm-smmu-v3.c | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d432ca828472..8ee54d71c7eb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -309,7 +309,7 @@ config ARM_SMMU
 
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
-	depends on ARM64 && PCI
+	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15ba80db6465..52860bcf80f2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -35,6 +35,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include <linux/amba/bus.h>
+
 #include "io-pgtable.h"
 
 /* MMIO registers */
@@ -1805,6 +1807,23 @@ static void arm_smmu_remove_device(struct device *dev)
 	iommu_fwspec_free(dev);
 }
 
+static struct iommu_group *arm_smmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	/*
+	 * We don't support devices sharing stream IDs other than PCI RID
+	 * aliases, since the necessary ID-to-device lookup becomes rather
+	 * impractical given a potential sparse 32-bit stream ID space.
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
@@ -1851,10 +1870,6 @@ out_unlock:
 
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
-	/* We only support PCI, for now */
-	if (!dev_is_pci(dev))
-		return -ENODEV;
-
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
@@ -1869,7 +1884,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
-	.device_group		= pci_device_group,
+	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
@@ -2613,8 +2628,18 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	/* And we're up. Go go go! */
 	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+#ifdef CONFIG_PCI
 	pci_request_acs();
-	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
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
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
