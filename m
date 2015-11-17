From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC V3] iommu: arm-smmu: correct group reference count
Date: Tue, 17 Nov 2015 16:17:46 +0000
Message-ID: <20151117161745.GD30101@arm.com>
References: <1447120586-17847-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447120586-17847-1-git-send-email-van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 10, 2015 at 09:56:26AM +0800, Peng Fan wrote:
> The basic flow for add a device:
>  arm_smmu_add_device
>         |->iommu_group_get_for_dev
>             |->iommu_group_get
>                      return group;  (1)
>             |->ops->device_group : Init/increase reference count to/by 1.
>             |->iommu_group_add_device : Increase reference count by 1.
> 		     return group   (2)
>         |->return 0;
> 
> Since we are adding one device, the flow is (2) and the group reference
> count will be increased by 2. So, we need to add iommu_group_put at the
> end of arm_smmu_add_device to decrease the count by 1.
> 
> Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>  drivers/iommu/arm-smmu.c    | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4e5118a..ac333ee 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1825,8 +1825,10 @@ static int arm_smmu_add_device(struct device *dev)
>  	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
>  	for (i = 0; i < smmu_group->num_sids; ++i) {
>  		/* If we already know about this SID, then we're done */
> -		if (smmu_group->sids[i] == sid)
> +		if (smmu_group->sids[i] == sid) {
> +			iommu_group_put(group);
>  			return 0;
> +		}
>  	}
>  
>  	/* Check the SID is in range of the SMMU and our stream table */
> @@ -1855,6 +1857,9 @@ static int arm_smmu_add_device(struct device *dev)
>  	/* Add the new SID */
>  	sids[smmu_group->num_sids - 1] = sid;
>  	smmu_group->sids = sids;
> +
> +	iommu_group_put(group);
> +
>  	return 0;

I still think this is wrong for the failure path. If we fail during
add_device, then we want to put things back like they were, which is
what the out_put_group label is for. That means dropping the refcount
for the group *and* the refcount for the device. The nasty part is that
we don't know if we were responsible for adding the device to the group,
but it looks like we already assume that in ->remove_device.

The best bet is probably something like the diff below.

Thoughts?

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 86480480895d..db03c2fb1319 100644
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
 
