From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
Date: Mon, 22 Oct 2018 11:41:48 +0200
Message-ID: <20181022094148.GA20099@lst.de>
References: <20181014181447.22783-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181014181447.22783-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Any comments?

On Sun, Oct 14, 2018 at 08:14:47PM +0200, Christoph Hellwig wrote:
> dma_alloc_from_contiguous can return highmem pages depending on the
> setup, which a plain non-remapping DMA allocator can't handle.  Detect
> this case and try the normal page allocator instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 87a6bc2a96c0..46fbaa49125b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -126,6 +126,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (gfpflags_allow_blocking(gfp)) {
>  		page = dma_alloc_from_contiguous(dev, count, page_order,
>  						 gfp & __GFP_NOWARN);
> +		if (page && PageHighMem(page)) {
> +			/*
> +			 * Depending on the cma= arguments and per-arch setup
> +			 * dma_alloc_from_contiguous could return highmem
> +			 * pages.  Without remapping there is no way to return
> +			 * them here, so log an error and fail.
> +			 */
> +			dev_info(dev, "Ignoring highmem page from CMA.\n");
> +			dma_release_from_contiguous(dev, page, count);
> +			page = NULL;
> +		}
> +
>  		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>  			dma_release_from_contiguous(dev, page, count);
>  			page = NULL;
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
