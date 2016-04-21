From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Finish optimising higher-order allocations
Date: Thu, 21 Apr 2016 13:47:24 +0800
Message-ID: <1461217644.19705.10.camel@mhfsdcap03>
References: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
 <3e4572cb0a175061c1c4b436e3806ba9d7b9f199.1460563676.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <3e4572cb0a175061c1c4b436e3806ba9d7b9f199.1460563676.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2016-04-13 at 17:29 +0100, Robin Murphy wrote:
> Now that we know exactly which page sizes our caller wants to use in the
> given domain, we can restrict higher-order allocation attempts to just
> those sizes, if any, and avoid wasting any time or effort on other sizes
> which offer no benefit. In the same vein, this also lets us accommodate
> a minimum order greater than 0 for special cases.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Hi Robin,

    Thanks very much for this patch. It works well on our MT8173.

    Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> 

> ---
> 
> Just throwing this out as a quick solo update as I'm still expecting
> discussion on the rest of the series.
> 
[...]
>  	while (count) {
>  		struct page *page = NULL;
> -		int j;
> +		unsigned int order_size;
>  
>  		/*
>  		 * Higher-order allocations are a convenience rather
>  		 * than a necessity, hence using __GFP_NORETRY until
> -		 * falling back to single-page allocations.
> +		 * falling back to minimum-order allocations.
>  		 */
> -		for (order = min_t(unsigned int, order, __fls(count));
> -		     order > 0; order--) {
> -			page = alloc_pages(gfp | __GFP_NORETRY, order);
> +		for (order_mask &= (2U << __fls(count)) - 1;
> +		     order_mask; order_mask &= ~order_size) {
> +			unsigned int order = __fls(order_mask);
> +
> +			order_size = 1U << order;
> +			page = alloc_pages((order_mask - order_size) ?
> +					   gfp | __GFP_NORETRY : gfp, order);
>  			if (!page)
>  				continue;
> -			if (PageCompound(page)) {
> -				if (!split_huge_page(page))
> -					break;
> -				__free_pages(page, order);
> -			} else {
> +			if (!order)
> +				break;

I also added this "if" in my old code. I don't know much about
PageCompound and split_page, but from Will's suggestion[1], this "if" is
unnecessary.

[1]:http://lists.linuxfoundation.org/pipermail/iommu/2016-April/016422.html

> +			if (!PageCompound(page)) {
>  				split_page(page, order);
>  				break;
> +			} else if (!split_huge_page(page)) {
> +				break;
>  			}
> +			__free_pages(page, order);
>  		}
> -		if (!page)
> -			page = alloc_page(gfp);
>  		if (!page) {
>  			__iommu_dma_free_pages(pages, i);
>  			return NULL;
>  		}
> -		j = 1 << order;
> -		count -= j;
> -		while (j--)
> +		count -= order_size;
> +		while (order_size--)
>  			pages[i++] = page++;
>  	}
[...]
