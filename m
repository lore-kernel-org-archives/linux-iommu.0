From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
	area
Date: Thu, 1 Nov 2018 14:07:55 +0000
Message-ID: <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181031200355.19945-1-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/10/2018 20:03, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to allocate one single page from CMA area. Since
> the CMA area has a limited predefined size of space, it might run
> out of space in some heavy use case, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> This patch tries to skip CMA allocations of single pages and lets
> them go through normal page allocations. This would save resource
> in the CMA area for further more CMA allocations.

In general, this seems to make sense to me. It does represent a 
theoretical change in behaviour for devices which have their own CMA 
area somewhere other than kernel memory, and only ever make non-atomic 
allocations, but I'm not sure whether that's a realistic or common 
enough case to really worry about.

Robin.

> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   kernel/dma/direct.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 22a12ab5a5e9..14c5d49eded2 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -120,8 +120,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   			&phys_mask);
>   again:
> -	/* CMA can be used only in the context which permits sleeping */
> -	if (gfpflags_allow_blocking(gfp)) {
> +	/*
> +	 * CMA can be used only in the context which permits sleeping.
> +	 * Since addresses within one PAGE are always contiguous, skip
> +	 * CMA allocation for a single page to save CMA reserved space
> +	 */
> +	if (gfpflags_allow_blocking(gfp) && count > 1) {
>   		page = dma_alloc_from_contiguous(dev, count, page_order,
>   						 gfp & __GFP_NOWARN);
>   		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> 
