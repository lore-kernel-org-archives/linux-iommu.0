Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C38F78
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 11:40:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8859F1FB;
	Tue,  8 Nov 2022 03:40:30 -0800 (PST)
Received: from [10.57.36.87] (unknown [10.57.36.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580213F534;
	Tue,  8 Nov 2022 03:40:21 -0800 (PST)
Message-ID: <d55e591a-d649-0504-f2a6-402b940d2556@arm.com>
Date: Tue, 8 Nov 2022 11:40:16 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not
 cacheline-aligned
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-4-catalin.marinas@arm.com>
 <20221107094603.GB6055@lst.de> <Y2jj7PlrIC6weDch@arm.com>
 <b7315166-1e2c-27f4-ab6a-b7a7eb41c079@arm.com> <Y2o0m2K4A1aOt+Rd@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y2o0m2K4A1aOt+Rd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-08 10:51, Catalin Marinas wrote:
> On Mon, Nov 07, 2022 at 01:26:21PM +0000, Robin Murphy wrote:
>> On 2022-11-07 10:54, Catalin Marinas wrote:
>>> On Mon, Nov 07, 2022 at 10:46:03AM +0100, Christoph Hellwig wrote:
>>>>> +static inline bool dma_sg_kmalloc_needs_bounce(struct device *dev,
>>>>> +					       struct scatterlist *sg, int nents,
>>>>> +					       enum dma_data_direction dir)
>>>>> +{
>>>>> +	struct scatterlist *s;
>>>>> +	int i;
>>>>> +
>>>>> +	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
>>>>> +	    dir == DMA_TO_DEVICE || dev_is_dma_coherent(dev))
>>>>> +		return false;
>>>>
>>>> This part should be shared with dma-direct in a well documented helper.
>>>>
>>>>> +	for_each_sg(sg, s, nents, i) {
>>>>> +		if (dma_kmalloc_needs_bounce(dev, s->length, dir))
>>>>> +			return true;
>>>>> +	}
>>>>
>>>> And for this loop iteration I'd much prefer it to be out of line, and
>>>> also not available in a global helper.
>>>>
>>>> But maybe someone can come up with a nice tweak to the dma-iommu
>>>> code to not require the extra sglist walk anyway.
>>>
>>> An idea: we could add another member to struct scatterlist to track the
>>> bounced address. We can then do the bouncing in a similar way to
>>> iommu_dma_map_sg_swiotlb() but without the iova allocation. The latter
>>> would be a common path for both the bounced and non-bounced cases.
>>
>> FWIW I spent a little time looking at this as well; I'm pretty confident
>> it can be done without the extra walk if the iommu-dma bouncing is
>> completely refactored (and it might want a SWIOTLB helper to retrieve
>> the original page from a bounced address).
> 
> Doesn't sg_page() provide the original page already? Either way, the
> swiotlb knows it as it needs to do the copying between buffers.

For the part where we temporarily rewrite the offsets and lengths to 
pass to iommu_map_sg(), we'd also have to swizzle any relevant page 
pointers so that that picks up the physical addresses of the bounce 
buffer slots rather than the original pages, but then we need to put 
them back straight afterwards. Since SWIOTLB keeps track of that 
internally, it'll be a lot neater and more efficient to simply ask for 
it than to allocate more temporary storage to remember it independently 
(like I did for that horrible erratum thing to keep it self-contained).

>> That's going to be a bigger
>> job than I'll be able to finish this cycle, and I concluded that this
>> in-between approach wouldn't be worth posting for its own sake, but as
>> part of this series I think it's a reasonable compromise.
> 
> I'll drop my hack once you have something. Happy to carry it as part of
> this series.

Cool, I can't promise how soon I'll get there, but like I said if all 
the other objections are worked out in the meantime I have no issue with 
landing this approach and improving on it later.

Thanks,
Robin.

>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index 375a5e90d86a..87aaf8b5cdb4 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -16,7 +16,7 @@ struct scatterlist {
>>   #ifdef CONFIG_NEED_SG_DMA_LENGTH
>>   	unsigned int	dma_length;
>>   #endif
>> -#ifdef CONFIG_PCI_P2PDMA
>> +#ifdef CONFIG_NEED_SG_DMA_FLAGS
>>   	unsigned int    dma_flags;
>>   #endif
> 
> I initially had something similar but I decided it's overkill for a
> patch that I expected to be NAK'ed.
> 
> I'll include your patch in my series in the meantime.
> 
