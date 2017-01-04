From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V8 6/9] arm/dma-mapping: Implement DMA_ATTR_PRIVILEGED
Date: Wed, 4 Jan 2017 18:05:57 +0000
Message-ID: <20170104180556.GP18193@arm.com>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
	<1483362764-11990-7-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483362764-11990-7-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 02, 2017 at 06:42:41PM +0530, Sricharan R wrote:
> The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
> are only accessible to privileged DMA engines.  Adding it to the
> arm dma-mapping.c so that the ARM32 DMA IOMMU mapper can make use of it.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  arch/arm/mm/dma-mapping.c | 60 +++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Russell: do you mind if I take this via the ARM SMMU tree (which goes
through Joerg's IOMMU tree)?

Will

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab77100..82d3e79 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1171,6 +1171,25 @@ static int __init dma_debug_do_init(void)
>  
>  #ifdef CONFIG_ARM_DMA_USE_IOMMU
>  
> +static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int prot = 0;
> +
> +	if (attrs & DMA_ATTR_PRIVILEGED)
> +		prot |= IOMMU_PRIV;
> +
> +	switch (dir) {
> +	case DMA_BIDIRECTIONAL:
> +		return prot | IOMMU_READ | IOMMU_WRITE;
> +	case DMA_TO_DEVICE:
> +		return prot | IOMMU_READ;
> +	case DMA_FROM_DEVICE:
> +		return prot | IOMMU_WRITE;
> +	default:
> +		return prot;
> +	}
> +}
> +
>  /* IOMMU */
>  
>  static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
> @@ -1394,7 +1413,8 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
>   * Create a mapping in device IO address space for specified pages
>   */
>  static dma_addr_t
> -__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
> +__iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
> +		       unsigned long attrs)
>  {
>  	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> @@ -1419,7 +1439,7 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
>  
>  		len = (j - i) << PAGE_SHIFT;
>  		ret = iommu_map(mapping->domain, iova, phys, len,
> -				IOMMU_READ|IOMMU_WRITE);
> +				__dma_info_to_prot(DMA_BIDIRECTIONAL, attrs));
>  		if (ret < 0)
>  			goto fail;
>  		iova += len;
> @@ -1476,7 +1496,8 @@ static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
>  }
>  
>  static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
> -				  dma_addr_t *handle, int coherent_flag)
> +				  dma_addr_t *handle, int coherent_flag,
> +				  unsigned long attrs)
>  {
>  	struct page *page;
>  	void *addr;
> @@ -1488,7 +1509,7 @@ static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
>  	if (!addr)
>  		return NULL;
>  
> -	*handle = __iommu_create_mapping(dev, &page, size);
> +	*handle = __iommu_create_mapping(dev, &page, size, attrs);
>  	if (*handle == DMA_ERROR_CODE)
>  		goto err_mapping;
>  
> @@ -1522,7 +1543,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
>  
>  	if (coherent_flag  == COHERENT || !gfpflags_allow_blocking(gfp))
>  		return __iommu_alloc_simple(dev, size, gfp, handle,
> -					    coherent_flag);
> +					    coherent_flag, attrs);
>  
>  	/*
>  	 * Following is a work-around (a.k.a. hack) to prevent pages
> @@ -1537,7 +1558,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
>  	if (!pages)
>  		return NULL;
>  
> -	*handle = __iommu_create_mapping(dev, pages, size);
> +	*handle = __iommu_create_mapping(dev, pages, size, attrs);
>  	if (*handle == DMA_ERROR_CODE)
>  		goto err_buffer;
>  
> @@ -1672,27 +1693,6 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>  					 GFP_KERNEL);
>  }
>  
> -static int __dma_direction_to_prot(enum dma_data_direction dir)
> -{
> -	int prot;
> -
> -	switch (dir) {
> -	case DMA_BIDIRECTIONAL:
> -		prot = IOMMU_READ | IOMMU_WRITE;
> -		break;
> -	case DMA_TO_DEVICE:
> -		prot = IOMMU_READ;
> -		break;
> -	case DMA_FROM_DEVICE:
> -		prot = IOMMU_WRITE;
> -		break;
> -	default:
> -		prot = 0;
> -	}
> -
> -	return prot;
> -}
> -
>  /*
>   * Map a part of the scatter-gather list into contiguous io address space
>   */
> @@ -1722,7 +1722,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>  		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>  			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
>  
> -		prot = __dma_direction_to_prot(dir);
> +		prot = __dma_info_to_prot(dir, attrs);
>  
>  		ret = iommu_map(mapping->domain, iova, phys, len, prot);
>  		if (ret < 0)
> @@ -1930,7 +1930,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
>  	if (dma_addr == DMA_ERROR_CODE)
>  		return dma_addr;
>  
> -	prot = __dma_direction_to_prot(dir);
> +	prot = __dma_info_to_prot(dir, attrs);
>  
>  	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
>  	if (ret < 0)
> @@ -2036,7 +2036,7 @@ static dma_addr_t arm_iommu_map_resource(struct device *dev,
>  	if (dma_addr == DMA_ERROR_CODE)
>  		return dma_addr;
>  
> -	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
> +	prot = __dma_info_to_prot(dir, attrs) | IOMMU_MMIO;
>  
>  	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
>  	if (ret < 0)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
