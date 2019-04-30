From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Date: Tue, 30 Apr 2019 16:24:21 +0100
Message-ID: <20190430152421.GE29799@arrakis.emea.arm.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
 <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
 <20190424192652.GA29032@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424192652.GA29032@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

(catching up on email)

On Wed, Apr 24, 2019 at 09:26:52PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 11:33:11AM -0700, Nicolin Chen wrote:
> > I feel it's similar to my previous set, which did most of these
> > internally except the renaming part. But Catalin had a concern
> > that some platforms might have limits on CMA range [1]. Will it
> > be still okay to do the fallback internally?
> > 
> > [1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]
> 
> Catalins statement is correct, but I don't see how it applies to
> your patch.  Your patch just ensures that the fallback we have
> in most callers is uniformly applied everywhere.  The non-iommu
> callers will still need to select a specific zone and/or retry
> just the page allocator with other flags if the CMA (or fallback)
> page doesn't match what they need.  dma-direct does this correctly
> and I think the arm32 allocator does as well, although it is a bit
> hard to follow sometimes.

My reading of the arm32 __dma_alloc() is that if the conditions are
right for the CMA allocator (allows blocking) and there is a default CMA
area or a per-device one, the call ends up in cma_alloc() without any
fallback if such allocation fails. Whether this is on purpose, I'm not
entirely sure. There are a couple of arm32 SoCs which call
dma_declare_contiguous() or dma_contiguous_reserve_area() and a few DT
files describing a specific CMA range (e.g. arch/arm/boot/dts/sun5i.dtsi
with a comment that address must be kept in the lower 256MB).

If ZONE_DMA is set up correctly so that cma_alloc() is (or can be made)
interchangeable with alloc_pages(GFP_DMA) from a device DMA capability
perspective , I think it should be fine to have such fallback.

-- 
Catalin
