Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC5264A65
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543781; cv=none; b=Z6Sazc1VKbGqpzo7mVIXrVOLFboL1gd+bRNCBobBWwGJGNa9LJ2VVWZoUT4FsPwLpadJHxEdr8d5y8+xgnXY3c6T8DkSp8NEIj731JStunu83Dxv5yfoTKuQTeMwU+LKHQihKauFHtpH4MBMM0Ptvv0iC6/Y2siHamwP6pgKwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543781; c=relaxed/simple;
	bh=G95Ouu8WoU5J3YRRpjdBP3mpbA6xt0UFRHCOY8b1wtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4f0LTKovTljk1JN0Fsoch1RZoWNgWCHjcJ+Bc/9Z7K28gSPs0Gw3gCvxL8UfFQjAfq4OoRatPF2KN+qCjrYO5zxbr/MXuzFUJ/jLVrADkoU2Lp/PEGyJs39zE/68b+viG8bOiYS6bzwOgJNoft+LCVJpdMO0q8BOx6n4wHfPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DkR5Z1CQ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DkR5Z1CQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775543770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EhqXbw6AbQ+LYGB74n1p1IUKnqM4tC9yHeEGzLQAGX0=;
	b=DkR5Z1CQGRp8tWOVu8UXRQ7V2isI1ni6wKMoPbFOe28337ug0uWMYFRJgvWoupGqZco93YB1S3rZVj8OfBli7kEH/9vPRulhzy5b5CcnAQ03+Pp9nGK30ICm3KUrg2hVLC/heHIDHxASzQXDpK2N0/SEqXn3TXkL6QJTvdEUcvU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X0apop5_1775543768;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X0apop5_1775543768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 14:36:09 +0800
