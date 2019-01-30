From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 17:44:31 +0000
Message-ID: <20190130174424.GA17080@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130080208.GC29665@lst.de>
Content-Language: en-US
Content-ID: <F849EDC110592049BC19081D2ED8EABB@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 09:02:08AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 08:58:35PM +0000, Jason Gunthorpe wrote:
> > On Tue, Jan 29, 2019 at 01:39:49PM -0700, Logan Gunthorpe wrote:
> >=20
> > > implement the mapping. And I don't think we should have 'special' vma=
's
> > > for this (though we may need something to ensure we don't get mapping
> > > requests mixed with different types of pages...).
> >=20
> > I think Jerome explained the point here is to have a 'special vma'
> > rather than a 'special struct page' as, really, we don't need a
> > struct page at all to make this work.
> >=20
> > If I recall your earlier attempts at adding struct page for BAR
> > memory, it ran aground on issues related to O_DIRECT/sgls, etc, etc.
>=20
> Struct page is what makes O_DIRECT work, using sgls or biovecs, etc on
> it work.  Without struct page none of the above can work at all.  That
> is why we use struct page for backing BARs in the existing P2P code.
> Not that I'm a particular fan of creating struct page for this device
> memory, but without major invasive surgery to large parts of the kernel
> it is the only way to make it work.

I don't think anyone is interested in O_DIRECT/etc for RDMA doorbell
pages.

.. and again, I recall Logan already attempted to mix non-CPU memory
into sgls and it was a disaster. You pointed out that one cannot just
put iomem addressed into a SGL without auditing basically the entire
block stack to prove that nothing uses iomem without an iomem
accessor.

I recall that proposal veered into a direction where the block layer
would just fail very early if there was iomem in the sgl, so generally
no O_DIRECT support anyhow.

We already accepted the P2P stuff from Logan as essentially a giant
special case - it only works with RDMA and only because RDMA MR was
hacked up with a special p2p callback.

I don't see why a special case with a VMA is really that different.

If someone figures out the struct page path down the road it can
obviously be harmonized with this VMA approach pretty easily.

Jason
