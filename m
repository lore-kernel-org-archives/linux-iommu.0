Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361903A1D2
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004553; cv=none; b=fSvzkILkZJ9YCgRKjAfOgOR3r7XveTrYO+4f42i0QKv3NXkNScRsgPEWfzs/DpX7g3qyT8El2Jnyjb5Y/bFA4P0eUqzTJHuP9RE+dZceyLhOzMu6vts5kY+Vhs7X4FawJI+U8JcQ4M/Lvvltuq/421wZO/4+/xdhC+Aj2ivo4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004553; c=relaxed/simple;
	bh=jyrkAwsHquVNMj6V3U39Yxg1FlqYcxSpFBfPIrWLr6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3yGbN5WVMZk+NUCOq+pDA6qZfaKEjnc1kDtnrAIWcQ96z4mX7TOT3m9sbzRd8itB2vev1mGzRNl7e7sRhcEyGK6jINVDm8CH4aOUg38K5Vt7TnkBlZ5QrKxjy1R3jN4cNBvcCWA66DGlts5LJ13OXmXWG6dwZrXV53eZABDTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32F121477;
	Mon, 24 Nov 2025 09:15:44 -0800 (PST)
Received: from [10.1.30.67] (unknown [10.1.30.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E353F73B;
	Mon, 24 Nov 2025 09:15:49 -0800 (PST)
Message-ID: <0b214028-299b-46aa-8d98-0f789153c612@arm.com>
Date: Mon, 24 Nov 2025 17:15:48 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
 <20251124170955.3884351-1-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251124170955.3884351-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-24 5:09 pm, Marek Szyprowski wrote:
> Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
> dma_iova_link() code path, but missed that the CPU cache is being also
> touched in the dma_iova_unlink() path. Fix this.
> 
> Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/iommu/dma-iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e52d19d2e833..c92088855450 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2008,7 +2008,7 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>   			end - addr, iovad->granule - iova_start_pad);
>   
>   		if (!dev_is_dma_coherent(dev) &&
> -		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
>   			arch_sync_dma_for_cpu(phys, len, dir);
>   
>   		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
> @@ -2032,7 +2032,8 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>   	size_t unmapped;
>   
>   	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
> -	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
> +	    (!dev_is_dma_coherent(dev) &&
> +	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))

This isn't needed, since there's no way an MMIO mapping could have used 
SWIOTLB.

Thanks,
Robin.

>   		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
>   
>   	iommu_iotlb_gather_init(&iotlb_gather);

