From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 20:44:20 +0000
Message-ID: <20190130204414.GH17080@mellanox.com>
References: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
 <20190130174424.GA17080@mellanox.com>
 <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
 <20190130191946.GD17080@mellanox.com>
 <3793c115-2451-1479-29a9-04bed2831e4b@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3793c115-2451-1479-29a9-04bed2831e4b@deltatee.com>
Content-Language: en-US
Content-ID: <5DDBA0D21FE94042ACFF73FC449CFD7D@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 12:48:33PM -0700, Logan Gunthorpe wrote:
>=20
>=20
> On 2019-01-30 12:19 p.m., Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 11:13:11AM -0700, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-01-30 10:44 a.m., Jason Gunthorpe wrote:
> >>> I don't see why a special case with a VMA is really that different.
> >>
> >> Well one *really* big difference is the VMA changes necessarily expose
> >> specialized new functionality to userspace which has to be supported
> >> forever and may be difficult to change.=20
> >=20
> > The only user change here is that more things will succeed when
> > creating RDMA MRs (and vice versa to GPU). I don't think this
> > restricts the kernel implementation at all, unless we intend to
> > remove P2P entirely..
>=20
> Well for MRs I'd expect you are using struct pages to track the memory
> some how....=20

Not really, for MRs most drivers care about DMA addresses only. The
only reason struct page ever gets involved is because it is part of
the GUP, SGL and dma_map family of APIs.

> VMAs that aren't backed by pages and use this special interface must
> therefore be creating new special interfaces that can call
> p2p_[un]map...

Well, those are kernel internal interfaces, so they can be changed

No matter what we do, code that wants to DMA to user BAR pages must
take *some kind* of special care - either it needs to use a special
GUP and SGL flow, or a mixed GUP, SGL and p2p_map flow.=20

I don't really see why one is better than the other at this point, or
why doing one means we can't do the other some day later. They are
fairly similar.

O_DIRECT seems to be the justification for struct page, but nobody is
signing up to make O_DIRECT have the required special GUP/SGL/P2P flow
that would be needed to *actually* make that work - so it really isn't
a justification today.

Jason
