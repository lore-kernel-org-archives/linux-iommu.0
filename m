Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05B1C08
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 10:06:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4333F2F4;
	Wed, 30 Aug 2023 02:57:34 -0700 (PDT)
Received: from [10.57.4.99] (unknown [10.57.4.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC923F64C;
	Wed, 30 Aug 2023 02:56:53 -0700 (PDT)
Message-ID: <91635325-ccd4-c846-7d14-c3b6dce598d4@arm.com>
Date: Wed, 30 Aug 2023 10:56:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dma-pool: remove a __maybe_unused label in
 atomic_pool_expand
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
Cc: hchunhui@mail.ustc.edu.cn, iommu@lists.linux.dev
References: <20230830092804.148776-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230830092804.148776-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-30 10:28, Christoph Hellwig wrote:
> Move the #endif a line so that free_page label is only seen by the
> compile pass when actually used.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/pool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 1acec2e228273f..b481c48a31a630 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -135,9 +135,9 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   remove_mapping:
>   #ifdef CONFIG_DMA_DIRECT_REMAP
>   	dma_common_free_remap(addr, pool_size);
> -#endif
> -free_page: __maybe_unused
> +free_page:
>   	__free_pages(page, order);
> +#endif
>   out:
>   	return ret;
>   }
