From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 19:02:15 +0000
Message-ID: <20190131190202.GC7548@mellanox.com>
References: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131081355.GC26495@lst.de>
Content-Language: en-US
Content-ID: <CD8CEED72A7F8B4182C44E495B868BB9@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 09:13:55AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 03:52:13PM -0700, Logan Gunthorpe wrote:
> > > *shrug* so what if the special GUP called a VMA op instead of
> > > traversing the VMA PTEs today? Why does it really matter? It could
> > > easily change to a struct page flow tomorrow..
> >=20
> > Well it's so that it's composable. We want the SGL->DMA side to work fo=
r
> > APIs from kernel space and not have to run a completely different flow
> > for kernel drivers than from userspace memory.
>=20
> Yes, I think that is the important point.
>=20
> All the other struct page discussion is not about anyone of us wanting
> struct page - heck it is a pain to deal with, but then again it is
> there for a reason.
>=20
> In the typical GUP flows we have three uses of a struct page:
>=20
>  (1) to carry a physical address.  This is mostly through
>      struct scatterlist and struct bio_vec.  We could just store
>      a magic PFN-like value that encodes the physical address
>      and allow looking up a page if it exists, and we had at least
>      two attempts at it.  In some way I think that would actually
>      make the interfaces cleaner, but Linus has NACKed it in the
>      past, so we'll have to convince him first that this is the
>      way forward

Something like this (and more) has always been the roadblock with
trying to mix BAR memory into SGL. I think it is such a big problem as
to be unsolvable in one step..=20

Struct page doesn't even really help anything beyond dma_map as we
still can't pretend that __iomem is normal memory for general SGL
users.

>  (2) to keep a reference to the memory so that it doesn't go away
>      under us due to swapping, process exit, unmapping, etc.
>      No idea how we want to solve this, but I guess you have
>      some smart ideas?

Jerome, how does this work anyhow? Did you do something to make the
VMA lifetime match the p2p_map/unmap? Or can we get into a situation
were the VMA is destroyed and the importing driver can't call the
unmap anymore?

I know in the case of notifiers the VMA liftime should be strictly
longer than the map/unmap - but does this mean we can never support
non-notifier users via this scheme?

>  (3) to make the PTEs dirty after writing to them.  Again no sure
>      what our preferred interface here would be

This need doesn't really apply to BAR memory..

> If we solve all of the above problems I'd be more than happy to
> go with a non-struct page based interface for BAR P2P.  But we'll
> have to solve these issues in a generic way first.

I still think the right direction is to build on what Logan has done -
realize that he created a DMA-only SGL - make that a formal type of
the kernel and provide the right set of APIs to work with this type,
without being forced to expose struct page.

Basically invert the API flow - the DMA map would be done close to
GUP, not buried in the driver. This absolutely doesn't work for every
flow we have, but it does enable the ones that people seem to care
about when talking about P2P.

To get to where we are today we'd need a few new IB APIs, and some
nvme change to work with DMA-only SGL's and so forth, but that doesn't
seem so bad. The API also seems much more safe and understandable than
todays version that is trying to hope that the SGL is never touched by
the CPU.

It also does present a path to solve some cases of the O_DIRECT
problems if the block stack can develop some way to know if an IO will
go down a DMA-only IO path or not... This seems less challenging that
auditing every SGL user for iomem safety??

Yes we end up with a duality, but we already basically have that with
the p2p flow today..

Jason
