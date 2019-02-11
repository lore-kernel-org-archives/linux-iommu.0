From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/19] dma-iommu: don't depend on
 CONFIG_DMA_DIRECT_REMAP
Date: Mon, 11 Feb 2019 17:39:36 +0100
Message-ID: <20190211163936.GA29978@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-17-hch@lst.de> <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 06, 2019 at 11:55:49AM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> For entirely dma coherent architectures there is no good reason to ever
>> remap dma coherent allocation.
>
> Yes there is, namely assembling large buffers without the need for massive 
> CMA areas and compaction overhead under memory fragmentation. That has 
> always been a distinct concern from the DMA_DIRECT_REMAP cases; they've 
> just been able to share a fair few code paths.

Well, I guess I need to reword this - there is no _requirement_ to
remap.  And x86 has been happy to not remap so far and I see absolutely
no reason to force anyone to remap.

>>  Move all the remap and pool code under
>> CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.
>
> As far as I'm concerned that splits things the wrong way. Logically, 
> iommu_dma_alloc() should always have done its own vmap() instead of just 
> returning the bare pages array, but that was tricky to resolve with the 
> design of having the caller handle everything to do with coherency (forcing 
> the caller to unpick that mapping just to remap it yet again in the 
> noncoherent case didn't seem sensible).

I don't parse this.  In the old code base before this series
iommu_dma_alloc is a relatively low-level helper allocating and mapping
pages.  And that one should have done the remapping, and in fact does
so since ("dma-iommu: refactor page array remap helpers").  It just
happens that the function is now called iommu_dma_alloc_remap.

The new iommu_dma_alloc is the high level entry point that handles
every possible case of different allocations, including those where
we do not have a virtual mapping.
