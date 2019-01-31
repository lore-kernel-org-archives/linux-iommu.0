From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 19:58:05 +0000
Message-ID: <20190131195759.GF7548@mellanox.com>
References: <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
 <20190131193513.GC16593@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131193513.GC16593@redhat.com>
Content-Language: en-US
Content-ID: <899A3F71B570B941926CEF47667C9170@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 02:35:14PM -0500, Jerome Glisse wrote:

> > Basically invert the API flow - the DMA map would be done close to
> > GUP, not buried in the driver. This absolutely doesn't work for every
> > flow we have, but it does enable the ones that people seem to care
> > about when talking about P2P.
>=20
> This does not work for GPU really i do not want to have to rewrite GPU
> driver for this. Struct page is a burden and it does not bring anything
> to the table. I rather provide an all in one stop for driver to use
> this without having to worry between regular vma and special vma.

I'm talking about almost exactly what you've done in here - make a
'sgl' that is dma addresses only.=20

In these VMA patches you used a simple array of physical addreses -
I'm only talking about moving that array into a 'dma sgl'.

The flow is still basically the same - the driver directly gets DMA
physical addresses with no possibility to get a struct page or CPU
memory.

And then we can build more stuff around the 'dma sgl', including
the in-kernel users Logan is worrying about.

Jason
