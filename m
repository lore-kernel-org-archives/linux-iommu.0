From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Date: Mon, 11 Feb 2019 17:00:49 +0100
Message-ID: <20190211160049.GB27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-4-hch@lst.de> <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com> <20190201161638.GJ6532@lst.de> <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 06, 2019 at 03:28:28PM +0000, Robin Murphy wrote:
> Because if iommu_map() only gets called at PAGE_SIZE granularity, then the 
> IOMMU PTEs will be created at PAGE_SIZE (or smaller) granularity, so any 
> effort to get higher-order allocations matching larger IOMMU block sizes is 
> wasted, and we may as well have just done this:
>
> 	for (i = 0; i < count; i++) {
> 		struct page *page = alloc_page(gfp);
> 		...
> 		iommu_map(..., page_to_phys(page), PAGE_SIZE, ...);
> 	}

True.  I've dropped this patch.

> Really, it's a shame we have to split huge pages for the CPU remap, since 
> in the common case the CPU MMU will have a matching block size, but IIRC 
> there was something in vmap() or thereabouts that explicitly chokes on 
> them.

That just needs a volunteer to fix the implementation, as there is no
fundamental reason not to remap large pages.
