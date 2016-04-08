From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/dma: Finish optimising higher-order allocations
Date: Fri, 8 Apr 2016 13:32:48 +0800
Message-ID: <1460093568.18911.6.camel@mhfsdcap03>
References: <cover.1460048991.git.robin.murphy@arm.com>
	<89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2016-04-07 at 18:42 +0100, Robin Murphy wrote:
>  		/*
> @@ -215,8 +221,9 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  		 * than a necessity, hence using __GFP_NORETRY until
>  		 * falling back to single-page allocations.
>  		 */
> -		for (order = min_t(unsigned int, order, __fls(count));
> -		     order > 0; order--) {
> +		for (pgsize_orders &= (2U << __fls(count)) - 1;
> +		     (order = __fls(pgsize_orders)) > min_order;
> +		     pgsize_orders &= (1U << order) - 1) {
>  			page = alloc_pages(gfp | __GFP_NORETRY, order);
>  			if (!page)
>  				continue;
> @@ -230,7 +237,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  			}
>  		}
>  		if (!page)
> -			page = alloc_page(gfp);
> +			page = alloc_pages(gfp, order);

A small question: Do we need split it too if order != 0 here?


>  		if (!page) {
>  			__iommu_dma_free_pages(pages, i);
>  			return NULL;
[...]
