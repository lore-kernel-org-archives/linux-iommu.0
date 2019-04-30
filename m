From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Date: Tue, 30 Apr 2019 12:46:13 -0700
Message-ID: <20190430194612.GA31543@Asurada-Nvidia.nvidia.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
 <20190430015521.27734-2-nicoleotsuka@gmail.com>
 <20190430105640.GA20021@lst.de>
 <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
 <20190430151833.GB25447@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430151833.GB25447@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com, wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 30, 2019 at 05:18:33PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> > On 30/04/2019 11:56, Christoph Hellwig wrote:
> >> So while I really, really like this cleanup it turns out it isn't
> >> actually safe for arm :(  arm remaps the CMA allocation in place
> >> instead of using a new mapping, which can be done because they don't
> >> share PMDs with the kernel.
> >>
> >> So we'll probably need a __dma_alloc_from_contiguous version with
> >> an additional bool fallback argument - everyone but arms uses
> >> dma_alloc_from_contiguous as in your patch, just arm will get the
> >> non-fallback one.
> >
> > Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> > the existing APIs so that users can be thoroughly checked and converted 
> > one-by-one.
> 
> Yeah.  Actually given all the contention I wonder if the easiest solution
> for now is to just open code the cma_alloc/cma_free calls in dma-direct
> and dma-iommu, with the hopes that everyone is going to migrate to those
> implementations in the mid-term anyway and dma_alloc_from_contiguous /
> dma_release_from_contiguous just go away..

Thanks for the comments.

Listing all the solutions as a summary:
A) Add "bool fallback" to dma_{alloc,free}_contiguous, and let
   ARM use fallback=false.
B) Continue replacing "_from" with dma_{alloc,free}_contiguous
   but let callers like ARM use cma_alloc/free() directly.
C) Have both new dma_{alloc,free}_contiguous and "_from" funcs.
   Implement the new one to dma-direct only as an initial step
   and change others one-by-one in the future.

Combining the comments at alloc_pages_node(), I guess that the
Solution C would be a better (cleaner) one?

List of to-change callers for Solution C:
 kernel/dma/direct.c

List of to-exclude-for-now callers for Solution C:
 arch/arm64/mm/dma-mapping.c
 drivers/iommu/amd_iommu.c
 drivers/iommu/intel-iommu.c
 arch/arm/mm/dma-mapping.c
 arch/xtensa/kernel/pci-dma.c
 kernel/dma/remap.c
