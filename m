From: Peng Fan <van.freenix@gmail.com>
Subject: [RFC] iommu: arm-smmu: correct reference count
Date: Tue,  3 Nov 2015 20:59:17 +0800
Message-ID: <1446555557-3097-1-git-send-email-van.freenix@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, will.deacon@arm.com
Cc: joro@8bytes.org, van.freenix@gmail.com
List-Id: iommu@lists.linux-foundation.org

iommu_group_alloc will initialize the reference count for group to 1.
iommu_group_add_device also increase the group reference count,
if nothing bad happends. And we need to add iommu_group_put to
decrease the reference count for group.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---

Not sure whether my understanding is correct or not. I checked rockchip-iommu.c
exynos-iommu.c and fsl_pamu_domain.c, and they all have iommu_group_put after
iommu_group_add_device.

 drivers/iommu/arm-smmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 48a39df..1cab720 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1344,6 +1344,7 @@ static int arm_smmu_add_platform_device(struct device *dev)
 	struct iommu_group *group;
 	struct arm_smmu_master *master;
 	struct arm_smmu_device *smmu = find_smmu_for_device(dev);
+	int ret;
 
 	if (!smmu)
 		return -ENODEV;
@@ -1358,7 +1359,11 @@ static int arm_smmu_add_platform_device(struct device *dev)
 		return PTR_ERR(group);
 
 	iommu_group_set_iommudata(group, &master->cfg, NULL);
-	return iommu_group_add_device(group, dev);
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+
+	return ret;
 }
 
 static int arm_smmu_add_device(struct device *dev)
-- 
1.8.4
