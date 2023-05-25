Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21A419BDF
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 15:57:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003CAD75;
	Thu, 25 May 2023 08:58:42 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 729503F762;
	Thu, 25 May 2023 08:57:54 -0700 (PDT)
Message-ID: <df0dd2a4-34f5-3627-ce8c-7636974879ee@arm.com>
Date: Thu, 25 May 2023 16:57:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
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
 <20230524171904.3967031-14-catalin.marinas@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230524171904.3967031-14-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2023 6:19 pm, Catalin Marinas wrote:
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
[...]
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 87aaf8b5cdb4..330a157c5501 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   	sg->page_link &= ~SG_END;
>   }
>   
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_USE_SWIOTLB	(1 << 1)
> +
> +#ifdef CONFIG_SWIOTLB
> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)

Nit: can we decide whether this API is named sg_<verb>_<flag name> or 
sg_dma_<verb>_<flag suffix>? I'm leaning towards the latter, which would 
be consistent with the existing kerneldoc if not all the code (which I 
shall probably now send a patch to fix).

However, my internal grammar parser just cannot cope with the "is use" 
double-verb construct, so I would be inclined to collapse this 
particular one to "sg_dma_use_swiotlb" either way. Yes, it breaks the 
pattern, but that's what the English language does best :)

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I don't seem to have got round to giving this a spin on my Juno today, 
but will try to do so soon.

Cheers,
Robin.

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
