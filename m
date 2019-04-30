From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Date: Tue, 30 Apr 2019 17:20:58 +0200
Message-ID: <20190430152058.GC25447@lst.de>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com> <20190430015521.27734-2-nicoleotsuka@gmail.com> <d43e1cfe-1d12-c0c6-d76b-81330918d9ab@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d43e1cfe-1d12-c0c6-d76b-81330918d9ab@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com, wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 30, 2019 at 01:52:26PM +0100, Robin Murphy wrote:
> As Catalin pointed out before, many of the users above may still have 
> implicit assumptions about the default CMA area, i.e. that this won't 
> return something above the limit they originally passed to 
> dma_contiguous_reserve(). I'm not sure how straightforward that is to 
> resolve - at the very least we may have to monkey around with GFP_DMA{32} 
> flags based on where dma_contiguous_default_area lies :(

Or just convert the callers one by one.  The two most interesting ones
are dma-direct which always check addressability after the allocation,
and dma-iommu, which doesn't care.  dma-iommu.c and intel-iommu.c also
don't care, but should use dma-iommu by next merge window anyway,
which leaves arm which is so complicated that we better don't touch
it for now, and xtensa, which I hope to switch to dma-direct in the
next merge window or two.
