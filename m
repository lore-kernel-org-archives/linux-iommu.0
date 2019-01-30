From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 17:39:07 +0000
Message-ID: <20190130173859.GA17915@mellanox.com>
References: <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
 <4e0637ba-0d7c-66a5-d3de-bc1e7dc7c0ef@amd.com>
 <20190130155543.GC3177@redhat.com> <20190130172653.GA6707@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130172653.GA6707@lst.de>
Content-Language: en-US
Content-ID: <E7430F120D2DC64DA4E2E168FBE5A5DC@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jerome Glisse <jglisse@redhat.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 06:26:53PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 10:55:43AM -0500, Jerome Glisse wrote:
> > Even outside GPU driver, device driver like RDMA just want to share the=
ir
> > doorbell to other device and they do not want to see those doorbell pag=
e
> > use in direct I/O or anything similar AFAICT.
>=20
> At least Mellanox HCA support and inline data feature where you
> can copy data directly into the BAR.  For something like a usrspace
> NVMe target it might be very useful to do direct I/O straight into
> the BAR for that.

It doesn't really work like that.=20

The PCI-E TLP sequence to trigger this feature is very precise, and
the data requires the right headers/etc. Mixing that with O_DIRECT
seems very unlikely.

Jason
