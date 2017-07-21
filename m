From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu/msm: Add iommu_group support
Date: Fri, 21 Jul 2017 13:12:35 +0100
Message-ID: <b87d44e09fa18efbb9daf6258c1f8ecbedaac23c.1500637633.git.robin.murphy@arm.com>
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
 drivers/iommu/msm_iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d0448353d501..04f4d51ffacb 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -393,6 +393,7 @@ static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
 static int msm_iommu_add_device(struct device *dev)
 {
 	struct msm_iommu_dev *iommu;
+	struct iommu_group *group;
 	unsigned long flags;
 	int ret = 0;
 
@@ -406,7 +407,16 @@ static int msm_iommu_add_device(struct device *dev)
 
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_put(group);
+
+	return 0;
 }
 
 static void msm_iommu_remove_device(struct device *dev)
@@ -421,6 +431,8 @@ static void msm_iommu_remove_device(struct device *dev)
 		iommu_device_unlink(&iommu->iommu, dev);
 
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
+	iommu_group_remove_device(dev);
 }
 
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -700,6 +712,7 @@ static struct iommu_ops msm_iommu_ops = {
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.add_device = msm_iommu_add_device,
 	.remove_device = msm_iommu_remove_device,
+	.device_group = generic_device_group,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 };
-- 
2.12.2.dirty
