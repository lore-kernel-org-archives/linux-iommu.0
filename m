Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C098C13
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 12:29:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B52C1FB;
	Fri, 19 May 2023 05:30:31 -0700 (PDT)
Received: from [10.57.84.114] (unknown [10.57.84.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20AFD3F762;
	Fri, 19 May 2023 05:29:42 -0700 (PDT)
Message-ID: <9dc3e036-75cd-debf-7093-177ef6c7a3ae@arm.com>
Date: Fri, 19 May 2023 13:29:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-14-catalin.marinas@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230518173403.1150549-14-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-18 18:34, Catalin Marinas wrote:
> Similarly to the direct DMA, bounce small allocations as they may have
> originated from a kmalloc() cache not safe for DMA. Unlike the direct
> DMA, iommu_dma_map_sg() cannot call iommu_dma_map_sg_swiotlb() for all
> non-coherent devices as this would break some cases where the iova is
> expected to be contiguous (dmabuf). Instead, scan the scatterlist for
> any small sizes and only go the swiotlb path if any element of the list
> needs bouncing (note that iommu_dma_map_page() would still only bounce
> those buffers which are not DMA-aligned).
> 
> To avoid scanning the scatterlist on the 'sync' operations, introduce a
> SG_DMA_BOUNCED flag set during the iommu_dma_map_sg() call (suggested by
> Robin Murphy).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c   | 25 ++++++++++++++++++++-----
>   include/linux/scatterlist.h | 25 +++++++++++++++++++++++--
>   2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7a9f0b0bddbd..ab1c1681c06e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -956,7 +956,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev))
> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>   						      sg->length, dir);
> @@ -972,7 +972,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev))
> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_device(dev,
>   							 sg_dma_address(sg),
> @@ -998,7 +998,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> +	if ((dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
>   		void *padding_start;
>   		size_t padding_size, aligned_size;
>   
> @@ -1210,7 +1211,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   			goto out;
>   	}
>   
> -	if (dev_use_swiotlb(dev))
> +	/*
> +	 * If kmalloc() buffers are not DMA-safe for this device and
> +	 * direction, check the individual lengths in the sg list. If one of
> +	 * the buffers is deemed unsafe, follow the iommu_dma_map_sg_swiotlb()
> +	 * path for potential bouncing.
> +	 */
> +	if (!dma_kmalloc_safe(dev, dir)) {
> +		for_each_sg(sg, s, nents, i)
> +			if (!dma_kmalloc_size_aligned(s->length)) {

Just to remind myself, we're not checking s->offset on the grounds that 
if anyone wants to DMA into an unaligned part of a larger allocation 
that remains at their own risk, is that right?

Do we care about the (probably theoretical) case where someone might 
build a scatterlist for multiple small allocations such that ones which 
happen to be adjacent might get combined into a single segment of 
apparently "safe" length but still at "unsafe" alignment?

> +				sg_dma_mark_bounced(sg);

I'd prefer to have iommu_dma_map_sg_swiotlb() mark the segments, since 
that's in charge of the actual bouncing. Then we can fold the alignment 
check into dev_use_swiotlb() (with the dev_is_untrusted() condition 
taking priority), and sync/unmap can simply rely on sg_is_dma_bounced() 
alone.

(ultimately I'd like to merge the two separate paths back together and 
handle bouncing per-segment, but that can wait)

Thanks,
Robin.

> +				break;
> +			}
> +	}
> +
> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> @@ -1315,7 +1330,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (dev_use_swiotlb(dev)) {
> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 87aaf8b5cdb4..9306880cae1c 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   	sg->page_link &= ~SG_END;
>   }
>   
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_BOUNCED		(1 << 1)
> +
> +#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
> +static inline bool sg_is_dma_bounced(struct scatterlist *sg)
> +{
> +	return sg->dma_flags & SG_DMA_BOUNCED;
> +}
> +
> +static inline void sg_dma_mark_bounced(struct scatterlist *sg)
> +{
> +	sg->dma_flags |= SG_DMA_BOUNCED;
> +}
> +#else
> +static inline bool sg_is_dma_bounced(struct scatterlist *sg)
> +{
> +	return false;
> +}
> +static inline void sg_dma_mark_bounced(struct scatterlist *sg)
> +{
> +}
> +#endif
> +
>   /*
>    * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
>    * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
> @@ -256,8 +279,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>    */
>   #ifdef CONFIG_PCI_P2PDMA
>   
> -#define SG_DMA_BUS_ADDRESS (1 << 0)
> -
>   /**
>    * sg_dma_is_bus address - Return whether a given segment was marked
>    *			   as a bus address
