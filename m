From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: [PATCH] iommu: Check the result of iommu_group_get() for NULL
Date: Mon,  4 Dec 2017 10:22:10 -0700
Message-ID: <1512408130-24833-1-git-send-email-jcrouse@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The result of iommu_group_get() was being blindly used in both
attach and detach which results in a dereference when trying
to work with an unknown device.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..69fef99 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1303,6 +1303,9 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	int ret;
 
 	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
 	/*
 	 * Lock the group to make sure the device-count doesn't
 	 * change while we are attaching
@@ -1341,6 +1344,8 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 	struct iommu_group *group;
 
 	group = iommu_group_get(dev);
+	if (!group)
+		return;
 
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
-- 
1.9.1
