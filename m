From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH] iommu: fix device remove
Date: Fri,  5 May 2017 14:08:37 -0400
Message-ID: <20170505180837.11326-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

It looks like it *used* to make sense to free the device.  But now it is
embedded in 'struct iommu' (which is allocated or embedded in something
that the device allocated).

Spotted when testing qcom_iommu with CONFIG_DEBUG_TEST_DRIVER_REMOVE.

Fixes: 39ab955 ("iommu: Add sysfs bindings for struct iommu_device")
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/iommu-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index c58351e..ad19cbb 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -34,7 +34,6 @@ static const struct attribute_group *iommu_dev_groups[] = {
 
 static void iommu_release_device(struct device *dev)
 {
-	kfree(dev);
 }
 
 static struct class iommu_class = {
-- 
2.9.3
