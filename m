From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
Date: Fri, 18 Sep 2015 16:55:50 +0800
Message-ID: <1442566550.8145.156.camel@mhfsdcap03>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-09-17 at 17:42 +0100, Robin Murphy wrote:
> In checking whether DMA addresses differ from physical addresses, using
> dma_to_phys() is actually the wrong thing to do, since it may hide any
> DMA offset, which is precisely one of the things we are checking for.
> Simply casting between the two address types, whilst ugly, is in fact
> the appropriate course of action. Further care (and ugliness) is also
> necessary in the comparison to avoid truncation if phys_addr_t and
> dma_addr_t differ in size.
> 
> We can also reject any device with a fixed DMA offset up-front at page
> table creation, leaving the allocation-time check for the more subtle
> cases like bounce buffering due to an incorrect DMA mask.
> 
> Furthermore, we can then fix the hackish KConfig dependency so that
> architectures without a dma_to_phys() implementation may still
> COMPILE_TEST (or even use!) the code. The true dependency is on the
> DMA API, so use the appropriate symbol for that.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
[...]
>  
>  static bool selftest_running = false;
>  
> -static dma_addr_t __arm_lpae_dma_addr(struct device *dev, void *pages)
> +static dma_addr_t __arm_lpae_dma_addr(void *pages)
>  {
> -	return phys_to_dma(dev, virt_to_phys(pages));
> +	return (dma_addr_t)virt_to_phys(pages);
>  }
>  
>  static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> @@ -223,10 +223,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>  			goto out_free;
>  		/*
>  		 * We depend on the IOMMU being able to work with any physical
> -		 * address directly, so if the DMA layer suggests it can't by
> -		 * giving us back some translation, that bodes very badly...
> +		 * address directly, so if the DMA layer suggests otherwise by
> +		 * translating or truncating them, that bodes very badly...
>  		 */
> -		if (dma != __arm_lpae_dma_addr(dev, pages))
> +		if (dma != virt_to_phys(pages))

Could I ask why not use __arm_lpae_dma_addr(pages) here?
dma is dma_addr_t.

>  			goto out_unmap;
>  	}
>  
> @@ -243,10 +243,8 @@ out_free:
>  static void __arm_lpae_free_pages(void *pages, size_t size,
>  				  struct io_pgtable_cfg *cfg)
>  {
> -	struct device *dev = cfg->iommu_dev;
> -
>  	if (!selftest_running)
> -		dma_unmap_single(dev, __arm_lpae_dma_addr(dev, pages),
> +		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
>  				 size, DMA_TO_DEVICE);
>  	free_pages_exact(pages, size);
>  }
> @@ -254,12 +252,11 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
>  static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>  			       struct io_pgtable_cfg *cfg)
>  {
> -	struct device *dev = cfg->iommu_dev;
> -
>  	*ptep = pte;
>  
>  	if (!selftest_running)
> -		dma_sync_single_for_device(dev, __arm_lpae_dma_addr(dev, ptep),
> +		dma_sync_single_for_device(cfg->iommu_dev,
> +					   __arm_lpae_dma_addr(ptep),
>  					   sizeof(pte), DMA_TO_DEVICE);
>  }
>  
> @@ -629,6 +626,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
>  		return NULL;
>  
> +	if (cfg->iommu_dev->dma_pfn_offset) {
> +		dev_err(cfg->iommu_dev, "Cannot accommodate DMA offset for IOMMU page tables\n");
> +		return NULL;
> +	}
> +
>  	data = kmalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return NULL;
