Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EFA79E5
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 11:52:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673C6AB6;
	Fri,  9 Jun 2023 04:53:20 -0700 (PDT)
Received: from [10.57.85.120] (unknown [10.57.85.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB14A3F587;
	Fri,  9 Jun 2023 04:52:31 -0700 (PDT)
Message-ID: <5438a21b-fcd8-0175-1fdd-ce6afbf84d86@arm.com>
Date: Fri, 9 Jun 2023 12:52:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 15/17] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
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
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-16-catalin.marinas@arm.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230531154836.1366225-16-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-31 16:48, Catalin Marinas wrote:
[...]
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 2f06178996ba..69d87e312263 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -251,11 +251,13 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>   /*
>    * One 64-bit architectures there is a 4-byte padding in struct scatterlist
>    * (assuming also CONFIG_NEED_SG_DMA_LENGTH is set). Use this padding for DMA
> - * flags bits to indicate when a specific dma address is a bus address.
> + * flags bits to indicate when a specific dma address is a bus address or the
> + * buffer may have been bounced via SWIOTLB.
>    */
>   #ifdef CONFIG_NEED_SG_DMA_FLAGS
>   
> -#define SG_DMA_BUS_ADDRESS (1 << 0)
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_SWIOTLB		(1 << 1)
>   
>   /**
>    * sg_dma_is_bus_address - Return whether a given segment was marked
> @@ -298,6 +300,34 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>   	sg->dma_flags &= ~SG_DMA_BUS_ADDRESS;
>   }
>   
> +/**
> + * sg_dma_use_swiotlb - Return whether the scatterlist was marked for SWIOTLB
> + *			bouncing
> + * @sg:		SG entry
> + *
> + * Description:
> + *   Returns true if the scatterlist was marked for SWIOTLB bouncing. Not all
> + *   elements may have been bounced, so the caller would have to check
> + *   individual SG entries with is_swiotlb_buffer().
> + */
> +static inline bool sg_dma_use_swiotlb(struct scatterlist *sg)

Nit: since you tweaked the flag name again, we could happily go back to 
the pattern with s/use/is/ for this one now too.

> +{
> +	return sg->dma_flags & SG_DMA_SWIOTLB;
> +}
> +
> +/**
> + * sg_dma_use_swiotlb - Mark the scatterlist for SWIOTLB bouncing

Oops - s/use/mark/

Feel free to fix those up when applying if there's no other reason for a v7.

Thanks,
Robin.

> + * @sg:		SG entry
> + *
> + * Description:
> + *   Marks a a scatterlist for SWIOTLB bounce. Not all SG entries may be
> + *   bounced.
> + */
> +static inline void sg_dma_mark_swiotlb(struct scatterlist *sg)
> +{
> +	sg->dma_flags |= SG_DMA_SWIOTLB;
> +}
> +
>   #else
>   
>   static inline bool sg_dma_is_bus_address(struct scatterlist *sg)
> @@ -310,6 +340,13 @@ static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
>   static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>   {
>   }
> +static inline bool sg_dma_use_swiotlb(struct scatterlist *sg)
> +{
> +	return false;
> +}
> +static inline void sg_dma_mark_swiotlb(struct scatterlist *sg)
> +{
> +}
>   
>   #endif	/* CONFIG_NEED_SG_DMA_FLAGS */
>   
