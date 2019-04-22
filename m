From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
 allocated dma coherent mem
Date: Mon, 22 Apr 2019 20:11:00 +0200
Message-ID: <20190422181100.GB32490@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com
Cc: hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 22, 2019 at 07:51:25PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> If possible / available call into the DMA API to get a proper iommu
> mapping and a dma address for the newly allocated coherent dma memory.

I don't think this is so simple.  The original use case of
dma_declare_coherent_memory was memory that is local to a device, where
we copy in data through a MMIO mapping and the device can then access
it.  This use case still seems to be alive in the ohci-sm501 and
ohci-tmio drivers.  Going through the iommu in those cases would be
counter productive.

The other use cases, including the OF ones seem to be (and Marek who
added that support should correct me if I'm wrong) normal host DRAM
that is just set aside for the device.

So if we want to support these prealloc pools with an iommu we need to
split the use cases.  I have to say I really hate the way we do the DMA
"coherent" allocations, so I'm all in favor of that, it just hasn't
bubbled up towards the front of my todo list yet.

My highlevel plan here would be:

 a) move the two OHCI drivers away from our current DMA declare
    coherent code, and just use a trivial genalloc allocator for
    their MMIO space, given that the USB layer already wraps the
    dma_alloc/free APIs anyway
 b) move the rest of the DMA coherent stuff into the actual dma
    map ops, similar to how we handle CMA allocations.  In fact
    we should probably do this by a new page allocation helper
    that tries CMA, "coherent" or the page allocator as fallback
 b) also merge the OF-side handling of CMA vs "coherent" into a
    single implementation.  Preferably dropping the misleading
    "coherent" name while we are at it.
