From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Date: Tue, 20 Nov 2018 14:20:56 +0000
Message-ID: <f9a91b43-ae77-ced5-3afc-57366e5126cb@arm.com>
References: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com, hch@lst.de, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On 20/11/2018 13:42, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate memory/pages
> for DMA from respective device NUMA node.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG:  Modifed to use kvzalloc() and fixed indentation]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Difference v1->v2:
> - Add Ganapatrao's tag and change author
> 
> This patch was originally posted by Ganapatrao in [1].
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
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..ada00bc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>   	kvfree(pages);
>   }
>   
> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> -		unsigned long order_mask, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> +		unsigned int count, unsigned long order_mask, gfp_t gfp)
>   {
>   	struct page **pages;
> -	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	unsigned int i = 0, nid = dev_to_node(dev);
>   
>   	order_mask &= (2U << MAX_ORDER) - 1;
>   	if (!order_mask)
>   		return NULL;
>   
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);

The pages array is only accessed by the CPU servicing the 
iommu_dma_alloc() call, and is usually freed again before that call even 
returns. It's certainly never touched by the device, so forcing it to a 
potentially non-local node doesn't make a great deal of sense.

>   	if (!pages)
>   		return NULL;
>   
> @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>   			unsigned int order = __fls(order_mask);
>   
>   			order_size = 1U << order;
> -			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +			page = alloc_pages_node(nid,
> +						(order_mask - order_size) ?
> +						gfp | __GFP_NORETRY : gfp,
> +						order);

If we're touching this, can we sort out that horrendous ternary? FWIW I 
found I have a local version of the original patch which I tweaked at 
the time, and apparently I reworked this hunk as below, which does seem 
somewhat nicer for the same diffstat.

Robin.


@@ -446,10 +443,12 @@ static struct page 
**__iommu_dma_alloc_pages(unsigned int count,
                 for (order_mask &= (2U << __fls(count)) - 1;
                      order_mask; order_mask &= ~order_size) {
                         unsigned int order = __fls(order_mask);
+                       gfp_t alloc_flags = gfp;

                         order_size = 1U << order;
-                       page = alloc_pages((order_mask - order_size) ?
-                                          gfp | __GFP_NORETRY : gfp, 
order);
+                       if (order_size < order_mask)
+                               alloc_flags |= __GFP_NORETRY;
+                       page = alloc_pages_node(nid, alloc_flags, order);
                         if (!page)
                                 continue;
                         if (!order)
