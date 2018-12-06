From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/8] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Thu, 6 Dec 2018 18:31:25 +0000
Message-ID: <99a5f83b-8362-937e-9e50-116eedb7e593@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
 <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
 <20181206142423.GB24642@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206142423.GB24642@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: cai@gmx.us, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 06/12/2018 14:24, Christoph Hellwig wrote:
>> @@ -47,6 +47,8 @@
>>   #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>>   #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>   #endif
> 
> FYI, I think we should drop the potential arch hook with the ifndef
> here once we support the dynamic adjustment.

Sure - I have a vague feeling that thought did cross my mind at the 
time, but it didn't stick.

> 
>> +		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {
> 
> Overly long line.

Bah, I deliberately didn't bother wrapping this since it gets shorter 
again later, but now I realise it also slipped through the s/create/add/ 
rebase so it's just busted, and due to another last-minute fix I 
actually ended up with an even longer line elsewhere.

I'll tidy all of that up for a v3.

Robin.
