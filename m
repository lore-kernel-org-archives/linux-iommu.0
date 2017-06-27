From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/dma: use __GFP_NOWARN only for high-order
	allocations
Date: Tue, 27 Jun 2017 12:05:22 +0100
Message-ID: <00da8d2c-d2e6-6462-d311-80ca4f515d24@arm.com>
References: <20170627072812.15316-1-tfiga@chromium.org>
	<20170627072812.15316-2-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170627072812.15316-2-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/06/17 08:28, Tomasz Figa wrote:
> Memory allocation routines are expected to report allocation errors to
> kernel log. However, current implementation of __iommu_dma_alloc_pages()
> adds __GFP_NOWARN for all calls to alloc_pages(), which completely
> disables any logging.
> 
> Fix it by adding __GFP_NOWARN only to high order allocation attempts,
> which are not critical.

Makes sense to me.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 29965a092a69..8507987eed90 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -433,6 +433,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  {
>  	struct page **pages;
>  	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	const gfp_t high_order_gfp = __GFP_NOWARN | __GFP_NORETRY;
>  
>  	order_mask &= (2U << MAX_ORDER) - 1;
>  	if (!order_mask)
> @@ -452,8 +453,6 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  	if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
>  		gfp |= __GFP_HIGHMEM;
>  
> -	gfp |= __GFP_NOWARN;
> -
>  	while (count) {
>  		struct page *page = NULL;
>  		unsigned int order_size;
> @@ -469,7 +468,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  
>  			order_size = 1U << order;
>  			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +					   gfp | high_order_gfp : gfp, order);
>  			if (!page)
>  				continue;
>  			if (!order)
> 
