From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 01/20] kernel/dma/direct: take DMA offset into account
	in dma_direct_supported
Date: Thu, 23 Aug 2018 07:24:03 +0200
Message-ID: <20180823052403.GA14388@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-2-hch@lst.de>
	<74068e4d2135ecad8645048ed97b1114891ccace.camel@kernel.crashing.org>
	<20180822065359.GB19284@lst.de>
	<079a961eaf548644250719df83930d3d72e34cac.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <079a961eaf548644250719df83930d3d72e34cac.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 23, 2018 at 09:59:18AM +1000, Benjamin Herrenschmidt wrote:
> > Yeah, the other platforms that support these devices support ZONE_DMA
> > to reliably handle these devices. But there is two other ways the
> > current code would actually handle these fine despite the dma_direct
> > checks:
> > 
> >  1) if the device only has physical addresses up to 31-bit anyway
> >  2) by trying again to find a lower address.  But this only works
> >     for coherent allocations and not streaming maps (unless we have
> >     swiotlb with a buffer below 31-bits).
> > 
> > It seems powerpc can have ZONE_DMA, though and we will cover these
> > devices just fine.  If it didn't have that the current powerpc
> > code would not work either.
> 
> Not exactly. powerpc has ZONE_DMA covering all of system memory.
> 
> What happens in ppc32 is that we somewhat "know" that none of the
> systems with those stupid 31-bit limited pieces of HW is capable of
> having more than 2GB of memory anyway.
> 
> So we get away with just returning "1".

I think I can up with a proper way of handling that by checking
the actual amount of physical memory present instead of the hard coded
32-bit.

> > If your PCI bridge / PCIe root port doesn't support dma to addresses
> > larger than 32-bit the device capabilities above that don't matter, it
> > just won't work.  We have this case at least for some old VIA x86 chipsets
> > and some relatively modern Xilinx FPGAs with PCIe.
> 
> Hrm... that's the usual confusion dma_capable() vs. dma_set_mask().
> 
> It's always been perfectly fine for a driver to do a dma_set_mask(64-
> bit) on a system where the bridge can only do 32-bits ...

No, it hasn't.  That's why we have this pattern of trying a 64-bit
mask first and then setting a 32-bit mask if that fails all over
drivers/.  However with all the work we've done over the last month
we are getting really close to a world where:

 - the driver just does one dma_set_mask for the capabilities and
   stores that in the dma_mask
 - other limitations go elsewhere and will be automatically taken
   into account.

Which is I guess what you always wanted, but which wasn't how things
actually worked before.

> We shouldn't fail there, we should instead "clamp" the mask to 32-bit,
> see what I mean ? It doesn't matter that the device itself is capable
> of issuing >32 addresses, I agree, but what we need to express is that
> the combination device+bridge doesn't want addresses above 32-bit, so
> it's equivalent to making the device do a set_mask(32-bit).

As said, we'll get there (but with the new separate bus_dma_mask in 4.19),
but this is not how things currently work.

> > Your observation is right, but there always has been the implicit
> > assumption that architectures with more than 4GB of physical address
> > space must either support and iommu or swiotlb and use that.  It's
> > never been document anywhere, but I'm working on integrating all
> > this code to make more sense.
> 
> Well, iommus can have bypass regions, which we also use for
> performance, so we do at dma_set_mask() time "swap" the ops around, and
> in that case, we do want to check the mask against the actual top of
> memory...

That is a bit of a powerpc special case (we also had one other arch
doing that, but it got removed in the great purge, can't rember which
one right now).  Everyone else has one set of ops, and they just switch
to the direct mapping inside the iommu ops.
