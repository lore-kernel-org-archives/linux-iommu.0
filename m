From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Tue, 4 Dec 2018 15:17:43 +0100
Message-ID: <20181204141743.GA2618@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com> <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com> <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.garry@huawei.com>, hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 01:11:37PM +0000, Robin Murphy wrote:
> In fact, having got this far in, what I'd quite like to do is to get rid of 
> dma_debug_resize_entries() such that we never need to free things at all, 
> since then we could allocate whole pages as blocks of entries to save on 
> masses of individual slab allocations.

Yes, we should defintively kill dma_debug_resize_entries.  Allocating
page batches might sound nice, but is that going to introduce additional
complexity?
