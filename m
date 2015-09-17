From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH] dma/swiotlb: Add helper for device driver to opt-out
 from swiotlb.
Date: Thu, 17 Sep 2015 15:27:47 -0400
Message-ID: <20150917192746.GC6699@redhat.com>
References: <1442514158-30281-1-git-send-email-jglisse@redhat.com>
 <20150917190251.GE20952@x230.dumpdata.com>
 <20150917190656.GF20952@x230.dumpdata.com>
 <20150917191113.GB6699@redhat.com>
 <20150917192424.GB21496@x230.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917192424.GB21496@x230.dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 17, 2015 at 03:24:25PM -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Sep 17, 2015 at 03:11:14PM -0400, Jerome Glisse wrote:
> > On Thu, Sep 17, 2015 at 03:06:57PM -0400, Konrad Rzeszutek Wilk wro=
te:
> > > On Thu, Sep 17, 2015 at 03:02:51PM -0400, Konrad Rzeszutek Wilk w=
rote:
> > > > On Thu, Sep 17, 2015 at 02:22:38PM -0400, jglisse@redhat.com wr=
ote:
> > > > > From: J=E9r=F4me Glisse <jglisse@redhat.com>
> > > > >=20
> > > > > The swiotlb dma backend is not appropriate for some devices l=
ike
> > > > > GPU where bounce buffer or slow dma page allocations is just =
not
> > > > > acceptable. With that helper device drivers can opt-out from =
the
> > > > > swiotlb and just do sane things without wasting CPU cycles in=
side
> > > > > the swiotlb code.
> > > >=20
> > > > What if SWIOTLB is the only one available?
> > > >=20
> > > > And what can't the devices use the TTM DMA backend which sets u=
p
> > > > buffers which don't need bounce buffer or slow dma page allocat=
ions?
> > >=20
> > > And then the followup question. If it opts out - how can it do
> > > sane things without an DMA API available? It would assume physica=
l
> > > addresses match the bus addresses which is not always the sane
> > > thing.
> >=20
> > This is why this is an arch specific function, on x86 with pci devi=
ce,
> > the driver knows what is the dma mask and thus if it can access dir=
ectly
> > all the memory or not. So in the end swiotlb vs no_mmu gives the sa=
me
> > physical address to the device so there is no difference there.
>=20
> Not with Intel or AMD IOMMUs. The bus address it gives is not the sam=
e
> as the physical address.

Yes but this patch never overidde if the dma_ops are the one from any I=
OMMU
thus it can only override if there is a 1 to 1 mapping btw bus address =
and
physical address.

Cheers,
J=E9r=F4me
