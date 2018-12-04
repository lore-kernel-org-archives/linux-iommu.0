From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Tue, 4 Dec 2018 17:38:12 +0000
Message-ID: <bba358b1-8117-dfbf-df8b-675e8bdbb90e@huawei.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
 <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
 <58fb3579-d101-db2b-c63a-609ddd651932@huawei.com>
 <eccb5b60-b831-c4bd-6c61-4867296e1232@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eccb5b60-b831-c4bd-6c61-4867296e1232@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
List-Id: iommu@lists.linux-foundation.org


>
>>> In fact, having got this far in, what I'd quite like to do is to get rid
>>> of dma_debug_resize_entries() such that we never need to free things at
>>> all, since then we could allocate whole pages as blocks of entries to
>>> save on masses of individual slab allocations.
>>>
>>
>> On a related topic, is it possible for the user to learn the total
>> entries created at a given point in time? If not, could we add a file
>> in the debugfs folder for this?
>

Hi Robin,

> I did get as far as pondering that you effectively lose track of
> utilisation once the low-water-mark of min_free_entries hits 0 and stays

I did try your patches and I noticed this, i.e I was hitting the point 
at which we start to alloc more entries.

> there - AFAICS it should be sufficient to just expose nr_total_entries
> as-is, since users can then calculate current and maximum occupancy
> based on *_free_entries. Does that sound reasonable to you?
>

Sounds ok. I am just interested to know roughly how many DMA buffers 
we're using in our system.

> That also indirectly reminds me that this lot is documented in
> DMA_API.txt, so I should be good and update that too...

Thanks,
John

>
> Cheers,
> Robin.
>
> .
>
