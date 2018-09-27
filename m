From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask
 handling
Date: Thu, 27 Sep 2018 17:32:52 +0200
Message-ID: <20180927153252.GE10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-5-hch@lst.de> <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 27, 2018 at 03:58:04PM +0100, Robin Murphy wrote:
>>   }
>>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>   diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 3c404e33d946..64466b7ef67b 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>   			return false;
>>   		}
>>   -		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
>> +		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
>
> Hmm... say *dev->dma_mask is 31 bits and dev->bus_dma_mask is 40 bits due 
> to a global DT property, we'll now scream where we didn't before even 
> though the bus mask is almost certainly irrelevant - is that desirable?

This is just the reporting in the error case - we'll only hit this
IFF dma_capable already returned false.  But if you don't want a message
here we can probably drop this hunk.

>> @@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
>>   {
>>   	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>>   +	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
>> +		max_dma = dev->bus_dma_mask;
>
> Again, I think we could just do another min_not_zero() here. A device wired 
> to address only one single page of RAM isn't a realistic prospect (and we 
> could just flip the -1 and the shift in the max_dma calculation if we 
> *really* wanted to support such things).

This just seemed more readable to me than min_not_zero, but if others
prefer min_not_zero I can switch.
