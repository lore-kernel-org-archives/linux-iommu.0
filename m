Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3552CA6
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 16:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2E2C4339B;
	Fri, 26 May 2023 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685119667;
	bh=HztkGlGNg6aotOmvW2bUdXS74YXZP4CAN2DBXK9jDjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcLSeYsK32132xu+uotqzZvQoogKUiU5Xy8bJpIZ3CJf7hfuOzFpx6ttdfVpbOjlj
	 tEZ1V4imWO0kq6RUOfL5SpfVtFQR5FHROAdrqvnou63KhxQS8vnsTuDkD5CEvVnL5T
	 7DDgwcBuVvbqMYEKEG/kf9504v5kbZMT2Y6YlmX2P+tRKyjyfRpHBZQfaVfanXpi5X
	 kFnny0XgcKojxMZva4/Jl+HdXYsjdvgYwRQj5YtMksOMZUU7XucW9Vl7WeJmF/oIf7
	 bzEvKpdtOvAxLMvVAntV98IqeWBgSW1ysneSs2iTZjfO1XRKmHrM3LBV38lF0/bJgs
	 PVd0BWk96A93A==
Date: Sat, 27 May 2023 00:36:30 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
Message-ID: <ZHDgDrQL+WPDsxxh@xhacker>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230524171904.3967031-14-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524171904.3967031-14-catalin.marinas@arm.com>

On Wed, May 24, 2023 at 06:19:02PM +0100, Catalin Marinas wrote:
> Similarly to the direct DMA, bounce small allocations as they may have
> originated from a kmalloc() cache not safe for DMA. Unlike the direct
> DMA, iommu_dma_map_sg() cannot call iommu_dma_map_sg_swiotlb() for all
> non-coherent devices as this would break some cases where the iova is
> expected to be contiguous (dmabuf). Instead, scan the scatterlist for
> any small sizes and only go the swiotlb path if any element of the list
> needs bouncing (note that iommu_dma_map_page() would still only bounce
> those buffers which are not DMA-aligned).
> 
> To avoid scanning the scatterlist on the 'sync' operations, introduce an
> SG_DMA_USE_SWIOTLB flag set by iommu_dma_map_sg_swiotlb(). The
> dev_use_swiotlb() function together with the newly added
> dev_use_sg_swiotlb() now check for both untrusted devices and unaligned
> kmalloc() buffers (suggested by Robin Murphy).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/dma-iommu.c   | 50 ++++++++++++++++++++++++++++++-------
>  include/linux/scatterlist.h | 25 +++++++++++++++++--
>  3 files changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index db98c3f86e8c..670eff7a8e11 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -152,6 +152,7 @@ config IOMMU_DMA
>  	select IOMMU_IOVA
>  	select IRQ_MSI_IOMMU
>  	select NEED_SG_DMA_LENGTH
> +	select NEED_SG_DMA_FLAGS if SWIOTLB
>  
>  # Shared Virtual Addressing
>  config IOMMU_SVA
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..24a8b8c2368c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -520,9 +520,38 @@ static bool dev_is_untrusted(struct device *dev)
>  	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>  }
>  
> -static bool dev_use_swiotlb(struct device *dev)
> +static bool dev_use_swiotlb(struct device *dev, size_t size,
> +			    enum dma_data_direction dir)
>  {
> -	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +	return IS_ENABLED(CONFIG_SWIOTLB) &&
> +		(dev_is_untrusted(dev) ||
> +		 dma_kmalloc_needs_bounce(dev, size, dir));
> +}
> +
> +static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
> +			       int nents, enum dma_data_direction dir)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_SWIOTLB))
> +		return false;
> +
> +	if (dev_is_untrusted(dev))
> +		return true;
> +
> +	/*
> +	 * If kmalloc() buffers are not DMA-safe for this device and
> +	 * direction, check the individual lengths in the sg list. If any
> +	 * element is deemed unsafe, use the swiotlb for bouncing.
> +	 */
> +	if (!dma_kmalloc_safe(dev, dir)) {
> +		for_each_sg(sg, s, nents, i)
> +			if (!dma_kmalloc_size_aligned(s->length))
> +				return true;
> +	}
> +
> +	return false;
>  }
>  
>  /**
> @@ -922,7 +951,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  {
>  	phys_addr_t phys;
>  
> -	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>  		return;
>  
>  	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -938,7 +967,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>  {
>  	phys_addr_t phys;
>  
> -	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
>  		return;
>  
>  	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -956,7 +985,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	if (dev_use_swiotlb(dev))
> +	if (sg_is_dma_use_swiotlb(sgl))
>  		for_each_sg(sgl, sg, nelems, i)
>  			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>  						      sg->length, dir);
> @@ -972,7 +1001,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	if (dev_use_swiotlb(dev))
> +	if (sg_is_dma_use_swiotlb(sgl))
>  		for_each_sg(sgl, sg, nelems, i)
>  			iommu_dma_sync_single_for_device(dev,
>  							 sg_dma_address(sg),
> @@ -998,7 +1027,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  	 * If both the physical buffer start address and size are
>  	 * page aligned, we don't need to use a bounce page.
>  	 */
> -	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> +	if (dev_use_swiotlb(dev, size, dir) &&
> +	    iova_offset(iovad, phys | size)) {
>  		void *padding_start;
>  		size_t padding_size, aligned_size;
>  
> @@ -1166,6 +1196,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>  	struct scatterlist *s;
>  	int i;
>  
> +	sg_dma_mark_use_swiotlb(sg);
> +
>  	for_each_sg(sg, s, nents, i) {
>  		sg_dma_address(s) = iommu_dma_map_page(dev, sg_page(s),
>  				s->offset, s->length, dir, attrs);
> @@ -1210,7 +1242,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  			goto out;
>  	}
>  
> -	if (dev_use_swiotlb(dev))
> +	if (dev_use_sg_swiotlb(dev, sg, nents, dir))
>  		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>  
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> @@ -1315,7 +1347,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  	struct scatterlist *tmp;
>  	int i;
>  
> -	if (dev_use_swiotlb(dev)) {
> +	if (sg_is_dma_use_swiotlb(sg)) {
>  		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>  		return;
>  	}
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 87aaf8b5cdb4..330a157c5501 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>  	sg->page_link &= ~SG_END;
>  }
>  
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_USE_SWIOTLB	(1 << 1)
> +
> +#ifdef CONFIG_SWIOTLB

s/CONFIG_SWIOTLB/CONFIG_NEED_SG_DMA_FLAGS ?
Otherwise, there's compiler error if SWIOTLB=y but IOMMU=n

Thanks

> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> +{
> +	return sg->dma_flags & SG_DMA_USE_SWIOTLB;
> +}
> +
> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> +{
> +	sg->dma_flags |= SG_DMA_USE_SWIOTLB;
> +}
> +#else
> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> +{
> +	return false;
> +}
> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> +{
> +}
> +#endif
> +
>  /*
>   * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
>   * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
> @@ -256,8 +279,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   */
>  #ifdef CONFIG_PCI_P2PDMA
>  
> -#define SG_DMA_BUS_ADDRESS (1 << 0)
> -
>  /**
>   * sg_dma_is_bus address - Return whether a given segment was marked
>   *			   as a bus address
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