Message-ID: <ad858513-09fc-455e-bbc5-fe38a225cc78@linux.alibaba.com>
Date: Tue, 7 Apr 2026 14:36:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v5] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260404050243.141366-1-nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260404050243.141366-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/4/26 1:02 PM, Nicolin Chen wrote:
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
> 
> As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
> will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
> device reset.
> 
> On the other hand, removing the outer calls in the PCI callers is unsafe.
> As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
> execute custom firmware waits after their inner pcie_flr() completes. If
> the IOMMU protection relies solely on the inner reset, the IOMMU will be
> unblocked prematurely while the device is still resetting.
> 
> Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.
> 
> Given the IOMMU core tracks the resetting state per iommu_group while the
> reset is per device, this has to track at the group_device level as well.
> 
> Introduce a 'reset_depth' to struct group_device to handle the re-entries
> on the same device. This allows multi-device groups to isolate concurrent
> device resets independently.
> 
> Note that iommu_deferred_attach() and iommu_driver_get_domain_for_dev()
> both now check gdev->reset_depth (per-device) instead of a per-group flag
> like "group->resetting_domain". This is actually more precise.
> 
> As the reset routine is per gdev, it cannot clear group->resetting_domain
> without iterating over the device list to ensure no other device is being
> reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
> in the struct iommu_group.
> 
> Since both helpers are now per gdev, call the per-device set_dev_pasid op
> to recover PASID domains.
> 
> While fixing the bug, also fix the kdoc for pci_dev_reset_iommu_done().
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
>   v5:
>    * Add 'blocked' to fix iommu_driver_get_domain_for_dev() return.
>   v4:
>    https://lore.kernel.org/all/20260324014056.36103-1-nicolinc@nvidia.com/
>    * Rename 'reset_cnt' to 'recovery_cnt'
>   v3:
>    https://lore.kernel.org/all/20260321223930.10836-1-nicolinc@nvidia.com/
>    * Turn prepare()/done() to be per-gdev
>    * Use reset_depth to track nested re-entries
>    * Replace group->resetting_domain with a reset_cnt
>   v2:
>    https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
>    * Fix in the helpers by allowing re-entry
>   v1:
>    https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/
> 
>   drivers/iommu/iommu.c | 116 +++++++++++++++++++++++++++++-------------
>   1 file changed, 82 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db517809540..4bd7a4afc9881 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -61,14 +61,14 @@ struct iommu_group {
>   	int id;
>   	struct iommu_domain *default_domain;
>   	struct iommu_domain *blocking_domain;
> -	/*
> -	 * During a group device reset, @resetting_domain points to the physical
> -	 * domain, while @domain points to the attached domain before the reset.
> -	 */
> -	struct iommu_domain *resetting_domain;
>   	struct iommu_domain *domain;
>   	struct list_head entry;
>   	unsigned int owner_cnt;
> +	/*
> +	 * Number of devices in the group undergoing or awaiting recovery.
> +	 * If non-zero, concurrent domain attachments are rejected.
> +	 */
> +	unsigned int recovery_cnt;
>   	void *owner;
>   };
>   
> @@ -76,12 +76,28 @@ struct group_device {
>   	struct list_head list;
>   	struct device *dev;
>   	char *name;
> +	bool blocked;
> +	unsigned int reset_depth;
>   };
>   
>   /* Iterate over each struct group_device in a struct iommu_group */
>   #define for_each_group_device(group, pos) \
>   	list_for_each_entry(pos, &(group)->devices, list)
>   
> +static struct group_device *__dev_to_gdev(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	struct group_device *gdev;
> +
> +	lockdep_assert_held(&group->mutex);
> +
> +	for_each_group_device(group, gdev) {
> +		if (gdev->dev == dev)
> +			return gdev;
> +	}
> +	return NULL;
> +}
> +
>   struct iommu_group_attribute {
>   	struct attribute attr;
>   	ssize_t (*show)(struct iommu_group *group, char *buf);
> @@ -2191,6 +2207,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> +	struct group_device *gdev;
> +
>   	/*
>   	 * This is called on the dma mapping fast path so avoid locking. This is
>   	 * racy, but we have an expectation that the driver will setup its DMAs
> @@ -2201,6 +2219,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   
>   	guard(mutex)(&dev->iommu_group->mutex);
>   
> +	gdev = __dev_to_gdev(dev);
> +	if (WARN_ON(!gdev))
> +		return -ENODEV;
>   	/*
>   	 * This is a concurrent attach during a device reset. Reject it until
>   	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
> @@ -2208,7 +2229,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   	 * Note that this might fail the iommu_dma_map(). But there's nothing
>   	 * more we can do here.
>   	 */
> -	if (dev->iommu_group->resetting_domain)
> +	if (gdev->blocked)
>   		return -EBUSY;
>   	return __iommu_attach_device(domain, dev, NULL);
>   }
> @@ -2265,19 +2286,23 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>   struct iommu_domain *iommu_driver_get_domain_for_dev(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
> +	struct group_device *gdev;
>   
>   	lockdep_assert_held(&group->mutex);
> +	gdev = __dev_to_gdev(dev);
> +	if (WARN_ON(!gdev))
> +		return NULL;
>   
>   	/*
>   	 * Driver handles the low-level __iommu_attach_device(), including the
>   	 * one invoked by pci_dev_reset_iommu_done() re-attaching the device to
>   	 * the cached group->domain. In this case, the driver must get the old
> -	 * domain from group->resetting_domain rather than group->domain. This
> +	 * domain from group->blocking_domain rather than group->domain. This
>   	 * prevents it from re-attaching the device from group->domain (old) to
>   	 * group->domain (new).
>   	 */
> -	if (group->resetting_domain)
> -		return group->resetting_domain;
> +	if (gdev->blocked)
> +		return group->blocking_domain;
>   
>   	return group->domain;
>   }
> @@ -2436,10 +2461,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>   		return -EINVAL;
>   
>   	/*
> -	 * This is a concurrent attach during a device reset. Reject it until
> +	 * This is a concurrent attach during device recovery. Reject it until
>   	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
>   	 */
> -	if (group->resetting_domain)
> +	if (group->recovery_cnt)
>   		return -EBUSY;
>   
>   	/*
> @@ -3567,10 +3592,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   	mutex_lock(&group->mutex);
>   
>   	/*
> -	 * This is a concurrent attach during a device reset. Reject it until
> +	 * This is a concurrent attach during device recovery. Reject it until
>   	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
>   	 */
> -	if (group->resetting_domain) {
> +	if (group->recovery_cnt) {
>   		ret = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -3660,10 +3685,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>   	mutex_lock(&group->mutex);
>   
>   	/*
> -	 * This is a concurrent attach during a device reset. Reject it until
> +	 * This is a concurrent attach during device recovery. Reject it until
>   	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
>   	 */
> -	if (group->resetting_domain) {
> +	if (group->recovery_cnt) {
>   		ret = -EBUSY;
>   		goto out_unlock;
>   	}
> @@ -3934,12 +3959,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>    * routine wants to block any IOMMU activity: translation and ATS invalidation.
>    *
>    * This function attaches the device's RID/PASID(s) the group->blocking_domain,
> - * setting the group->resetting_domain. This allows the IOMMU driver pausing any
> + * incrementing the group->recovery_cnt, to allow the IOMMU driver pausing any
>    * IOMMU activity while leaving the group->domain pointer intact. Later when the
>    * reset is finished, pci_dev_reset_iommu_done() can restore everything.
>    *
>    * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
> - * before/after the core-level reset routine, to unset the resetting_domain.
> + * before/after the core-level reset routine, to decrement the recovery_cnt.
>    *
>    * Return: 0 on success or negative error code if the preparation failed.
>    *
> @@ -3952,6 +3977,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>   int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   {
>   	struct iommu_group *group = pdev->dev.iommu_group;
> +	struct group_device *gdev;
>   	unsigned long pasid;
>   	void *entry;
>   	int ret;
> @@ -3961,21 +3987,25 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   
>   	guard(mutex)(&group->mutex);
>   
> -	/* Re-entry is not allowed */
> -	if (WARN_ON(group->resetting_domain))
> -		return -EBUSY;
> +	gdev = __dev_to_gdev(&pdev->dev);
> +	if (WARN_ON(!gdev))
> +		return -ENODEV;
> +
> +	if (gdev->reset_depth++)
> +		return 0;
>   
>   	ret = __iommu_group_alloc_blocking_domain(group);
>   	if (ret)
> -		return ret;
> +		goto err_depth;
>   
>   	/* Stage RID domain at blocking_domain while retaining group->domain */
>   	if (group->domain != group->blocking_domain) {
>   		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
>   					    group->domain);
>   		if (ret)
> -			return ret;
> +			goto err_depth;
>   	}
> +	gdev->blocked = true;
>   
>   	/*
>   	 * Stage PASID domains at blocking_domain while retaining pasid_array.
> @@ -3987,7 +4017,11 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   		iommu_remove_dev_pasid(&pdev->dev, pasid,
>   				       pasid_array_entry_to_domain(entry));

Hi Nicolin,

The max_pasids check is indeed missing in
pci_dev_reset_iommu_prepare(). All other callers of
iommu_remove_dev_pasid() guard it with a max_pasids > 0 check:

- __iommu_remove_group_pasid() checks device->dev->iommu->max_pasids > 0
- __iommu_set_group_pasid() error rollback path also checks it

But pci_dev_reset_iommu_prepare() calls iommu_remove_dev_pasid()
unconditionally while iterating pasid_array. Since pasid_array is
per-group, in a multi-device group where only some devices support
PASIDs, this could call the driver's set_dev_pasid on a device that
doesn't support PASIDs.

Note that this is a pre-existing issue in the
original code before this patch, not a regression introduced by this
fix.


>   
> -	group->resetting_domain = group->blocking_domain;
> +	group->recovery_cnt++;
> +	return ret;
> +
> +err_depth:
> +	gdev->reset_depth--;
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
> @@ -3997,9 +4031,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
>    * @pdev: PCI device that has finished a reset routine
>    *
>    * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
> - * IOMMU activity, including new translation as well as cache invalidation, by
> - * re-attaching all RID/PASID of the device's back to the domains retained in
> - * the core-level structure.
> + * activity, including new translation and cache invalidation, by re-attaching
> + * all RID/PASID of the device back to the domains retained in the core-level
> + * structure.
>    *
>    * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
>    *
> @@ -4009,6 +4043,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
>   void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   {
>   	struct iommu_group *group = pdev->dev.iommu_group;
> +	struct group_device *gdev;
>   	unsigned long pasid;
>   	void *entry;
>   
> @@ -4017,11 +4052,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   
>   	guard(mutex)(&group->mutex);
>   
> -	/* pci_dev_reset_iommu_prepare() was bypassed for the device */
> -	if (!group->resetting_domain)
> +	gdev = __dev_to_gdev(&pdev->dev);
> +	if (WARN_ON(!gdev))
> +		return;
> +
> +	/* Unbalanced done() calls would underflow the counter */
> +	if (WARN_ON(gdev->reset_depth == 0))
> +		return;
> +	if (--gdev->reset_depth)
>   		return;
>   
> -	/* pci_dev_reset_iommu_prepare() was not successfully called */
>   	if (WARN_ON(!group->blocking_domain))
>   		return;
>   
> @@ -4030,6 +4070,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
>   					      group->blocking_domain));
>   	}
> +	gdev->blocked = false;


