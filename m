From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Date: Tue, 9 Apr 2019 16:07:02 +0100
Message-ID: <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-8-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
[...]
> @@ -649,19 +696,44 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   	return iova + iova_off;
>   }
>   
> -dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, int prot)
>   {
>   	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
>   			iommu_get_dma_domain(dev));
>   }
>   
> -void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
>   }
>   
> +static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +	bool coherent = dev_is_dma_coherent(dev);
> +	dma_addr_t dma_handle;
> +
> +	dma_handle =__iommu_dma_map(dev, phys, size,
> +			dma_info_to_prot(dir, coherent, attrs),
> +			iommu_get_dma_domain(dev));
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +	    dma_handle != DMA_MAPPING_ERROR)
> +		arch_sync_dma_for_device(dev, phys, size, dir);
> +	return dma_handle;
> +}
> +
> +static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);

That wants to be iommu_get_dma_domain() there to minimise the overhead. 
In fact, I guess this could now be streamlined a bit in the style of 
iommu_dma_map_page() above - i.e. avoid doing a second domain lookup in 
the sync case - but that can happen later (if indeed you haven't already).

> +}
> +
>   /*
>    * Prepare a successfully-mapped scatterlist to give back to the caller.
>    *

[...]

> @@ -843,12 +923,257 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   			iommu_get_dma_domain(dev));
>   }
>   
> -void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
>   }
>   
> +static void *iommu_dma_alloc(struct device *dev, size_t size,
> +		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> +{
> +	bool coherent = dev_is_dma_coherent(dev);
> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> +	size_t iosize = size;
> +	void *addr;
> +
> +	size = PAGE_ALIGN(size);
> +
> +	/*
> +	 * Some drivers rely on this, and we probably don't want the
> +	 * possibility of stale kernel data being read by devices anyway.
> +	 */

That comment can probably be dropped now that zeroing is official API 
behaviour.

> +	gfp |= __GFP_ZERO;

[...]

> +/*
> + * The IOMMU core code allocates the default DMA domain, which the underlying
> + * IOMMU driver needs to support via the dma-iommu layer.
> + */
> +void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +		const struct iommu_ops *ops)

There's really no need to even pass @ops in here - in the existing arm64 
logic it's merely a token representing "should I do IOMMU setup?", and 
after this refactoring that's already been decided by our caller here.

> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	if (!domain || domain->type != IOMMU_DOMAIN_DMA)

This change means we now spam the logs with spurious warnings when 
configured for passthrough, which is not what we want.

> +		goto out_err;
> +	if (iommu_dma_init_domain(domain, dma_base, size, dev))
> +		goto out_err;
> +
> +	dev->dma_ops = &iommu_dma_ops;
> +	return;
> +out_err:
> +	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> +		 dev_name(dev));
> +}
> +
>   static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   		phys_addr_t msi_addr, struct iommu_domain *domain)
>   {
> @@ -921,3 +1246,5 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>   		msg->address_lo += lower_32_bits(msi_page->iova);
>   	}
>   }
> +
> +arch_initcall(iova_cache_get);

This feels a bit funky - TBH I'd rather just keep iommu_dma_init() 
around and make it static, if only for the sake of looking "normal".

[...]
> -static inline int iommu_dma_init(void)
> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
> +		u64 size, const struct iommu_ops *ops)
>   {
> -	return 0;
>   }

I don't think it makes sense to have a stub for that - AFAICS it should 
only ever be called form arch code with an inherent "select IOMMU_DMA" 
(much like the stuff which isn't stubbed currently).

Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for 
splitting things up.

Robin.

>   
>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
> 
