From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
Date: Thu, 27 Sep 2018 15:49:54 +0200
Message-ID: <20180927134954.GB8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-6-hch@lst.de> <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 27, 2018 at 11:50:14AM +1000, Benjamin Herrenschmidt wrote:
> > -	 * to be able to satisfy them - either by not supporting more physical
> > -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -	 * architecture needs to use an IOMMU instead of the direct mapping.
> > -	 */
> > -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +	u64 min_mask;
> > +
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +	else
> > +		min_mask = min_t(u64, DMA_BIT_MASK(32),
> > +				 (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +	if (mask >= phys_to_dma(dev, min_mask))
> >  		return 0;
> 
> nitpick ... to be completely "correct", I would have written
> 
> 	if (IS_ENABLED(CONFIG_ZONE_DMA))
> 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> 	else
> 		min_mask = DMA_BIT_MASK(32);
> 
> 	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);
> 
> In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
> big enough to fit all memory :-)

Yeah, we could do that.
