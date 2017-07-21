From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu/tegra-smmu: Add iommu_group support
Date: Fri, 21 Jul 2017 13:12:36 +0100
Message-ID: <7a6819a5a71c4b85db536169f71a4c087afb60f4.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1500637633.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

As the last step to making groups mandatory, clean up the remaining
drivers by adding basic support. Whilst it may not perfectly reflect
the isolation capabilities of the hardware (tegra_smmu_swgroup sounds
suspiciously like something that might warrant representing at the
iommu_group level), using generic_device_group() should at least
maintain existing behaviour with respect to the API.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index eeb19f560a05..faa9c1e70482 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -704,6 +704,7 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 static int tegra_smmu_add_device(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
+	struct iommu_group *group;
 	struct of_phandle_args args;
 	unsigned int index = 0;
 
@@ -725,12 +726,19 @@ static int tegra_smmu_add_device(struct device *dev)
 		index++;
 	}
 
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_put(group);
+
 	return 0;
 }
 
 static void tegra_smmu_remove_device(struct device *dev)
 {
 	dev->archdata.iommu = NULL;
+	iommu_group_remove_device(dev);
 }
 
 static const struct iommu_ops tegra_smmu_ops = {
@@ -741,6 +749,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.detach_dev = tegra_smmu_detach_dev,
 	.add_device = tegra_smmu_add_device,
 	.remove_device = tegra_smmu_remove_device,
+	.device_group = generic_device_group,
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.map_sg = default_iommu_map_sg,
-- 
2.12.2.dirty
