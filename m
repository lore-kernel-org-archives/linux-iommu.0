Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CEB193064
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621758; cv=none; b=g9ev6+yhasYcuMsdP4vsiSYwwTNE7L/gpzgGeeyt+fpKdxTEULKqHkhOcA8PR3ofCRZnFt0HvNik5b/+1hZ1hjWLXUAlKZMFvJV+Xg+Y6G8iwm4EkIjUGPAuq11LanLvVhP2hJQBRoZgLF7xlkwiSw37iUAsA5fADUxFxJoIBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621758; c=relaxed/simple;
	bh=f58et2nyreK+xJUisiVXOOdinhTznscj3Lig6FTrUJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tydfgI/aDWHyVqstlx5irGkUXXm9xwY4G9QwSRq9EdPkPb3X72mI5QW+8mh3GPEXTeY4kHOZpfb61q+dKFiVasUtMwHx1PzXpT31A/DwhHSc6F7c87jHxYJcCRLS7CTLF/azUCRFeRcXx3FPYKzvxlXvZK80i5+H7m7c/MS4pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D841682;
	Tue, 26 Nov 2024 03:49:39 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82D43F58B;
	Tue, 26 Nov 2024 03:49:08 -0800 (PST)
Message-ID: <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
Date: Tue, 26 Nov 2024 11:49:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Downgrade print level for iommu group information
To: Li RongQing <lirongqing@baidu.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev
References: <20241126072339.25714-1-lirongqing@baidu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241126072339.25714-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 7:23 am, Li RongQing wrote:
> This per device log is becoming longer with more and more PCI devices
> in system, which slows down the boot process due to the serializing
> nature of printk().
> 
> Downgrade dev_info() to dev_dbg() so it is still accessible for debug
> purposes.

Previously discussed 4 and a half years ago:

https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/

Also, given that the iommu_probe_device() path is inherently serialised 
anyway, if logging a message from there significantly slows down your 
boot process, how slow is your console device?

Thanks,
Robin.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e61..a16f944 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1193,7 +1193,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>   
>   	trace_add_device_to_group(group->id, dev);
>   
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> +	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
>   
>   	return device;
>   
