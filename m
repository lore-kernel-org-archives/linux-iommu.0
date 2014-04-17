From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 3/5] iommu/ipmmu-vmsa: Add device tree support
Date: Thu, 17 Apr 2014 12:33:25 +0200
Message-ID: <1397730807-5993-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1397730807-5993-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1397730807-5993-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Make platform data optional when the device is instantiated from DT and
look up the micro-TLB number in the bus master DT node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 49e00f7..d277bde 100644
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
@@ -828,16 +829,33 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 
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
+	ret = of_parse_phandle_with_fixed_args(dev->of_node, "iommus",
+					       1, 0, &args);
+	if (ret < 0)
+		return -1;
+
+	of_node_put(args.np);
+
+	if (args.np != mmu->dev->of_node)
+		return -1;
+
+	return args.args[0];
 }
 
 static int ipmmu_add_device(struct device *dev)
@@ -980,7 +998,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	if (!pdev->dev.platform_data) {
+	if (!IS_ENABLED(CONFIG_OF) && !pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -EINVAL;
 	}
@@ -1046,10 +1064,15 @@ static int ipmmu_remove(struct platform_device *pdev)
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
1.8.3.2

