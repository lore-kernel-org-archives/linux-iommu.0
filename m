From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 07/19] iommu/tegra: smmu: Create default IOVA maps
Date: Fri, 18 Oct 2013 13:26:48 +0300
Message-ID: <1382092020-13170-8-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Create default IOVA maps at boot-up which can be attached to devices.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 43af340..4671579 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -39,6 +39,7 @@
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-iommu.h>
 
 enum smmu_hwgrp {
 	HWGRP_AFI,
@@ -319,6 +320,8 @@ struct smmu_device {
 
 	struct device_node *ahb;
 
+	struct dma_iommu_mapping **map;
+
 	int		num_as;
 	struct smmu_as	as[0];		/* Run-time allocated array */
 };
@@ -1144,6 +1147,26 @@ static int tegra_smmu_resume(struct device *dev)
 	return err;
 }
 
+static int tegra_smmu_create_default_map(struct smmu_device *smmu)
+{
+	int i;
+
+	for (i = 0; i < smmu->num_as; i++) {
+		dma_addr_t base = smmu->iovmm_base;
+		size_t size = smmu->page_count << PAGE_SHIFT;
+
+		smmu->map[i] = arm_iommu_create_mapping(&platform_bus_type,
+							base, size, 0);
+		if (WARN_ON(IS_ERR(smmu->map[i])))
+			return -EINVAL;
+
+		dev_dbg(smmu->dev, "map:%p %08x-%08x\n",
+			smmu->map[i], base, base + size - 1);
+	}
+
+	return 0;
+}
+
 static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
@@ -1160,13 +1183,15 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
-	bytes = sizeof(*smmu) + asids * sizeof(*smmu->as);
+	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
+					 sizeof(struct dma_iommu_mapping *));
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate smmu_device\n");
 		return -ENOMEM;
 	}
 
+	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);
 	smmu->nregs = pdev->num_resources;
 	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
 				  GFP_KERNEL);
@@ -1236,7 +1261,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu_debugfs_create(smmu);
 	smmu_handle = smmu;
 	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
-	return 0;
+	return tegra_smmu_create_default_map(smmu);
 }
 
 static int tegra_smmu_remove(struct platform_device *pdev)
-- 
1.8.1.5
