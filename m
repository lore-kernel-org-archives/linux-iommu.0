Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D247A62
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919606; cv=none; b=TVbspeU9essACMNKOOWaHwNMZ658dr+vPBUPHW4piniNv+RkZhn979LtJ30tWFxs54ZMiG/uz0PBtsg2JkfP8k6ZTfF2xA/Hm6oDxsXAOlWD9+dEFk3csFMbtu8oscrFKRbggtG8or4yi1v19o2D0SE/DRtFR2wPrjnZSUvFdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919606; c=relaxed/simple;
	bh=CxyqhUNxo9DwkSJWHmRrgHASYmSuXzwyk0PhJuOQtsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxsRj50C7PCRWdE9fPFBEdVf9tdvZpX1NUEuHBmCLyaBqtL8thN2o0zR8trEwcBnXFo9DW+KQ2gc7Kf63dpcp81ay/jpe9fYuxscCppMxmwu36owevfoSFn4VZswHUwfQ3kBHwhyIWOBHN8qpstSH8BaQQu7qOzCcKcDYbj3RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D585339;
	Tue, 28 May 2024 11:07:06 -0700 (PDT)
Received: from [10.57.39.137] (unknown [10.57.39.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 395343F641;
	Tue, 28 May 2024 11:06:41 -0700 (PDT)
Message-ID: <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
Date: Tue, 28 May 2024 19:06:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Lianbo Jiang <lijiang@redhat.com>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240528163940.48789-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-28 5:39 pm, Vasant Hegde wrote:
> Commit 3ab657291638 ("iommu: use the __iommu_attach_device() directly for deferred attach")
> replaced iommu_attach_device() call with __iommu_attach_device(). But
> missed to take group lock. Take lock before attaching device to domain.

Why? Nothing here is even touching the group. If we've reached a 
deferred attach then we know the domain is the default domain already 
initialised and set as the current of the device's group, and the device 
is already otherwise added and holding a reference to that group, and a 
driver is bound to the device in order to make the DMA API call we're 
inside, so nothing should be at risk of disappearing under our feet. 
Please clarify what purpose this locking actually serves.

But then there's also the fact that the initial DMA mapping operation 
which triggers deferred attach could legitimately be called under a 
spinlock or in an IRQ handler, so if anything it was a bug in 
795bbbb9b6f8 ("iommu/dma-iommu: Handle deferred devices") to ever use 
iommu_attach_device() (and thus involve the mutex) in the first place :/

Thanks,
Robin.

> Fixes: 3ab657291638 ("iommu: use the __iommu_attach_device() directly for deferred attach")
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9df7cc75c1bc..1743dba023b6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2114,10 +2114,19 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> -	if (dev->iommu && dev->iommu->attach_deferred)
> -		return __iommu_attach_device(domain, dev);
> +	int ret = 0;
> +	struct iommu_group *group = dev->iommu_group;
>   
> -	return 0;
> +	if (!group)
> +		return -EINVAL;
> +
> +	if (dev->iommu && dev->iommu->attach_deferred) {
> +		mutex_lock(&group->mutex);
> +		ret = __iommu_attach_device(domain, dev);
> +		mutex_unlock(&group->mutex);
> +	}
> +
> +	return ret;
>   }
>   
>   void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
