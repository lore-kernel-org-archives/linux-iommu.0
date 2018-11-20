From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Date: Tue, 20 Nov 2018 09:57:36 +0000
Message-ID: <1e2b8689-dc1f-3ede-4eeb-4a91d3a3f63f@huawei.com>
References: <1541699709-25474-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541699709-25474-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, will.deacon@arm.com, ganapatrao.kulkarni@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 08/11/2018 17:55, John Garry wrote:
> Change function __iommu_dma_alloc_pages() to allocate memory/pages
> for DMA from respective device NUMA node.
>

Ping.... a friendly reminder on this patch.

Thanks

> Originally-from: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>
> This patch was originally posted by Ganapatrao in [1] *.
>
> However, after initial review, it was never reposted (due to lack of
> cycles, I think). In addition, the functionality in its sibling patches
> were merged through patches, as mentioned in [2]; this also refers to a
> discussion on device local allocations vs CPU local allocations for DMA
> pool, and which is better [3].
>
> However, as mentioned in [3], dma_alloc_coherent() uses the locality
> information from the device - as in direct DMA - so this patch is just
> applying this same policy.
>
> [1] https://lore.kernel.org/patchwork/patch/833004/
> [2] https://lkml.org/lkml/2018/8/22/391
> [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
>
> * Authorship on this updated patch may need to be fixed - I add not want to
>   add Ganapatrao's SOB without permission.
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..ada00bc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>  	kvfree(pages);
>  }
>
> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> -		unsigned long order_mask, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> +		unsigned int count, unsigned long order_mask, gfp_t gfp)
>  {
>  	struct page **pages;
> -	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	unsigned int i = 0, nid = dev_to_node(dev);
>
>  	order_mask &= (2U << MAX_ORDER) - 1;
>  	if (!order_mask)
>  		return NULL;
>
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);
>  	if (!pages)
>  		return NULL;
>
> @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  			unsigned int order = __fls(order_mask);
>
>  			order_size = 1U << order;
> -			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +			page = alloc_pages_node(nid,
> +						(order_mask - order_size) ?
> +						gfp | __GFP_NORETRY : gfp,
> +						order);
>  			if (!page)
>  				continue;
>  			if (!order)
> @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  		alloc_sizes = min_size;
>
>  	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> +	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> +					gfp);
>  	if (!pages)
>  		return NULL;
>
>
