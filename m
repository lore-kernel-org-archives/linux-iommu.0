From: Peng Fan <van.freenix@gmail.com>
Subject: Re: [RFC V2] iommu: correct group reference count
Date: Mon, 9 Nov 2015 21:30:14 +0800
Message-ID: <20151109133011.GA16563@linux-jyl1.ap.freescale.net>
References: <1447049608-6123-1-git-send-email-van.freenix@gmail.com>
 <20151109101058.GB24936@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151109101058.GB24936@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Nov 09, 2015 at 10:10:59AM +0000, Will Deacon wrote:
>On Mon, Nov 09, 2015 at 02:13:28PM +0800, Peng Fan wrote:
>> The basic flow for iommu_group_for_dev is:
>> iommu_group_get_for_dev
>>         |->  iommu_group_get   : increase reference count by 1.
>>              return group;
>>         |->  ops->device_group : Init/increase reference count to/by 1.
>>              iommu_group_add_device  : Increase reference count by 1.
>>              return group;
>> 
>> We can see that ops->device_group and iommu_group_add_device will together
>> increase the iommu group reference count by 2. Actually we only need 1,
>> but not 2. So we need add iommu_group_put after iommu_group_add_device
>> to make sure iommu_group_get_for_dev only increase reference count by 1.
>> 
>> Signed-off-by: Peng Fan <van.freenix@gmail.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>> 
>> V1 thread: https://lkml.org/lkml/2015/11/3/304
>> Changes V2:
>>  I did not see the update about device_group when I worked out V1. So
>>  redo the patch and refine commit msg and rebased to latest linus'
>>  linux master tree.
>> 
>>  drivers/iommu/iommu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index abae363..9c1971b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -852,10 +852,10 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>  	}
>>  
>>  	ret = iommu_group_add_device(group, dev);
>> -	if (ret) {
>> -		iommu_group_put(group);
>> +	iommu_group_put(group);
>> +
>> +	if (ret)
>>  		return ERR_PTR(ret);
>> -	}
>
>Hmm, I don't think this is correct either:
>
>  (1) It doesn't help the arm-smmu driver (which deals with platform
>      devices too)
>
>  (2) It breaks IOMMU drivers that currently have the explicit put already
>      (e.g. amd-iommu.c:init_iommu_group)
>
>The easiest way for you to proceed is to extend your original patch so
>that it also adds an iommu_group_put to the arm-smmu-v3 driver after
>a successful iommu_group_get_for_dev.

I am not sure if the following patch is what you preferred. But this means
that iommu_grou_get_for_dev will increase the group reference count by 2, when
need to create a new group?

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e5118a..9c88301 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1855,6 +1855,9 @@ static int arm_smmu_add_device(struct device *dev)
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

Thanks,
Peng.

>
>Will
