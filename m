From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 4/4] iommu/ipmmu-vmsa: Unify ipmmu_ops
Date: Fri, 13 Oct 2017 19:23:42 +0100
Message-ID: <449928aa04c858ca906bbdd1bcd2060bfd9cb0c5.1507918320.git.robin.murphy@arm.com>
References: <cover.1507918320.git.robin.murphy@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1507918320.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, arnd@arndb.de, laurent.pinchart+renesas@ideasonboard.com, magnus.damm@gmail.com, geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The remaining difference between the ARM-specific and iommu-dma ops is
in the {add,remove}_device implementations, but even those have some
overlap and duplication. By stubbing out the few arm_iommu_*() calls,
we can get rid of the rest of the inline #ifdeffery to both simplify the
code and improve build coverage.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 69 +++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 4d69c08145a1..2005aad09f2f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -27,6 +27,11 @@
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
+#else
+#define arm_iommu_create_mapping(...)	NULL
+#define arm_iommu_attach_device(...)	-ENODEV
+#define arm_iommu_release_mapping(...)	do {} while (0)
+#define arm_iommu_detach_device(...)	do {} while (0)
 #endif
 
 #include "io-pgtable.h"
@@ -678,26 +683,17 @@ static int ipmmu_of_xlate(struct device *dev,
 	return ipmmu_init_platform_device(dev, spec);
 }
 
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-
-static int ipmmu_add_device(struct device *dev)
+static int ipmmu_init_arm_mapping(struct device *dev)
 {
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
 	int ret;
 
-	/*
-	 * Only let through devices that have been verified in xlate()
-	 */
-	if (!mmu)
-		return -ENODEV;
-
 	/* Create a device group and add the device to it. */
 	group = iommu_group_alloc();
 	if (IS_ERR(group)) {
 		dev_err(dev, "Failed to allocate IOMMU group\n");
-		ret = PTR_ERR(group);
-		goto error;
+		return PTR_ERR(group);
 	}
 
 	ret = iommu_group_add_device(group, dev);
@@ -705,8 +701,7 @@ static int ipmmu_add_device(struct device *dev)
 
 	if (ret < 0) {
 		dev_err(dev, "Failed to add device to IPMMU group\n");
-		group = NULL;
-		goto error;
+		return ret;
 	}
 
 	/*
@@ -742,41 +737,14 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
-	if (mmu)
+	iommu_group_remove_device(dev);
+	if (mmu->mapping)
 		arm_iommu_release_mapping(mmu->mapping);
 
-	if (!IS_ERR_OR_NULL(group))
-		iommu_group_remove_device(dev);
-
 	return ret;
 }
 
-static void ipmmu_remove_device(struct device *dev)
-{
-	arm_iommu_detach_device(dev);
-	iommu_group_remove_device(dev);
-}
-
-static const struct iommu_ops ipmmu_ops = {
-	.domain_alloc = ipmmu_domain_alloc,
-	.domain_free = ipmmu_domain_free,
-	.attach_dev = ipmmu_attach_device,
-	.detach_dev = ipmmu_detach_device,
-	.map = ipmmu_map,
-	.unmap = ipmmu_unmap,
-	.map_sg = default_iommu_map_sg,
-	.iova_to_phys = ipmmu_iova_to_phys,
-	.add_device = ipmmu_add_device,
-	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = ipmmu_of_xlate,
-};
-
-#endif /* !CONFIG_ARM && CONFIG_IOMMU_DMA */
-
-#ifdef CONFIG_IOMMU_DMA
-
-static int ipmmu_add_device_dma(struct device *dev)
+static int ipmmu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 
@@ -786,15 +754,20 @@ static int ipmmu_add_device_dma(struct device *dev)
 	if (!to_ipmmu(dev))
 		return -ENODEV;
 
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
+		return ipmmu_init_arm_mapping(dev);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	iommu_group_put(group);
 	return 0;
 }
 
-static void ipmmu_remove_device_dma(struct device *dev)
+static void ipmmu_remove_device(struct device *dev)
 {
+	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 }
 
@@ -824,15 +797,13 @@ static const struct iommu_ops ipmmu_ops = {
 	.iotlb_sync = ipmmu_iotlb_sync,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
-	.add_device = ipmmu_add_device_dma,
-	.remove_device = ipmmu_remove_device_dma,
+	.add_device = ipmmu_add_device,
+	.remove_device = ipmmu_remove_device,
 	.device_group = ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 };
 
-#endif /* CONFIG_IOMMU_DMA */
-
 /* -----------------------------------------------------------------------------
  * Probe/remove and init
  */
@@ -929,9 +900,7 @@ static int ipmmu_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&mmu->iommu);
 	iommu_device_unregister(&mmu->iommu);
 
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	arm_iommu_release_mapping(mmu->mapping);
-#endif
 
 	ipmmu_device_reset(mmu);
 
-- 
2.13.4.dirty
