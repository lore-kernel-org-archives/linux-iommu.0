From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry pool
Date: Tue, 4 Dec 2018 16:32:03 +0000
Message-ID: <dae44ed0-6b84-0ed3-87c2-97940576709d@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
	<f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
	<20181204142938.GC2767@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181204142938.GC2767-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/12/2018 14:29, Christoph Hellwig wrote:
>> +	for (retry_count = 0; ; retry_count++) {
>> +		spin_lock_irqsave(&free_entries_lock, flags);
>> +
>> +		if (num_free_entries > 0)
>> +			break;
>>   
>>   		spin_unlock_irqrestore(&free_entries_lock, flags);
> 
> Taking a spinlock just to read a single integer value doesn't really
> help anything.

If the freelist is non-empty we break out with the lock still held in 
order to actually allocate our entry - only if there are no free entries 
left do we drop the lock in order to handle the failure. This much is 
just the original logic shuffled around a bit (with the tweak that 
testing num_free_entries seemed justifiably simpler than the original 
list_empty() check).

>> +
>> +		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
>> +		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
> 
> Don't we need GFP_ATOMIC here?  Also why do we need the retries?

Ah, right, we may be outside our own spinlock, but of course the whole 
DMA API call which got us here might be under someone else's and/or in a 
non-sleeping context - I'll fix that.

The number of retries is just to bound the loop due to its inherent 
raciness - since we drop the lock to create more entries, under 
pathological conditions by the time we get back in to grab one they 
could have all gone. 2 retries (well, strictly it's 1 try and 1 retry) 
was an entirely arbitrary choice just to accommodate that happening very 
occasionally by chance.

However, if the dynamic allocations need GFP_ATOMIC for external reasons 
anyway, then I don't need the lock-juggling that invites that race in 
the first place, and the whole loop disappears again. Neat!

Robin.
