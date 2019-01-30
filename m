From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 23:30:27 +0000
Message-ID: <20190130233021.GD25486@mellanox.com>
References: <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
Content-Language: en-US
Content-ID: <95781CBA468AA44CA09FE9E7B761A943@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 03:52:13PM -0700, Logan Gunthorpe wrote:
>=20
>=20
> On 2019-01-30 2:50 p.m., Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 02:01:35PM -0700, Logan Gunthorpe wrote:
> >=20
> >> And I feel the GUP->SGL->DMA flow should still be what we are aiming
> >> for. Even if we need a special GUP for special pages, and a special DM=
A
> >> map; and the SGL still has to be homogenous....
> >=20
> > *shrug* so what if the special GUP called a VMA op instead of
> > traversing the VMA PTEs today? Why does it really matter? It could
> > easily change to a struct page flow tomorrow..
>=20
> Well it's so that it's composable. We want the SGL->DMA side to work for
> APIs from kernel space and not have to run a completely different flow
> for kernel drivers than from userspace memory.

If we want to have these DMA-only SGLs anyhow, then the kernel flow
can use them too.

In the kernel it easier because the 'exporter' already knows it is
working with BAR memory, so it can just do something like this:

struct dma_sg_table *sgl_dma_map_pci_bar(struct pci_device *from,
                                         struct device *to,
                                         unsigned long bar_ptr,
                                         size_t length)

And then it falls down the same DMA-SGL-only kind of flow that would
exist to support the user side. ie it is the kernel version of the API
I described below.

> For GUP to do a special VMA traversal it would now need to return
> something besides struct pages which means no SGL and it means a
> completely different DMA mapping call.

GUP cannot support BAR memory because it must only return CPU memory -
I think too many callers make this assumption for it to be possible to
change it.. (see below)

A new-GUP can return DMA addresses - so it doesn't have this problem.

> > Would you feel better if this also came along with a:
> >=20
> >   struct dma_sg_table *sgl_dma_map_user(struct device *dma_device,=20
> >              void __user *prt, size_t len)
>=20
> That seems like a nice API. But certainly the implementation would need
> to use existing dma_map or pci_p2pdma_map calls, or whatever as part of
> it...

I wonder how Jerome worked the translation, I haven't looked yet..

> We actually stopped caring about the __iomem problem. We are working
> under the assumption that pages returned by devm_memremap_pages() can be
> accessed as normal RAM and does not need the __iomem designation.

As far as CPU mapped uncached BAR memory goes, this is broadly not
true.

s390x for instance requires dedicated CPU instructions to access BAR
memory.

x86 will fault if you attempt to use a SSE algorithm on uncached BAR
memory. The kernel has many SSE accelerated algorithsm so you can
never pass these special p2p SGL's through to them either. (think
parity or encryption transformations through the block stack)

Many platforms have limitations on alignment and access size for BAR
memory - you can't just blindly call memcpy and expect it to work.
(TPM is actually struggling with this now, confusingly different
versions of memcpy are giving different results on some x86 io memory)

Other platforms might fault or corrupt if an unaligned access is
attempted to BAR memory.

In short - I don't see a way to avoid knowing about __iomem in the
sgl. There are too many real use cases that require this knowledge,
and too many places that touch the SGL pages with the CPU.

I think we must have 'DMA only' SGLs and code paths that are known
DMA-only clean to make it work properly with BAR memory.

Jason
