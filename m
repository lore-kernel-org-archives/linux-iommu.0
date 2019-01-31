From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 19:54:59 +0000
Message-ID: <20190131195453.GE7548@mellanox.com>
References: <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
 <e4fd743f-61cb-a443-bc53-9a1c036ebe8c@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e4fd743f-61cb-a443-bc53-9a1c036ebe8c@deltatee.com>
Content-Language: en-US
Content-ID: <01E72E6BF04AD94ABCA85A4BF90D23C0@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 12:19:31PM -0700, Logan Gunthorpe wrote:
>=20
>=20
> On 2019-01-31 12:02 p.m., Jason Gunthorpe wrote:
> > I still think the right direction is to build on what Logan has done -
> > realize that he created a DMA-only SGL - make that a formal type of
> > the kernel and provide the right set of APIs to work with this type,
> > without being forced to expose struct page.
>=20
> > Basically invert the API flow - the DMA map would be done close to
> > GUP, not buried in the driver. This absolutely doesn't work for every
> > flow we have, but it does enable the ones that people seem to care
> > about when talking about P2P.
> > It also does present a path to solve some cases of the O_DIRECT
> > problems if the block stack can develop some way to know if an IO will
> > go down a DMA-only IO path or not... This seems less challenging that
> > auditing every SGL user for iomem safety??
>=20
>=20
> The DMA-only SGL will work for some use cases, but I think it's going to
> be a challenge for others. We care most about NVMe and, therefore, the
> block layer.

The exercise here is not to enable O_DIRECT for P2P, it is to allow
certain much simpler users to use P2P. We should not be saying that
someone has to solve these complicated problems in the entire block
stack just to make RDMA work. :(

If the block stack can use a 'dma sgl' or not, I don't know.

However, it does look like it fits these RDMA, GPU and VFIO cases
fairly well, and looks better than the hacky
sgl-but-really-special-p2p hack we have in RDMA today.

Jason
