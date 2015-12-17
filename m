From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 05/13] iommu/arm-smmu: Correct group reference count
Date: Thu, 17 Dec 2015 12:12:05 +0000
Message-ID: <1450354333-27256-6-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

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

Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 18 +++++++++++-------
 drivers/iommu/arm-smmu.c    |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2e3e235f509c..3ea4d576bf08 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1809,13 +1809,13 @@ static int arm_smmu_add_device(struct device *dev)
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
@@ -1831,20 +1831,20 @@ static int arm_smmu_add_device(struct device *dev)
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
@@ -1854,16 +1854,20 @@ static int arm_smmu_add_device(struct device *dev)
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
index 1ce4b85d5216..6ed169bcb39d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1355,6 +1355,7 @@ static int arm_smmu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	iommu_group_put(group);
 	return 0;
 }
 
-- 
2.1.4
