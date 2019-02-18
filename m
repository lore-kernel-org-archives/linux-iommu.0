From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dma-contiguous: do not allocate a single page from CMA
	area
Date: Mon, 18 Feb 2019 14:51:54 +0100
Message-ID: <5dc1865b-ab20-aa45-1d00-b8d95655226f@samsung.com>
References: <CGME20190215200726epcas2p1f3da0044c08c5dae90eec3d73656c135@epcas2p1.samsung.com>
	<20190215200635.20733-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190215200635.20733-1-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Nicolin,

On 2019-02-15 21:06, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to always allocate one single page from CMA area.
> Since the CMA area has a limited predefined size of space, it may
> run out of space in heavy use cases, where there might be quite a
> lot CMA pages being allocated for single pages.
>
> However, there is also a concern that a device might care where a
> page comes from -- it might expect the page from CMA area and act
> differently if the page doesn't.
>
> This patch tries to skip of one-page size allocations and returns
> NULL so as to let callers allocate normal pages unless the device
> has its own CMA area. This would save resources from the CMA area
> for more CMA allocations. And it'd also reduce CMA fragmentations
> resulted from trivial allocations.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> ---
>  kernel/dma/contiguous.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..09074bd04793 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -186,16 +186,32 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   *
>   * This function allocates memory buffer for specified device. It uses
>   * device specific contiguous memory area if available or the default
> - * global one. Requires architecture specific dev_get_cma_area() helper
> - * function.
> + * global one.
> + *
> + * However, it skips one-page size of allocations from the global area.
> + * As the addresses within one page are always contiguous, so there is
> + * no need to waste CMA pages for that kind; it also helps reduce the
> + * fragmentations in the CMA area. So a caller should be the rebounder
> + * in such case to allocate a normal page upon NULL return value.
> + *
> + * Requires architecture specific dev_get_cma_area() helper function.
>   */
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  				       unsigned int align, bool no_warn)
>  {
> +	struct cma *cma;
> +
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > 1)
> +		cma = dma_contiguous_default_area;
> +	else
> +		return NULL;
> +
> +	return cma_alloc(cma, count, align, no_warn);
>  }
>  
>  /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
