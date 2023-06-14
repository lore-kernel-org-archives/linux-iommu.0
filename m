Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284111C98
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 16:30:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40BE01FB;
	Wed, 14 Jun 2023 09:30:48 -0700 (PDT)
Received: from [10.57.85.233] (unknown [10.57.85.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 102F13F71E;
	Wed, 14 Jun 2023 09:30:02 -0700 (PDT)
Message-ID: <ef78b027-d6df-c8c5-5166-097dc23c1506@arm.com>
Date: Wed, 14 Jun 2023 17:29:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu: Fix missing check for return value of
 iommu_group_get()
Content-Language: en-GB
To: Chenyuan Mi <cymi20@fudan.edu.cn>, joro@8bytes.org
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230614154308.118783-1-cymi20@fudan.edu.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230614154308.118783-1-cymi20@fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-06-14 16:43, Chenyuan Mi wrote:
> The iommu_group_get() function may return NULL, which may
> cause null pointer deference, and most other callsites of
> iommu_group_get() do Null check. Add Null check for return
> value of iommu_group_get().
> 
> Found by our static analysis tool.

Static analysis is good at highlighting areas of code that might be 
worth looking at, but you then still need to actually look at the code 
and understand whether there's a problem or not...

> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> ---
>   drivers/iommu/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..ef3483e75511 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3217,6 +3217,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);

/**
  * iommu_group_release_dma_owner() - Release DMA ownership of a group
  * @dev: The device
  *
  * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
  */

If dev->iommu_group could have somehow disappeared since 
iommu_group_claim_dma_owner() succeeded then something has gone so 
catastrophically wrong that it's not worth even trying to reason about. 
Or if the caller is passing something here that isn't the same device, 
then why should we assume it's even a valid device pointer at all, and 
iommu_group_get() isn't going to crash or return nonzero garbage?

>   void iommu_device_release_dma_owner(struct device *dev)
>   {
>   	struct iommu_group *group = iommu_group_get(dev);
> +	if (!group)
> +		return;
>   
>   	mutex_lock(&group->mutex);
>   	if (group->owner_cnt > 1)
> @@ -3329,6 +3331,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			       ioasid_t pasid)

/*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
  * @dev: the attached device.
  * @pasid: the pasid of the device.
  *
  * The @domain must have been attached to @pasid of the @dev with
  * iommu_attach_device_pasid().
  */

Again, iommu_attach_device_pasid() already validates that the device has 
a group. If a caller uses the API incorrectly then all bets are off. 
Plus, look at the callsites of iommu_detach_device_pasid() - they're 
already holding their own reference to the same group anyway!

Thanks,
Robin.

>   {
>   	struct iommu_group *group = iommu_group_get(dev);
> +	if (!group)
> +		return;
>   
>   	mutex_lock(&group->mutex);
>   	__iommu_remove_group_pasid(group, pasid);
