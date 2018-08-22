From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 02/20] kernel/dma/direct: refine dma_direct_alloc zone
	selection
Date: Wed, 22 Aug 2018 08:58:56 +0200
Message-ID: <20180822065856.GC19284@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-3-hch@lst.de>
	<7177553cdb5cd1b968f653a52d7e88bd71aae4d8.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7177553cdb5cd1b968f653a52d7e88bd71aae4d8.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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

On Thu, Aug 09, 2018 at 09:54:33AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> > We need to take the DMA offset and encryption bit into account when selecting
> > a zone.  Add a helper that takes those into account and use it.
> 
> That whole "encryption" stuff seems to be completely specific to the
> way x86 does memory encryption, or am I mistaken ? It's not clear to me
> what that does in practice and how it relates to DMA mappings.

Not even all of x86, but AMD in particular, Intel does it yet another
way.  But it still is easier to take this into the core with a few
overrides than duplicating all the code.

> I'm also not sure about that whole business with ZONE_DMA and
> ARCH_ZONE_DMA_BITS...

ZONE_DMA usually (but not always) maps to 24-bits of address space,
if it doesn't (I mostly through about s390 with it's odd 31-bits)
the architecture can override it if it cares).

> On ppc64, unless you enable swiotlb (which we only do currently on
> some embedded platforms), you have all of memory in ZONE_DMA.
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x0000001fffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000]   Device   empty

This is really weird.  Why would you wire up ZONE_DMA like this?
The general scheme that architectures should implement is:

ZONE_DMA:	Any memory below a magic threshold that is lower than
		32-bit.  Only enabled if actually required (usually
		either 24-bit for ISA, or some other weird architecture
		specific value like 32-bit for S/390)
ZONE_DMA32:	Memory <= 32-bit if the architecture supports more than
		32-bits worth of physical address space.  Should generally
		be enabled on all 64-bit architectures unless you have
		a very good reason not to.
ZONE_NORMAL:	Everything above 32-bit not falling into HIGHMEM or
		MOVEABLE.
