Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F5366546
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832033; cv=none; b=bsWf/l5+sRVfFYaeXIFFOzb2e5lehMdeOJdZuXDAomwtKYDqx8Y7ssuR3+KwX7bsMb9nqTd7Gasu5dSO9/e4ZwmtNz9IyJBDLpg4REL18GRRBW03RGvIrsKFy2qqpNw6NVgDEQ7oWxJsCvPzNOVLFVfH8k80Fh+W/Kp8cjDxDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832033; c=relaxed/simple;
	bh=whUE7tyGahudxuTO2Xk5nyr97ZGzeVOey0P7olQS7gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qkjw3iLc7TDgFmJkyF2yEUkqzBnJxitAoHJIs3y2e3IBVXWipE26az+Le6XrsSkKr2VIuENceYsMurDAdZy9exSzsKu9B3bJLsDIxMSqu3626oM46E0P+Y3SHnv2HgpydX+VwNiI1uYhU1b3OG4Q/NixERVSzXj8aQULiBAiNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D487497;
	Mon, 19 Jan 2026 06:13:44 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A6A3F632;
	Mon, 19 Jan 2026 06:13:49 -0800 (PST)
Message-ID: <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
Date: Mon, 19 Jan 2026 14:13:43 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, joro@8bytes.org,
 will@kernel.org, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2026 5:49 am, Vishnu Reddy wrote:
> Drivers can create child devices dynamically. These child devices often
> inherit parent device tree node, including its reserved iommu-address
> ranges.

Which frankly sounds entirely wrong. If there are distinct devices with 
distinct hardware properties, then they should be properly described as 
such, and handled by a proper bus driver. And if different devices have 
different DMA restrictions, that should be described by "dma-ranges", 
not by abusing reserved regions.

Thanks,
Robin.

> While device tree can declare the multiple iommu-address ranges,
> they still apply uniformly to any child inheriting the parent OF node.
> 
> This creates a limitation when child requires a different iommu-address
> range than its parent, as device tree cannot express the reservation per
> child.
> 
> Example layout and use case:
> ----------------------------
> A multimedia subsystem with multiple child devices and distinct ranges:
> 
>      +-----------------------------------------------------------+
>      | Device A reserved region (256 MB)                         |
>      | 0x00000000 - 0x10000000                                   |
>      +-----------------------------------------------------------+
>      | Device B reserved region (512 MB)                         |
>      | 0x00000000 - 0x20000000                                   |
>      +-----------------------------------------------------------+
>      | Device C reserved region (600 MB)                         |
>      | 0x00000000 - 0x25800000                                   |
>      +-----------------------------------------------------------+
>      | Other reserved regions                                    |
>      +-----------------------------------------------------------+
> 
> If we add Device C's reserved range (0x0 to 0x025800000) into iommu
> address range into device tree and assign that OF node to Device B
> and C, it wastes memory:
> - Device A wastes ~344 MB
> - Device B wastes ~88 MB
> 
> To avoid this, drivers can use the introduced API to set their device
> specific IOVA region at runtime, ensuring the DMA mapping without
> unnecessary address space reservation.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/20251220023555.3017456-1-busanna.reddy@oss.qualcomm.com/
> ---
>   drivers/iommu/dma-iommu.c   | 44 +++++++++++++++++++++++++++++++++++++
>   include/linux/dma-mapping.h |  7 ++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index aeaf8fad985c3..baee119e1c277 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1743,6 +1743,50 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
>   	return SIZE_MAX;
>   }
>   
> +/**
> + * dma_iova_set_resv_region - Set a reserved region in the IOVA space
> + * @dev: Device to set the reserved region for
> + * @start: Start of the reserved region
> + * @length: Length of the reserved region
> + *
> + * This function enables drivers to set device specific reservations at
> + * runtime, which is particularly useful for dynamically created child
> + * devices that requires distinct IOVA ranges than parent.
> + *
> + * Returns:
> + *  0        - Success
> + *  -ENODEV  - No valid IOMMU DMA domain for the device
> + *  -EINVAL  - Invalid domain or cookie type for this operation
> + *  -ENOMEM  - Failed to reserve the requested range
> + */
> +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +			     unsigned long length)
> +{
> +	struct iommu_dma_cookie *cookie;
> +	struct iommu_domain *domain;
> +	struct iova_domain *iovad;
> +	unsigned long lo, hi;
> +
> +	domain = iommu_get_dma_domain(dev);
> +	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
> +		return -ENODEV;
> +
> +	cookie = domain->iova_cookie;
> +	if (!cookie || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
> +		return -EINVAL;
> +
> +	iovad = &cookie->iovad;
> +
> +	lo = iova_pfn(iovad, start);
> +	hi = iova_pfn(iovad, start + length - 1);
> +
> +	if (!reserve_iova(iovad, lo, hi))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_set_resv_region);
> +
>   /**
>    * dma_iova_try_alloc - Try to allocate an IOVA space
>    * @dev: Device to allocate the IOVA space for
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 29973baa05816..75b65160a37f3 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -347,6 +347,8 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
>   	return state->__size != 0;
>   }
>   
> +int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +			     unsigned long length);
>   bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
>   		phys_addr_t phys, size_t size);
>   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
> @@ -366,6 +368,11 @@ static inline bool dma_use_iova(struct dma_iova_state *state)
>   {
>   	return false;
>   }
> +static inline int dma_iova_set_resv_region(struct device *dev, unsigned long start,
> +					   unsigned long length)
> +{
> +	return -ENODEV;
> +}
>   static inline bool dma_iova_try_alloc(struct device *dev,
>   		struct dma_iova_state *state, phys_addr_t phys, size_t size)
>   {

