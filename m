From: Freenix <van.freenix@gmail.com>
Subject: [RFC V4] iommu: arm-smmu: correct group reference count
Date: Fri, 20 Nov 2015 16:54:10 +0800
Message-ID: <1448009650-10807-1-git-send-email-van.freenix@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Freenix <van.freenix@gmail.com>
List-Id: iommu@lists.linux-foundation.org

The basic flow for add a device:
 arm_smmu_add_device
        |->iommu_group_get_for_dev
            |->iommu_group_get
                     return group;  (1)
            |->ops->device_group : Init/increase reference count to/by 1.
            |->iommu_group_add_device : Increase reference count by 1.
		     return group   (2)
        |->return 0;

Since we are adding one device, the flow is (2) and the group reference
count will be increased by 2. So, we need to add iommu_group_put at the
end of arm_smmu_add_device to decrease the count by 1.

Also take the failure path into consideration when fail to add a device.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
---

V3 thread: https://lkml.org/lkml/2015/11/9/842
Changes V4:
 Follow Will's comments and code diff, add the failure path when failed
 to add a device.

V2 thread: https://lkml.org/lkml/2015/11/9/39
Changes V3:
 This patch version is wrong to fix the group reference issue.

V1 thread: https://lkml.org/lkml/2015/11/3/304
Changes V2:
 I did not see the update about device_group when I worked out V1. So
 redo the patch and refine commit msg and rebased to latest linus'
 linux master tree.

 drivers/iommu/arm-smmu-v3.c | 18 +++++++++++-------
 drivers/iommu/arm-smmu.c    |  2 ++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e5118a..42d30ef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1804,13 +1804,13 @@ static int arm_smmu_add_device(struct device *dev)
 		smmu = arm_smmu_get_for_pci_dev(pdev);
 		if (!smmu) {
 			ret = -ENOENT;
-			goto out_put_group;
+			goto out_remove_dev;
 		}
 
 		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
 		if (!smmu_group) {
 			ret = -ENOMEM;
-			goto out_put_group;
+			goto out_remove_dev;
 		}
 
 		smmu_group->ste.valid	= true;
@@ -1826,20 +1826,20 @@ static int arm_smmu_add_device(struct device *dev)
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
 		if (smmu_group->sids[i] == sid)
-			return 0;
+			goto out_put_group;
 	}
 
 	/* Check the SID is in range of the SMMU and our stream table */
 	if (!arm_smmu_sid_in_range(smmu, sid)) {
 		ret = -ERANGE;
-		goto out_put_group;
+		goto out_remove_dev;
 	}
 
 	/* Ensure l2 strtab is initialised */
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
 		ret = arm_smmu_init_l2_strtab(smmu, sid);
 		if (ret)
-			goto out_put_group;
+			goto out_remove_dev;
 	}
 
 	/* Resize the SID array for the group */
@@ -1849,16 +1849,20 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!sids) {
 		smmu_group->num_sids--;
 		ret = -ENOMEM;
-		goto out_put_group;
+		goto out_remove_dev;
 	}
 
 	/* Add the new SID */
 	sids[smmu_group->num_sids - 1] = sid;
 	smmu_group->sids = sids;
-	return 0;
 
 out_put_group:
 	iommu_group_put(group);
+	return 0;
+
+out_remove_dev:
+	iommu_group_remove_device(dev);
+	iommu_group_put(group);
 	return ret;
 }
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 47dc7a7..af6afce 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1357,6 +1357,8 @@ static int arm_smmu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	iommu_group_put(group);
+
 	return 0;
 }
 
-- 
2.6.2
