From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Tue, 4 Dec 2018 16:06:43 +0000
Message-ID: <6e8ca917-32a7-5c0a-60c0-a266c3fbb163@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
 <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com> <20181204141743.GA2618@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204141743.GA2618@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 04/12/2018 14:17, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 01:11:37PM +0000, Robin Murphy wrote:
>> In fact, having got this far in, what I'd quite like to do is to get rid of
>> dma_debug_resize_entries() such that we never need to free things at all,
>> since then we could allocate whole pages as blocks of entries to save on
>> masses of individual slab allocations.
> 
> Yes, we should defintively kill dma_debug_resize_entries.  Allocating
> page batches might sound nice, but is that going to introduce additional
> complexity?

OK, looking at what the weird AMD GART code does I reckon it should be 
happy enough with on-demand expansion, and that no tears will be shed if 
it can no longer actually trim the pool to the size it thinks is 
necessary. I'll add a patch to clean that up.

Page-based allocation, at least the way I'm thinking of it, shouldn't do 
much more than add an extra loop in one place, which should be more than 
made up for by removing all the freeing code :)

Robin.
