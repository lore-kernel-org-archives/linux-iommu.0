From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 06/10] iommu/ipmmu-vmsa: Add device tree support
Date: Tue, 16 Dec 2014 15:44:13 +0200
Message-ID: <1418737457-22042-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Make platform data optional when the device is instantiated from DT and
look up the micro-TLB number in the bus master DT node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 55 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

Cc: devicetree@vger.kernel.org

Changes compared to v1:

- Update to the v2 DT bindings

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 70bb5ba2aa51..8d9b3e79f05c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/ipmmu-vmsa.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -58,6 +59,8 @@ static LIST_HEAD(ipmmu_devices);
  * Registers Definition
  */
 
+#define IM_NS_ALIAS_OFFSET		0x800
+
 #define IM_CTX_SIZE			0x40
 
 #define IMCTR				0x0000
@@ -1002,16 +1005,33 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 
 static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
 {
-	const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
-	const char *devname = dev_name(dev);
-	unsigned int i;
+	struct of_phandle_args args;
+	int ret;
+
+	if (mmu->pdata) {
+		const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
+		const char *devname = dev_name(dev);
+		unsigned int i;
 
-	for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
-		if (strcmp(master->name, devname) == 0)
-			return master->utlb;
+		for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
+			if (strcmp(master->name, devname) == 0)
+				return master->utlb;
+		}
+
+		return -1;
 	}
 
-	return -1;
+	ret = of_parse_phandle_with_args(dev->of_node, "iommus",
+					 "#iommu-cells", 0, &args);
+	if (ret < 0)
+		return -1;
+
+	of_node_put(args.np);
+
+	if (args.np != mmu->dev->of_node || args.args_count != 1)
+		return -1;
+
+	return args.args[0];
 }
 
 static int ipmmu_add_device(struct device *dev)
@@ -1156,7 +1176,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	if (!pdev->dev.platform_data) {
+	if (!IS_ENABLED(CONFIG_OF) && !pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -EINVAL;
 	}
@@ -1177,6 +1197,20 @@ static int ipmmu_probe(struct platform_device *pdev)
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);
 
+	/*
+	 * The IPMMU has two register banks, for secure and non-secure modes.
+	 * The bank mapped at the beginning of the IPMMU address space
+	 * corresponds to the running mode of the CPU. When running in secure
+	 * mode the non-secure register bank is also available at an offset.
+	 *
+	 * Secure mode operation isn't clearly documented and is thus currently
+	 * not implemented in the driver. Furthermore, preliminary tests of
+	 * non-secure operation with the main register bank were not successful.
+	 * Offset the registers base unconditionally to point to the non-secure
+	 * alias space for now.
+	 */
+	mmu->base += IM_NS_ALIAS_OFFSET;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no IRQ found\n");
@@ -1222,10 +1256,15 @@ static int ipmmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ipmmu_of_ids[] = {
+	{ .compatible = "renesas,ipmmu-vmsa", },
+};
+
 static struct platform_driver ipmmu_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "ipmmu-vmsa",
+		.of_match_table = of_match_ptr(ipmmu_of_ids),
 	},
 	.probe = ipmmu_probe,
 	.remove	= ipmmu_remove,
-- 
2.0.4

