Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89586AD51
	for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 20:57:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 752D3FEC;
	Wed, 14 Dec 2022 12:58:10 -0800 (PST)
Received: from [10.57.88.237] (unknown [10.57.88.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92533F71E;
	Wed, 14 Dec 2022 12:57:28 -0800 (PST)
Message-ID: <ce1b6720-b460-8e10-7885-31a8b6263908@arm.com>
Date: Wed, 14 Dec 2022 20:57:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dma-direct: Optimize get_required_mask
Content-Language: en-GB
To: Luben Tuikov <luben.tuikov@amd.com>, iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>, Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221214180025.163207-1-luben.tuikov@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221214180025.163207-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-12-14 18:00, Luben Tuikov wrote:
> Optimize dma_direct_get_required_mask(), in that we don't need to multiply by
> two if we don't subtract 1 from the exponent. That is,
> 
>      (1 << (n - 1)) * 2 - 1 <==>
>      2^(n-1) * 2^1 - 1       = (by rule of exponents)
>      2^n - 1                 <==>
>      (1 << n) - 1.

...except when n==64 (for the actual code below), in which case the 
result of the shift becomes undefined.

Robin.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: iommu@lists.linux.dev
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   kernel/dma/direct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 63859a101ed831..bb416a3949dac0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -41,7 +41,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
>   	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
>   	u64 max_dma = phys_to_dma_direct(dev, phys);
>   
> -	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
> +	return (1ULL << fls64(max_dma)) - 1;
>   }
>   
>   static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> 
> base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
