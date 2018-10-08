From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] dma-direct: document the zone selection logic
Date: Tue, 09 Oct 2018 09:56:28 +1100
Message-ID: <a0b5a36fa34c2707d829ff47fb7ebb3adf0d78b2.camel@kernel.crashing.org>
References: <20181001201016.32639-1-hch@lst.de>
         <20181001201016.32639-2-hch@lst.de> <20181008070327.GA3134@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008070327.GA3134@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-10-08 at 09:03 +0200, Christoph Hellwig wrote:
> Ben, does this resolve your issues with the confusing zone selection?

The comment does make things a tad clearer yes :)

Thanks !

Cheers,
Ben.

> On Mon, Oct 01, 2018 at 01:10:16PM -0700, Christoph Hellwig wrote:
> > What we are doing here isn't quite obvious, so add a comment explaining
> > it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  kernel/dma/direct.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index ba6f5956a291..14b966e2349a 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> >  	else
> >  		*phys_mask = dma_to_phys(dev, dma_mask);
> >  
> > -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> > +	/*
> > +	 * Optimistically try the zone that the physicall address mask falls
> > +	 * into first.  If that returns memory that isn't actually addressable
> > +	 * we will fallback to the next lower zone and try again.
> > +	 *
> > +	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
> > +	 * zones.
> > +	 */
> >  	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> >  		return GFP_DMA;
> >  	if (*phys_mask <= DMA_BIT_MASK(32))
> > -- 
> > 2.19.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> ---end quoted text---
