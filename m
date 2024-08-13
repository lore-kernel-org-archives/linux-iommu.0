Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB16187348
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551798; cv=none; b=EepPE66yaZH7dr/+8P7IszyPc07tqDekLtQvMWtyb1KNFrH3LUS2+7IfXrApP1+hDVN2BqCHlrmAV6SWXKM7bCwYlHM1Qny3pmShPGqkX97eLZh6Bst6TvdSwGjn7NJ72MOdEZEv7Ouz7BrO2zcdKr5en3NobHhq66nu95q5OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551798; c=relaxed/simple;
	bh=0aF/53rygWBzDGX9kpGl449Fw0+7rQ6VE7MpYaZYMrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVH71DgHTkSqw7f3yXGaQGShn36hVyGRDebbqWAvofB2lc9XDxqpO9lDPk/uBXLeEXwbv7ouY3QkTsquT8meENuSaHezzBUFugKv56wboRTr0foonvOoWZd9OzzfY86ch176rPbGv6CSnr2tYIYqx1XvGpbqgKpYvK3qrOYR1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AD912FC;
	Tue, 13 Aug 2024 05:23:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A873F73B;
	Tue, 13 Aug 2024 05:23:12 -0700 (PDT)
Message-ID: <6304d2f3-4e35-46a7-a54d-eb39ba8f3094@arm.com>
Date: Tue, 13 Aug 2024 13:23:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dma: call unconditionally to unmap_page and
 unmap_sg callbacks
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1721818168.git.leon@kernel.org>
 <595d2716d252cac013a650bb3a94555ddb0d1d43.1721818168.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <595d2716d252cac013a650bb3a94555ddb0d1d43.1721818168.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2024 7:04 pm, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Almost all users of ->map_page()/map_sg() callbacks implement
> ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> is dummy DMA ops interface, and the use of this interface is to fail
> the operation and in such case, there won't be any call to
> ->unmap_page()/unmap_sg().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> This patch removes the existence checks of ->unmap_page()/unmap_sg()
> and calls to it directly to create symmetrical interface to
> ->map_page()/map_sg().
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>   kernel/dma/dummy.c   | 21 +++++++++++++++++++++
>   kernel/dma/mapping.c |  4 ++--
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
> index b492d59ac77e..92de80e5b057 100644
> --- a/kernel/dma/dummy.c
> +++ b/kernel/dma/dummy.c
> @@ -17,6 +17,15 @@ static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
>   {
>   	return DMA_MAPPING_ERROR;
>   }
> +static void dma_dummy_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	/*
> +	 * Dummy ops doesn't support map_page, so unmap_page should never be
> +	 * called.
> +	 */
> +	WARN_ON_ONCE(true);
> +}
>   
>   static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
>   		int nelems, enum dma_data_direction dir,
> @@ -25,6 +34,16 @@ static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
>   	return -EINVAL;
>   }
>   
> +static void dma_dummy_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nelems, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	/*
> +	 * Dummy ops doesn't support map_sg, so unmap_sg should never be called.
> +	 */
> +	WARN_ON_ONCE(true);
> +}
> +
>   static int dma_dummy_supported(struct device *hwdev, u64 mask)
>   {
>   	return 0;
> @@ -33,6 +52,8 @@ static int dma_dummy_supported(struct device *hwdev, u64 mask)
>   const struct dma_map_ops dma_dummy_ops = {
>   	.mmap                   = dma_dummy_mmap,
>   	.map_page               = dma_dummy_map_page,
> +	.unmap_page             = dma_dummy_unmap_page,
>   	.map_sg                 = dma_dummy_map_sg,
> +	.unmap_sg               = dma_dummy_unmap_sg,
>   	.dma_supported          = dma_dummy_supported,
>   };
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 81de84318ccc..6832fd6f0796 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,7 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_page_direct(dev, addr + size))
>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> -	else if (ops->unmap_page)
> +	else
>   		ops->unmap_page(dev, addr, size, dir, attrs);
>   	debug_dma_unmap_page(dev, addr, size, dir);
>   }
> @@ -291,7 +291,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_sg_direct(dev, sg, nents))
>   		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
> -	else if (ops->unmap_sg)
> +	else
>   		ops->unmap_sg(dev, sg, nents, dir, attrs);
>   }
>   EXPORT_SYMBOL(dma_unmap_sg_attrs);
