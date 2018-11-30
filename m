From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Date: Fri, 30 Nov 2018 12:04:47 +0000
Message-ID: <19e7ac15-a1dc-33ee-d4be-f3433625e836@arm.com>
References: <20181130035456.1586-1-cai@gmx.us> <20181130084203.GA19812@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130084203.GA19812@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Qian Cai <cai@gmx.us>
Cc: m.szyprowski@samsung.com, yisen.zhuang@huawei.com, salil.mehta@huawei.com, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 30/11/2018 08:42, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>>   /* allow architectures to override this if absolutely required */
>>   #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>> +/* amount of DMA mappings on this driver is huge. */
>> +#ifdef	HNS_ENET
>> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
>> +#else
>>   #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>   #endif
>> +#endif
> 
> How would this be defined in a header that leaks into this file?

Apparently it wouldn't, because nothing defines that macro anywhere 
anyway. CONFIG_HNS_ENET, on the other hand, would be available by virtue 
of autoconf.h which is just about everywhere.

> I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
> selectable config options, as I really don't want to collect hacks like
> this.

Agreed - we already have per-arch overrides scattered about, so growing 
special cases in yet another place just makes even more of a mess. 
Rounding all of it up into Kconfig would definitely make sense.

Robin.
