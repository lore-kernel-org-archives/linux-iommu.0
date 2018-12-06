From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Date: Thu, 6 Dec 2018 18:10:47 +0000
Message-ID: <9accc5fe-4aae-ff7d-a234-f27167c49614@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
 <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
 <20181206142326.GA24642@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206142326.GA24642@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 06/12/2018 14:23, Christoph Hellwig wrote:
>> +static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
>> +{
>> +	struct dma_debug_entry *entry, *next_entry;
>> +	LIST_HEAD(tmp);
>> +	int i;
>> +
>> +	for (i = 0; i < num_entries; ++i) {
>> +		entry = kzalloc(sizeof(*entry), gfp);
>> +		if (!entry)
>> +			goto out_err;
>> +
>> +		list_add_tail(&entry->list, &tmp);
>> +	}
>> +
>> +	list_splice(&tmp, &free_entries);
>> +	num_free_entries += num_entries;
>> +	nr_total_entries += num_entries;
> 
> The adding to a local list and splicing seems a bit pointless if we
> do it all under lock anyway.  Either we change the locking in
> dma_debug_resize_entries and your upcoming automatic allocation that
> we only do it over the splice and counter adjustment, which would
> have the advantage of allowing freeing of entries in parallel to these
> allocations, or we could just drop the local tmp list.

AFAICS the tmp list wasn't about locking as much as meaning that if 
kzalloc() failed at any point, we can free the partial allocation and 
back out without disturbing free_entries at all - that still makes sense 
to me up until patch #8 where we embrace the "never free anything" 
paradigm and rip out the final traces.

That said, maybe I should just drop the refactoring of 
dma_debug_resize_entries() now that I'm deleting it as part of the same 
series anyway - then I guess I squash what's left of this patch into #4 
and bring forward some of the simplification from #8 to start with. 
Would that be more agreeable?

Robin.
