From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 19:06:57 +0000
Message-ID: <20190130190651.GC17080@mellanox.com>
References: <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130080006.GB29665@lst.de>
Content-Language: en-US
Content-ID: <D5475048F79FD84A8C1E7231DA08336B@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 09:00:06AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 04:18:48AM +0000, Jason Gunthorpe wrote:
> > Every attempt to give BAR memory to struct page has run into major
> > trouble, IMHO, so I like that this approach avoids that.
>=20
> Way less problems than not having struct page for doing anything
> non-trivial.  If you map the BAR to userspace with remap_pfn_range
> and friends the mapping is indeed very simple.  But any operation
> that expects a page structure, which is at least everything using
> get_user_pages won't work.

GUP doesn't work anyhow today, and won't work with BAR struct pages in
the forseeable future (Logan has sent attempts on this before).

So nothing seems lost..

> So you can't do direct I/O to your remapped BAR, you can't create MRs
> on it, etc, etc.

Jerome made the HMM mirror API use this flow, so afer his patch to
switch the ODP MR to use HMM, and to switch GPU drivers, it will work
for those cases. Which is more than the zero cases than we have today
:)

Jason
