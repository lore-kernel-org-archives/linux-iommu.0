From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [RFC PATCH] dma/swiotlb: Add helper for device driver to opt-out
 from swiotlb.
Date: Tue, 22 Sep 2015 11:43:19 -0400
Message-ID: <20150922154317.GA3189@gmail.com>
References: <1442514158-30281-1-git-send-email-jglisse@redhat.com>
 <20150917190251.GE20952@x230.dumpdata.com>
 <20150917190746.GA6699@redhat.com>
 <20150917193157.GC21496@x230.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917193157.GC21496@x230.dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 17, 2015 at 03:31:58PM -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Sep 17, 2015 at 03:07:47PM -0400, Jerome Glisse wrote:
> > On Thu, Sep 17, 2015 at 03:02:51PM -0400, Konrad Rzeszutek Wilk wro=
te:
> > > On Thu, Sep 17, 2015 at 02:22:38PM -0400, jglisse@redhat.com wrot=
e:
> > > > From: J=E9r=F4me Glisse <jglisse@redhat.com>
> > > >=20
> > > > The swiotlb dma backend is not appropriate for some devices lik=
e
> > > > GPU where bounce buffer or slow dma page allocations is just no=
t
> > > > acceptable. With that helper device drivers can opt-out from th=
e
> > > > swiotlb and just do sane things without wasting CPU cycles insi=
de
> > > > the swiotlb code.
> > >=20
> > > What if SWIOTLB is the only one available?
> >=20
> > On x86 no_mmu is always available and we assume that device driver
> > that would use this knows that their device can access all memory
> > with no restriction or at very least use DMA32 gfp flag.
>=20
> That runs afoul of the purpose of the DMA API. On x86 you may have
> an IOMMU - GART, AMD Vi, Intel VT-d, Calgary, etc which will provide
> you with the proper dma address. As the physical to bus address
> topology does not have to be 1:1.
> >=20
> >=20
> > > And what can't the devices use the TTM DMA backend which sets up
> > > buffers which don't need bounce buffer or slow dma page allocatio=
ns?
> >=20
> > We want to get rid of this TTM code path for radeon and likely
> > nouveau. This is the motivation for that patch. Benchmark shows
> > that the TTM DMA backend is much much much slower (20% on some
> > benchmark) that the regular page allocation and going through
> > no_mmu.
>=20
> You end up using the DMA API scatter gather API later on though.
>=20
> I am also a bit confused on your use-case - when do you see this?
> On regular desktop machines you will use the IOMMU API most of
> the time because that hardware exists. The SWIOTLB should only
> be used on hardware that is old, odd, or perhaps virtualized.
>=20
> >=20
> > So this is all about allowing to directly allocate page through
> > regular kernel page alloc code and not through specialize dma
> > allocator.
>=20
> .. What you are saying is that the intent of this patch is
> to not use TTM DMA.
>=20
> Are you using the SWIOTLB 99% of the time? 1%? Or is this
> related to the unfortunate patch that enabled SWIOTLB all the time?
> (If so, please please mention that in the commit, it didn't
> occur to me until just now).
>=20
> If that is the case we should attack the problem in a different
> way - see if the IOMMU API is setup? Or is that set already
> to some no_iommu option?
>=20
> I think what you are looking for is a simple flag telling you
> whether the IOMMU is there - in which case use the streaming
> DMA API calls (dma_map_page, etc)?

Konrad are you happy with all the explanation ? I am want to move
that patch forward so we can fix performance and forget about swiotlb
for GPU.

Cheers,
J=E9r=F4me
