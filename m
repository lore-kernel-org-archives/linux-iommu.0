From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Check devices in xlate()
Date: Fri, 27 Jan 2017 15:14:36 +0900
Message-ID: <148549767671.22203.10735883809069203556.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Rework the IPMMU code to validate devices in ->xlate() instead of
accepting all devices in xlate() and instead validating devices
in ->add_device(). This makes it possible for the IPMMU device
driver to reject slave devices based on software policy.

Once a slave device is rejected by the ->xlate() callback the shared
function of_iommu_configure() will fail as well which in turn disables
per-device IOMMU handing in the arch-specific mapping code by not
passing any IOMMU callbacks to arch_setup_dma_ops().

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 TODO: Make sure this does not break R-Car Gen2 support

 drivers/iommu/ipmmu-vmsa.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

--- 0007/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-01-27 13:11:35.970607110 +0900
@@ -1007,16 +1007,14 @@ static int ipmmu_add_device_dma(struct d
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct iommu_group *group;
 
-	/* only accept devices with iommus property */
-	if (of_count_phandle_with_args(dev->of_node, "iommus",
-				       "#iommu-cells") < 0)
+	/* The device needs to be verified in xlate() */
+	if (!archdata)
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	archdata = dev->archdata.iommu;
 	spin_lock(&ipmmu_slave_devices_lock);
 	list_add(&archdata->list, &ipmmu_slave_devices);
 	spin_unlock(&ipmmu_slave_devices_lock);
@@ -1034,24 +1032,13 @@ static void ipmmu_remove_device_dma(stru
 	iommu_group_remove_device(dev);
 }
 
-static struct iommu_group *ipmmu_device_group_dma(struct device *dev)
-{
-	struct iommu_group *group;
-	int ret;
-
-	ret = ipmmu_init_platform_device(dev);
-	if (!ret)
-		group = ipmmu_find_group(dev);
-	else
-		group = ERR_PTR(ret);
-
-	return group;
-}
-
 static int ipmmu_of_xlate_dma(struct device *dev,
 			      struct of_phandle_args *spec)
 {
-	return 0;
+	/* For now only tested on R-Car Gen3 with ARM64 arch init order
+	 * TODO: Test R-Car Gen2 with ARM32 arch init order
+	 */
+	return ipmmu_init_platform_device(dev);
 }
 
 static const struct iommu_ops ipmmu_ops = {
@@ -1065,7 +1052,7 @@ static const struct iommu_ops ipmmu_ops
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device_dma,
 	.remove_device = ipmmu_remove_device_dma,
-	.device_group = ipmmu_device_group_dma,
+	.device_group = ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate_dma,
 };
