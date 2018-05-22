From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Make allocations NUMA-aware
Date: Tue, 22 May 2018 18:18:48 +0100
Message-ID: <20180522171848.GJ26955@arm.com>
References: <b420b4733b5bc939931c11ee573bbb598f72e7b0.1526989635.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b420b4733b5bc939931c11ee573bbb598f72e7b0.1526989635.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 22, 2018 at 12:50:09PM +0100, Robin Murphy wrote:
> We would generally expect pagetables to be read by the IOMMU more than
> written by the CPU, so in NUMA systems it makes sense to locate them
> close to the former and avoid cross-node pagetable walks if at all
> possible. As it turns out, we already have a handle on the IOMMU device
> for the sake of coherency management, so it's trivial to grab the
> appropriate NUMA node when allocating new pagetable pages.
> 
> Note that we drop the semantics of alloc_pages_exact(), but that's fine
> since they have never been necessary: the only time we're allocating
> more than one page is for stage 2 top-level concatenation, but since
> that is based on the number of IPA bits, the size is always some exact
> power of two anyway.
> 
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Retain equivalent highmem check
> 
>  drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Thanks, Robin.

Joerg -- please you can pick this up for 4.18? I don't have any other SMMU
patches pending, so it doesn't seem worth putting together a pull request
just for this.

Cheers,

Will

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 39c2a056da21..5194755bba29 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -231,12 +231,17 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>  				    struct io_pgtable_cfg *cfg)
>  {
>  	struct device *dev = cfg->iommu_dev;
> +	int order = get_order(size);
> +	struct page *p;
>  	dma_addr_t dma;
> -	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
> +	void *pages;
>  
> -	if (!pages)
> +	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> +	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
> +	if (!p)
>  		return NULL;
>  
> +	pages = page_address(p);
>  	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
>  		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>  		if (dma_mapping_error(dev, dma))
> @@ -256,7 +261,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>  	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
>  	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
>  out_free:
> -	free_pages_exact(pages, size);
> +	__free_pages(p, order);
>  	return NULL;
>  }
>  
> @@ -266,7 +271,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
>  	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
>  		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
>  				 size, DMA_TO_DEVICE);
> -	free_pages_exact(pages, size);
> +	free_pages((unsigned long)pages, get_order(size));
>  }
>  
>  static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
> -- 
> 2.17.0.dirty
> 
