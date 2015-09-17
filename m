From: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] dma/swiotlb: Add helper for device driver to opt-out
	from swiotlb.
Date: Thu, 17 Sep 2015 15:11:14 -0400
Message-ID: <20150917191113.GB6699@redhat.com>
References: <1442514158-30281-1-git-send-email-jglisse@redhat.com>
	<20150917190251.GE20952@x230.dumpdata.com>
	<20150917190656.GF20952@x230.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150917190656.GF20952-sHAKZZqAc8NKMcnDSFYBzAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 17, 2015 at 03:06:57PM -0400, Konrad Rzeszutek Wilk wrote:
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
> > =

> > And what can't the devices use the TTM DMA backend which sets up
> > buffers which don't need bounce buffer or slow dma page allocations?
> =

> And then the followup question. If it opts out - how can it do
> sane things without an DMA API available? It would assume physical
> addresses match the bus addresses which is not always the sane
> thing.

This is why this is an arch specific function, on x86 with pci device,
the driver knows what is the dma mask and thus if it can access directly
all the memory or not. So in the end swiotlb vs no_mmu gives the same
physical address to the device so there is no difference there.

Obviously device driver needs to know what it is doing depending on the
arch and bus the device is use in.

Cheers,
J=E9r=F4me
