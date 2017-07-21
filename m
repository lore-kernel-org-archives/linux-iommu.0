From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu/tegra-gart: Add iommu_group support
Date: Fri, 21 Jul 2017 13:12:37 +0100
Message-ID: <9c3fa9661e8177f0ccea960dd584a05fc19f92c8.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1500637633.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

As the last step to making groups mandatory, clean up the remaining
drivers by adding basic support. Whilst it may not perfectly reflect the
isolation capabilities of the hardware, using generic_device_group()
should at least maintain existing behaviour with respect to the API.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 37e708fdbb5a..29bafc6e82ae 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -334,12 +334,31 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
+static int gart_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get_for_dev(dev);
+
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_put(group);
+	return 0;
+}
+
+static void gart_iommu_remove_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
 	.domain_free	= gart_iommu_domain_free,
 	.attach_dev	= gart_iommu_attach_dev,
 	.detach_dev	= gart_iommu_detach_dev,
+	.add_device	= gart_iommu_add_device,
+	.remove_device	= gart_iommu_remove_device,
+	.device_group	= generic_device_group,
 	.map		= gart_iommu_map,
 	.map_sg		= default_iommu_map_sg,
 	.unmap		= gart_iommu_unmap,
-- 
2.12.2.dirty
