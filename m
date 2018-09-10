From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Date: Mon, 10 Sep 2018 17:47:47 +0200
Message-ID: <20180910154747.GA23578@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 10, 2018 at 04:19:30PM +0100, Robin Murphy wrote:
>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>
> If we're likely to refer to it more than once, is it worth wrapping that 
> condition up in something like ARCH_HAS_NONCOHERENT_DMA?

The idea is that this is basically wrapped by dev_is_dma_coherent.
But independent of the field we have a few other uses, like the
definition of dev_is_dma_coherent itself.  It'll give the idea with
an additional symbol a spin.

>> index a0aa00cc909d..69630ec320be 100644
>> --- a/include/linux/dma-noncoherent.h
>> +++ b/include/linux/dma-noncoherent.h
>> @@ -4,6 +4,22 @@
>>     #include <linux/dma-mapping.h>
>>   +#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
>> +#include <asm/dma-coherence.h>
>> +#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>> +static inline int dev_is_dma_coherent(struct device *dev)
>
> Given that it's backed by a bool and used as a bool everywhere, this (and 
> its equivalents) should probably return a bool ;)

Indeed.

>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
>>   config ARCH_DMA_ADDR_T_64BIT
>>   	def_bool 64BIT || PHYS_ADDR_T_64BIT
>>   +config ARCH_HAS_DMA_COHERENCE_H
>> +	bool
>
> This seems a little crude - is it unbearably churny to make an 
> asm-generic/dma-coherence.h implementation for everyone else?

The case of having something else than the per-device flag is rather
odd, and I hope we don't grow any new user in addition to mips.

In fact I'm already thinking of ways to get rid of it for mips by
e.g. iterating over all devices and just setting dma_coherent,
but for now I wanted to solve the more urgen issues and tackle this
later, as this unification blocks a few other things

> Nits aside, this otherwise looks sane to me for factoring out the 
> equivalent Xen and arm64 DMA ops cases.

Like this? :)

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent
