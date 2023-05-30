Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C011DDD9
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 13:08:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96CC7AB6;
	Tue, 30 May 2023 06:02:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7A43F67D;
	Tue, 30 May 2023 06:01:35 -0700 (PDT)
Message-ID: <dcde9632-3ef9-dd59-1619-28ea2a0f9d89@arm.com>
Date: Tue, 30 May 2023 14:01:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
To: Catalin Marinas <catalin.marinas@arm.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
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
 <ZHDgDrQL+WPDsxxh@xhacker> <ZHEG5ghHMXcv1/WL@arm.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZHEG5ghHMXcv1/WL@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2023 8:22 pm, Catalin Marinas wrote:
> On Sat, May 27, 2023 at 12:36:30AM +0800, Jisheng Zhang wrote:
>> On Wed, May 24, 2023 at 06:19:02PM +0100, Catalin Marinas wrote:
>>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>>> index 87aaf8b5cdb4..330a157c5501 100644
>>> --- a/include/linux/scatterlist.h
>>> +++ b/include/linux/scatterlist.h
>>> @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
>>>   	sg->page_link &= ~SG_END;
>>>   }
>>>   
>>> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
>>> +#define SG_DMA_USE_SWIOTLB	(1 << 1)
>>> +
>>> +#ifdef CONFIG_SWIOTLB
>>
>> s/CONFIG_SWIOTLB/CONFIG_NEED_SG_DMA_FLAGS ?
>> Otherwise, there's compiler error if SWIOTLB=y but IOMMU=n
> 
> Yes, I pushed a fixup to the kmalloc-minalign branch.

I'd agree that CONFIG_NEED_SG_DMA_FLAGS is the better option.

>>> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
>>> +{
>>> +	return sg->dma_flags & SG_DMA_USE_SWIOTLB;
>>> +}
>>> +
>>> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
>>> +{
>>> +	sg->dma_flags |= SG_DMA_USE_SWIOTLB;
>>> +}
>>> +#else
>>> +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
>>> +{
>>> +	return false;
>>> +}
>>> +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
>>> +{
>>> +}
>>> +#endif
> 
> And I wonder whether we should keep these accessors in the scatterlist.h
> file. They are only used by the dma-iommu.c code.

Nah, logically they belong with the definition of the flag itself, which 
certainly should be here. Also once this does land, dma-direct and 
possibly others will be able to take advantage if it too (as a small win 
over repeating the is_swiotlb_buffer() check a lot).

Thanks,
Robin.
