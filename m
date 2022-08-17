Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E9187F
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 12:36:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3CE0113E;
	Wed, 17 Aug 2022 05:36:53 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDEAA3F67D;
	Wed, 17 Aug 2022 05:36:51 -0700 (PDT)
Message-ID: <eee1ce4c-dcc4-52f0-24d6-09d11b94b541@arm.com>
Date: Wed, 17 Aug 2022 13:36:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] dma-pool: don't return errors from
 dma_atomic_pool_init
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220817060647.1032426-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-08-17 07:06, Christoph Hellwig wrote:
> Returning errors from initcalls does not change a thing, thus don't
> bother with returning -ENOMEM if one of the pool allocations failed.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/pool.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 56f96678934bf..5b07b0379a501 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -195,8 +195,6 @@ static unsigned long calculate_pool_size(unsigned long zone_pages)
>   
>   static int __init dma_atomic_pool_init(void)
>   {
> -	int ret = 0;
> -
>   	/*
>   	 * If coherent_pool was not used on the command line, default the pool
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
> @@ -208,23 +206,17 @@ static int __init dma_atomic_pool_init(void)
>   
>   	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
>   						    GFP_KERNEL);
> -	if (!atomic_pool_kernel)
> -		ret = -ENOMEM;
>   	if (has_managed_dma()) {
>   		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
>   						GFP_KERNEL | GFP_DMA);
> -		if (!atomic_pool_dma)
> -			ret = -ENOMEM;
>   	}
>   	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
>   		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
>   						GFP_KERNEL | GFP_DMA32);
> -		if (!atomic_pool_dma32)
> -			ret = -ENOMEM;
>   	}
>   
>   	dma_atomic_pool_debugfs_init();
> -	return ret;
> +	return 0;
>   }
>   postcore_initcall(dma_atomic_pool_init);
>   
