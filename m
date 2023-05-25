Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1819BDF
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 15:54:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9CDD75;
	Thu, 25 May 2023 08:54:49 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EDEE3F762;
	Thu, 25 May 2023 08:54:01 -0700 (PDT)
Message-ID: <ce1abf65-35cd-fd7a-5688-6a4168a821cc@arm.com>
Date: Thu, 25 May 2023 16:53:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 12/15] dma-mapping: Force bouncing if the kmalloc()
 size is not cache-line-aligned
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230524171904.3967031-13-catalin.marinas@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230524171904.3967031-13-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2023 6:19 pm, Catalin Marinas wrote:
> For direct DMA, if the size is small enough to have originated from a
> kmalloc() cache below ARCH_DMA_MINALIGN, check its alignment against
> dma_get_cache_alignment() and bounce if necessary. For larger sizes, it
> is the responsibility of the DMA API caller to ensure proper alignment.
> 
> At this point, the kmalloc() caches are properly aligned but this will
> change in a subsequent patch.
> 
> Architectures can opt in by selecting ARCH_WANT_KMALLOC_DMA_BOUNCE.

Thanks for the additional comment, that's a great summary for future 
reference.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>   include/linux/dma-map-ops.h | 61 +++++++++++++++++++++++++++++++++++++
>   kernel/dma/Kconfig          |  4 +++
>   kernel/dma/direct.h         |  3 +-
>   3 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 31f114f486c4..9bf19b5bf755 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/dma-mapping.h>
>   #include <linux/pgtable.h>
> +#include <linux/slab.h>
>   
>   struct cma;
>   
> @@ -277,6 +278,66 @@ static inline bool dev_is_dma_coherent(struct device *dev)
>   }
>   #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
>   
> +/*
> + * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
> + */
> +static inline bool dma_kmalloc_safe(struct device *dev,
> +				    enum dma_data_direction dir)
> +{
> +	/*
> +	 * If DMA bouncing of kmalloc() buffers is disabled, the kmalloc()
> +	 * caches have already been aligned to a DMA-safe size.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC))
> +		return true;
> +
> +	/*
> +	 * kmalloc() buffers are DMA-safe irrespective of size if the device
> +	 * is coherent or the direction is DMA_TO_DEVICE (non-desctructive
> +	 * cache maintenance and benign cache line evictions).
> +	 */
> +	if (dev_is_dma_coherent(dev) || dir == DMA_TO_DEVICE)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Check whether the given size, assuming it is for a kmalloc()'ed buffer, is
> + * sufficiently aligned for non-coherent DMA.
> + */
> +static inline bool dma_kmalloc_size_aligned(size_t size)
> +{
> +	/*
> +	 * Larger kmalloc() sizes are guaranteed to be aligned to
> +	 * ARCH_DMA_MINALIGN.
> +	 */
> +	if (size >= 2 * ARCH_DMA_MINALIGN ||
> +	    IS_ALIGNED(kmalloc_size_roundup(size), dma_get_cache_alignment()))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Check whether the given object size may have originated from a kmalloc()
> + * buffer with a slab alignment below the DMA-safe alignment and needs
> + * bouncing for non-coherent DMA. The pointer alignment is not considered and
> + * in-structure DMA-safe offsets are the responsibility of the caller. Such
> + * code should use the static ARCH_DMA_MINALIGN for compiler annotations.
> + *
> + * The heuristics can have false positives, bouncing unnecessarily, though the
> + * buffers would be small. False negatives are theoretically possible if, for
> + * example, multiple small kmalloc() buffers are coalesced into a larger
> + * buffer that passes the alignment check. There are no such known constructs
> + * in the kernel.
> + */
> +static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
> +					    enum dma_data_direction dir)
> +{
> +	return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(size);
> +}
> +
>   void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t gfp, unsigned long attrs);
>   void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index acc6f231259c..abea1823fe21 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -90,6 +90,10 @@ config SWIOTLB
>   	bool
>   	select NEED_DMA_MAP_STATE
>   
> +config DMA_BOUNCE_UNALIGNED_KMALLOC
> +	bool
> +	depends on SWIOTLB
> +
>   config DMA_RESTRICTED_POOL
>   	bool "DMA Restricted Pool"
>   	depends on OF && OF_RESERVED_MEM && SWIOTLB
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e38ffc5e6bdd..97ec892ea0b5 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -94,7 +94,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>   		return swiotlb_map(dev, phys, size, dir, attrs);
>   	}
>   
> -	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
>   		if (is_pci_p2pdma_page(page))
>   			return DMA_MAPPING_ERROR;
>   		if (is_swiotlb_active(dev))
