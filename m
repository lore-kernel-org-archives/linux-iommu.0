From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC V4] iommu: arm-smmu: correct group reference count
Date: Fri, 20 Nov 2015 17:05:21 +0800
Message-ID: <20151120090358.GA10958@linux-7smt.suse>
References: <1448009650-10807-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448009650-10807-1-git-send-email-van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Please ignore this patch, wrong author name. Have reposted V4 with correct
author name. Sorry.

Regards,
Peng.
On Fri, Nov 20, 2015 at 04:54:10PM +0800, Freenix wrote:
>The basic flow for add a device:
> arm_smmu_add_device
>        |->iommu_group_get_for_dev
>            |->iommu_group_get
>                     return group;  (1)
>            |->ops->device_group : Init/increase reference count to/by 1.
>            |->iommu_group_add_device : Increase reference count by 1.
>		     return group   (2)
>        |->return 0;
>
>Since we are adding one device, the flow is (2) and the group reference
>count will be increased by 2. So, we need to add iommu_group_put at the
>end of arm_smmu_add_device to decrease the count by 1.
>
>Also take the failure path into consideration when fail to add a device.
>
>Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>---
>
>V3 thread: https://lkml.org/lkml/2015/11/9/842
>Changes V4:
> Follow Will's comments and code diff, add the failure path when failed
> to add a device.
>
>V2 thread: https://lkml.org/lkml/2015/11/9/39
>Changes V3:
> This patch version is wrong to fix the group reference issue.
>
>V1 thread: https://lkml.org/lkml/2015/11/3/304
>Changes V2:
> I did not see the update about device_group when I worked out V1. So
> redo the patch and refine commit msg and rebased to latest linus'
> linux master tree.
>
> drivers/iommu/arm-smmu-v3.c | 18 +++++++++++-------
> drivers/iommu/arm-smmu.c    |  2 ++
> 2 files changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>index 4e5118a..42d30ef 100644
>--- a/drivers/iommu/arm-smmu-v3.c
>+++ b/drivers/iommu/arm-smmu-v3.c
>@@ -1804,13 +1804,13 @@ static int arm_smmu_add_device(struct device *dev)
> 		smmu = arm_smmu_get_for_pci_dev(pdev);
> 		if (!smmu) {
> 			ret = -ENOENT;
>-			goto out_put_group;
>+			goto out_remove_dev;
> 		}
> 
> 		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
> 		if (!smmu_group) {
> 			ret = -ENOMEM;
>-			goto out_put_group;
>+			goto out_remove_dev;
> 		}
> 
> 		smmu_group->ste.valid	= true;
>@@ -1826,20 +1826,20 @@ static int arm_smmu_add_device(struct device *dev)
> 	for (i = 0; i < smmu_group->num_sids; ++i) {
> 		/* If we already know about this SID, then we're done */
> 		if (smmu_group->sids[i] == sid)
>-			return 0;
>+			goto out_put_group;
> 	}
> 
> 	/* Check the SID is in range of the SMMU and our stream table */
> 	if (!arm_smmu_sid_in_range(smmu, sid)) {
> 		ret = -ERANGE;
>-		goto out_put_group;
>+		goto out_remove_dev;
> 	}
> 
> 	/* Ensure l2 strtab is initialised */
> 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> 		ret = arm_smmu_init_l2_strtab(smmu, sid);
> 		if (ret)
>-			goto out_put_group;
>+			goto out_remove_dev;
> 	}
> 
> 	/* Resize the SID array for the group */
>@@ -1849,16 +1849,20 @@ static int arm_smmu_add_device(struct device *dev)
> 	if (!sids) {
> 		smmu_group->num_sids--;
> 		ret = -ENOMEM;
>-		goto out_put_group;
>+		goto out_remove_dev;
> 	}
> 
> 	/* Add the new SID */
> 	sids[smmu_group->num_sids - 1] = sid;
> 	smmu_group->sids = sids;
>-	return 0;
> 
> out_put_group:
> 	iommu_group_put(group);
>+	return 0;
>+
>+out_remove_dev:
>+	iommu_group_remove_device(dev);
>+	iommu_group_put(group);
> 	return ret;
> }
> 
>diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>index 47dc7a7..af6afce 100644
>--- a/drivers/iommu/arm-smmu.c
>+++ b/drivers/iommu/arm-smmu.c
>@@ -1357,6 +1357,8 @@ static int arm_smmu_add_device(struct device *dev)
> 	if (IS_ERR(group))
> 		return PTR_ERR(group);
> 
>+	iommu_group_put(group);
>+
> 	return 0;
> }
> 
>-- 
>2.6.2
>
