Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEA7B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 09:42:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E76C1042;
	Thu, 16 Feb 2023 01:43:19 -0800 (PST)
Received: from [10.57.89.217] (unknown [10.57.89.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D05F3F703;
	Thu, 16 Feb 2023 01:42:35 -0800 (PST)
Message-ID: <d2d4510d-4d28-8471-626c-f3e998a4014c@arm.com>
Date: Thu, 16 Feb 2023 09:42:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] swiotlb: remove swiotlb_max_segment
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com
References: <20230216062553.2151773-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230216062553.2151773-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-02-16 06:25, Christoph Hellwig wrote:
> swiotlb_max_segment has always been a bogus API, so remove it now that
> the remaining callers are gone.

Hooray!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/swiotlb.h | 5 -----
>   kernel/dma/swiotlb.c    | 8 --------
>   2 files changed, 13 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 35bc4e281c2125..bcef10e20ea4fa 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -121,7 +121,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>   
>   void swiotlb_init(bool addressing_limited, unsigned int flags);
>   void __init swiotlb_exit(void);
> -unsigned int swiotlb_max_segment(void);
>   size_t swiotlb_max_mapping_size(struct device *dev);
>   bool is_swiotlb_active(struct device *dev);
>   void __init swiotlb_adjust_size(unsigned long size);
> @@ -140,10 +139,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>   static inline void swiotlb_exit(void)
>   {
>   }
> -static inline unsigned int swiotlb_max_segment(void)
> -{
> -	return 0;
> -}
>   static inline size_t swiotlb_max_mapping_size(struct device *dev)
>   {
>   	return SIZE_MAX;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index a34c38bbe28f10..f35d934f6e5822 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -156,14 +156,6 @@ setup_io_tlb_npages(char *str)
>   }
>   early_param("swiotlb", setup_io_tlb_npages);
>   
> -unsigned int swiotlb_max_segment(void)
> -{
> -	if (!io_tlb_default_mem.nslabs)
> -		return 0;
> -	return rounddown(io_tlb_default_mem.nslabs << IO_TLB_SHIFT, PAGE_SIZE);
> -}
> -EXPORT_SYMBOL_GPL(swiotlb_max_segment);
> -
>   unsigned long swiotlb_size_or_default(void)
>   {
>   	return default_nslabs << IO_TLB_SHIFT;
