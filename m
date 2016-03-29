From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
	__iommu_dma_alloc_pages
Date: Tue, 29 Mar 2016 18:02:39 +0100
Message-ID: <20160329170238.GK6745@arm.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459146732-15620-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 28, 2016 at 02:32:11PM +0800, Yong Wu wrote:
> Currently __iommu_dma_alloc_pages assumes that all the IOMMU support
> the granule of PAGE_SIZE. It call alloc_page to try allocating memory
> in the last time. Fortunately the mininum pagesize in all the
> current IOMMU is SZ_4K, so this works well.
> 
> But there may be a case in which the mininum granule of IOMMU may be
> larger than PAGE_SIZE, then it will abort as the IOMMU cann't map the
> discontinuous memory within a granule. For example, the pgsize_bitmap
> of the IOMMU only has SZ_16K while the PAGE_SIZE is SZ_4K, then we
> have to prepare SZ_16K continuous memory at least for each a granule
> iommu mapping.

Did you find a driver/platform that actually needs this? I certainly
think it's possible, but we don't necessarily need to fix it if it's
not broken yet! Just adding a comment would be enough.

Either way, a couple of review comments inline.

> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> ---
> v2:
>  -rebase on v4.6-rc1.
>  -add a new patch([1/2] add pgsize_bitmap) here.
> 
>  drivers/iommu/dma-iommu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 72d6182..75ce71e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -190,11 +190,13 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>  	kvfree(pages);
>  }
>  
> -static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp,
> +					     unsigned long pgsize_bitmap)
>  {
>  	struct page **pages;
>  	unsigned int i = 0, array_size = count * sizeof(*pages);
> -	unsigned int order = MAX_ORDER;
> +	int min_order = get_order(1 << __ffs(pgsize_bitmap));

1UL

> +	int order = MAX_ORDER;
>  
>  	if (array_size <= PAGE_SIZE)
>  		pages = kzalloc(array_size, GFP_KERNEL);
> @@ -213,13 +215,16 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  		/*
>  		 * Higher-order allocations are a convenience rather
>  		 * than a necessity, hence using __GFP_NORETRY until
> -		 * falling back to single-page allocations.
> +		 * falling back to min size allocations.
>  		 */
> -		for (order = min_t(unsigned int, order, __fls(count));
> -		     order > 0; order--) {
> -			page = alloc_pages(gfp | __GFP_NORETRY, order);
> +		for (order = min_t(int, order, __fls(count));
> +		     order >= min_order; order--) {
> +			page = alloc_pages((order == min_order) ? gfp :
> +					   gfp | __GFP_NORETRY, order);
>  			if (!page)
>  				continue;
> +			if (!order)
> +				break;

Isn't this handled by the loop condition?

Will
