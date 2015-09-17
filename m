From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] dma/swiotlb: Add helper for device driver to opt-out
	from swiotlb.
Date: Thu, 17 Sep 2015 15:31:58 -0400
Message-ID: <20150917193157.GC21496@x230.dumpdata.com>
References: <1442514158-30281-1-git-send-email-jglisse@redhat.com>
	<20150917190251.GE20952@x230.dumpdata.com>
	<20150917190746.GA6699@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150917190746.GA6699-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 17, 2015 at 03:07:47PM -0400, Jerome Glisse wrote:
> On Thu, Sep 17, 2015 at 03:02:51PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Thu, Sep 17, 2015 at 02:22:38PM -0400, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
> > > From: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > =

> > > The swiotlb dma backend is not appropriate for some devices like
> > > GPU where bounce buffer or slow dma page allocations is just not
> > > acceptable. With that helper device drivers can opt-out from the
> > > swiotlb and just do sane things without wasting CPU cycles inside
> > > the swiotlb code.
> > =

> > What if SWIOTLB is the only one available?
> =

> On x86 no_mmu is always available and we assume that device driver
> that would use this knows that their device can access all memory
> with no restriction or at very least use DMA32 gfp flag.

That runs afoul of the purpose of the DMA API. On x86 you may have
an IOMMU - GART, AMD Vi, Intel VT-d, Calgary, etc which will provide
you with the proper dma address. As the physical to bus address
topology does not have to be 1:1.
> =

> =

> > And what can't the devices use the TTM DMA backend which sets up
> > buffers which don't need bounce buffer or slow dma page allocations?
> =

> We want to get rid of this TTM code path for radeon and likely
> nouveau. This is the motivation for that patch. Benchmark shows
> that the TTM DMA backend is much much much slower (20% on some
> benchmark) that the regular page allocation and going through
> no_mmu.

You end up using the DMA API scatter gather API later on though.

I am also a bit confused on your use-case - when do you see this?
On regular desktop machines you will use the IOMMU API most of
the time because that hardware exists. The SWIOTLB should only
be used on hardware that is old, odd, or perhaps virtualized.

> =

> So this is all about allowing to directly allocate page through
> regular kernel page alloc code and not through specialize dma
> allocator.

.. What you are saying is that the intent of this patch is
to not use TTM DMA.

Are you using the SWIOTLB 99% of the time? 1%? Or is this
related to the unfortunate patch that enabled SWIOTLB all the time?
(If so, please please mention that in the commit, it didn't
occur to me until just now).

If that is the case we should attack the problem in a different
way - see if the IOMMU API is setup? Or is that set already
to some no_iommu option?

I think what you are looking for is a simple flag telling you
whether the IOMMU is there - in which case use the streaming
DMA API calls (dma_map_page, etc)?

> =

> Cheers,
> J=E9r=F4me