One question about the placement of gdev->blocked = false in done(). In
the original code, group->resetting_domain is cleared at the very end of
done(), after both RID re-attach and PASID restore:

__iommu_attach_device(group->domain, ...);   // RID re-attach
__iommu_set_group_pasid(...);                 // PASID restore
group->resetting_domain = NULL;               // cleared last

So iommu_driver_get_domain_for_dev() returns blocking_domain throughout
the entire restore sequence.In v5, gdev->blocked is cleared between RID
re-attach and PASID restore:

__iommu_attach_device(group->domain, ...);   // blocked=true
gdev->blocked = false;                        // cleared here
set_dev_pasid(...);                           // blocked=false

This means during PASID restore, iommu_driver_get_domain_for_dev() now
returns group->domain instead of blocking_domain — a behavioral change
from the original code.

I traced through the ARM SMMUv3 path: arm_smmu_set_pasid() →
arm_smmu_update_ste(), and the early return at:

if (master->cd_table.in_ste && master->ste_ats_enabled == ats_enabled)
     return;

is always taken during PASID restore (since RID re-attach already
installed the CD table and ATS state is consistent), so sid_domain is
effectively unused. No functional impact on SMMUv3.

Just want to confirm: is this behavioral change deliberate? Or should
blocked stay true until after PASID restore to preserve the original
behavior?

Thanks.
Shuai
