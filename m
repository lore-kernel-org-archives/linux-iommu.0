From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC V3] iommu: arm-smmu: correct group reference count
Date: Tue, 10 Nov 2015 09:56:26 +0800
Message-ID: <1447120586-17847-1-git-send-email-van.freenix@gmail.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 drivers/iommu/arm-smmu.c    | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e5118a..ac333ee 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1825,8 +1825,10 @@ static int arm_smmu_add_device(struct device *dev)
 	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
 	for (i = 0; i < smmu_group->num_sids; ++i) {
 		/* If we already know about this SID, then we're done */
-		if (smmu_group->sids[i] == sid)
+		if (smmu_group->sids[i] == sid) {
+			iommu_group_put(group);
 			return 0;
+		}
 	}
 
 	/* Check the SID is in range of the SMMU and our stream table */
@@ -1855,6 +1857,9 @@ static int arm_smmu_add_device(struct device *dev)
 	/* Add the new SID */
 	sids[smmu_group->num_sids - 1] = sid;
 	smmu_group->sids = sids;
+
+	iommu_group_put(group);
+
 	return 0;
 
 out_put_group:
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
1.8.4
