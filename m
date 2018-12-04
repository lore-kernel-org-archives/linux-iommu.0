From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Tue, 4 Dec 2018 13:11:37 +0000
Message-ID: <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi John,

On 03/12/2018 18:23, John Garry wrote:
> On 03/12/2018 17:28, Robin Murphy wrote:
>> Certain drivers such as large multi-queue network adapters can use pools
>> of mapped DMA buffers larger than the default dma_debug_entry pool of
>> 65536 entries, with the result that merely probing such a device can
>> cause DMA debug to disable itself during boot unless explicitly given an
>> appropriate "dma_debug_entries=..." option.
>>
>> Developers trying to debug some other driver on such a system may not be
>> immediately aware of this, and at worst it can hide bugs if they fail to
>> realise that dma-debug has already disabled itself unexpectedly by the
>> time the code of interest gets to run. Even once they do realise, it can
>> be a bit of a pain to emprirically determine a suitable number of
>> preallocated entries to configure without massively over-allocating.
>>
>> There's really no need for such a static limit, though, since we can
>> quite easily expand the pool at runtime in those rare cases that the
>> preallocated entries are insufficient, which is arguably the least
>> surprising and most useful behaviour.
> 
> Hi Robin,
> 
> Do you have an idea on shrinking the pool again when the culprit driver 
> is removed, i.e. we have so many unused debug entries now available?

I honestly don't believe it's worth the complication. This is a 
development feature with significant overheads already, so there's not 
an awful lot to gain by trying to optimise memory usage. If a system can 
ever load a driver that makes hundreds of thousands of simultaneous 
mappings, it can almost certainly spare 20-odd megabytes of RAM for the 
corresponding debug entries in perpetuity. Sure, it does mean you'd need 
to reboot to recover memory from a major leak, but that's mostly true of 
the current behaviour too, and rebooting during driver development is 
hardly an unacceptable inconvenience.

In fact, having got this far in, what I'd quite like to do is to get rid 
of dma_debug_resize_entries() such that we never need to free things at 
all, since then we could allocate whole pages as blocks of entries to 
save on masses of individual slab allocations.

Robin.

> 
> Thanks,
> John
> 
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  kernel/dma/debug.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>> index de5db800dbfc..46cc075aec99 100644
>> --- a/kernel/dma/debug.c
>> +++ b/kernel/dma/debug.c
>> @@ -47,6 +47,9 @@
>>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>  #endif
>> +/* If the pool runs out, try this many times to allocate this many 
>> new entries */
>> +#define DMA_DEBUG_DYNAMIC_ENTRIES 256
>> +#define DMA_DEBUG_DYNAMIC_RETRIES 2
>>
>>  enum {
>>      dma_debug_single,
>> @@ -702,12 +705,21 @@ static struct dma_debug_entry 
>> *dma_entry_alloc(void)
>>  {
>>      struct dma_debug_entry *entry;
>>      unsigned long flags;
>> +    int retry_count;
>>
>> -    spin_lock_irqsave(&free_entries_lock, flags);
>> +    for (retry_count = 0; ; retry_count++) {
>> +        spin_lock_irqsave(&free_entries_lock, flags);
>> +
>> +        if (num_free_entries > 0)
>> +            break;
>>
>> -    if (list_empty(&free_entries)) {
>> -        global_disable = true;
>>          spin_unlock_irqrestore(&free_entries_lock, flags);
>> +
>> +        if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
>> +            !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
>> +            continue;
>> +
>> +        global_disable = true;
>>          pr_err("debugging out of memory - disabling\n");
>>          return NULL;
>>      }
>>
> 
> 
