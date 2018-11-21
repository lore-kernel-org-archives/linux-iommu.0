From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Date: Wed, 21 Nov 2018 16:57:55 +0000
Message-ID: <20181121165755.GE24883@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
 <20181121160718.GB24883@arm.com>
 <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24be0d21-63b1-c88d-fdfd-42575f12634f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com, hch@lst.de, m.szyprowski@samsung.com, linuxarm@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 04:47:48PM +0000, John Garry wrote:
> On 21/11/2018 16:07, Will Deacon wrote:
> >On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
> >>From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >>
> >>Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> >>respective device NUMA node. The ternary operator which would be for
> >>alloc_pages_node() is tidied along with this.
> >>
> >>We also include a change to use kvzalloc() for kzalloc()/vzalloc()
> >>combination.
> >>
> >>Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >>[JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
> >>Signed-off-by: John Garry <john.garry@huawei.com>
> >
> >Weird, you're missing a diffstat here.
> >
> >Anyway, the patch looks fine to me, but it would be nice if you could
> >justify the change with some numbers. Do you actually see an improvement
> >from this change?
> >
> 
> Hi Will,
> 
> Ah, I missed adding my comments explaining the motivation. It would be
> better in the commit log. Anyway, here's the snippet:
> 
> " ... as mentioned in [3], dma_alloc_coherent() uses the locality
> information from the device - as in direct DMA - so this patch is just
> applying this same policy.
> 
> [3]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html"

Yes, please add to this to the commit log.

> I did have some numbers to show improvement in some scenarios when I tested
> this a while back which I'll dig out.
> 
> However I would say that some scenarios will improve and the opposite for
> others with this change, considering different conditions in which DMA
> memory may be used.

Well, if you can show that it's useful in some cases and not catastrophic in
others, then I think shooting for parity with direct DMA is a reasonable
justification for the change.

Will
