From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 13/23] iommu/tegra: smmu: Create default IOVA maps
Date: Wed, 26 Jun 2013 12:28:16 +0300
Message-ID: <1372238906-9346-14-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Create default IOVA maps at boot-up which can be attached to devices.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3e03c69..1617c90 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -319,6 +319,8 @@ struct smmu_device {
 
 	struct device_node *ahb;
 
+	struct dma_iommu_mapping **map;
+
 	int		num_as;
 	struct smmu_as	as[0];		/* Run-time allocated array */
 };
@@ -1144,6 +1146,26 @@ static int tegra_smmu_resume(struct device *dev)
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
@@ -1160,13 +1182,15 @@ static int tegra_smmu_probe(struct platform_device *pdev)
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
@@ -1238,7 +1262,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu_debugfs_create(smmu);
 	smmu_handle = smmu;
 	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
-	return 0;
+	return tegra_smmu_create_default_map(smmu);
 }
 
 static int tegra_smmu_remove(struct platform_device *pdev)
-- 
1.8.1.5
