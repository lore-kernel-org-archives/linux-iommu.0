Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8941E1C3A
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296278; cv=none; b=oBw/B6E/YOd4JdDtarfk5qm4bUQBuw+fJAG1Os8flShRk3b++XZN1ED6mia8sLpP8vtNAm67GpOCSV3fKlihniOwGVcBPvyR4vVrpUqbRpiIv02pTd3AT8GglwXwsP6WrtE2NBDf9W64exqPkLebhQu6NItgSbAe+AUwDAr92Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296278; c=relaxed/simple;
	bh=9/kcYu18Mv0TKaB/6JUncDhkX85vJndswpDQXLFc2Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZLh7IaeKSGLx2B56lToF7oKcMSNQ0jqlVEYbAC3lNrVP7l2UhQAhaB7h8ggoHDRPp2AA3cchVBT0d60ITfIYOPOu5t0GxohE0rPjEwXKqPl8TpvnZ5b/NdGEdf3aKs7bkW5TU0yAA1oZ/XuJrP8rwuJhmpCSUlmuuJxRj7WUTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A3313D5;
	Tue, 11 Feb 2025 09:51:37 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C0D3F58B;
	Tue, 11 Feb 2025 09:51:14 -0800 (PST)
Message-ID: <8788e433-e1c7-4a00-ac0b-fb422b9bc7b2@arm.com>
Date: Tue, 11 Feb 2025 17:51:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] iommu: move the adding group info to proper place
To: Li RongQing <lirongqing@baidu.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, baolu.lu@linux.intel.com, vasant.hegde@amd.com
References: <20250107033558.41135-1-lirongqing@baidu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250107033558.41135-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-07 3:35 am, Li RongQing wrote:
> After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
> adding group information is left in iommu_group_alloc_device, but which
> only allocate group device, not attach the device to iommu group;
> 
> so move the print to iommu probing and adding functions

But why? In what way is it justifiably better to have duplicate copies 
of the same code when the fact is that the only parts of the 
iommu_group_add_device() operation which can fail *are* the ones inside 
iommu_group_alloc_device()?

> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: add log when iommu_group_alloc_device failed in iommu_group_add_device
> 
>   drivers/iommu/iommu.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 599030e..2eaa8ab 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -586,6 +586,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   	mutex_unlock(&group->mutex);
>   
> +	trace_add_device_to_group(group->id, dev);
> +	dev_info(dev, "Adding to iommu group %d\n", group->id);

If you want to argue semantics, this is now just as much in the wrong 
place as you claim the current error message to be: by this point we are 
no longer, as implied, about to add the device to the group, we've 
already finished doing that and potentially various other subsequent 
things too.

> +
>   	return 0;
>   
>   err_remove_gdev:
> @@ -594,6 +597,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   err_put_group:
>   	iommu_deinit_device(dev);
>   	mutex_unlock(&group->mutex);
> +	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);

This is inaccurate, because we can also get here for further error 
reasons after the device technically *was* successfully added to the 
group (in terms of the nominal iommu_group_add_device() operation within 
the wider "probe device" functionality here).

>   	iommu_group_put(group);
>   
>   	return ret;
> @@ -1192,10 +1196,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>   		goto err_free_name;
>   	}
>   
> -	trace_add_device_to_group(group->id, dev);
> -
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> -
>   	return device;
>   
>   err_free_name:
> @@ -1204,7 +1204,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>   	sysfs_remove_link(&dev->kobj, "iommu_group");
>   err_free_device:
>   	kfree(device);
> -	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
>   	return ERR_PTR(ret);
>   }
>   
> @@ -1219,10 +1218,14 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>   int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   {
>   	struct group_device *gdev;
> +	int ret;
>   
>   	gdev = iommu_group_alloc_device(group, dev);
> -	if (IS_ERR(gdev))
> -		return PTR_ERR(gdev);
> +	if (IS_ERR(gdev)) {
> +		ret = PTR_ERR(gdev);
> +		dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
> +		return ret;
> +	}
>   
>   	iommu_group_ref_get(group);
>   	dev->iommu_group = group;
> @@ -1230,6 +1233,10 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   	mutex_lock(&group->mutex);
>   	list_add_tail(&gdev->list, &group->devices);
>   	mutex_unlock(&group->mutex);
> +
> +	trace_add_device_to_group(group->id, dev);
> +	dev_info(dev, "Adding to iommu group %d\n", group->id);

Again, this one is now semantically wrong too.

Thanks,
Robin.

> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_add_device);

