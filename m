From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 19:38:05 +0000
Message-ID: <20190130193759.GE17080@mellanox.com>
References: <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com> <20190130192234.GD5061@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130192234.GD5061@redhat.com>
Content-Language: en-US
Content-ID: <D90F85F4D783CE409C5D0F40D1A5C001@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 02:22:34PM -0500, Jerome Glisse wrote:

> For GPU it would not work, GPU might want to use main memory (because
> it is running out of BAR space) it is a lot easier if the p2p_map
> callback calls the right dma map function (for page or io) rather than
> having to define some format that would pass down the information.

This is already sort of built into the sgl, you are supposed to use
is_pci_p2pdma_page() and pci_p2pdma_map_sg() and somehow it is supposed
to work out - but I think this is also fairly incomplete.

ie the current APIs seem to assume the SGL is homogeneous :(

> > Worry about optimizing away the struct page overhead later?
>=20
> Struct page do not fit well for GPU as the BAR address can be reprogram
> to point to any page inside the device memory (think 256M BAR versus
> 16GB device memory).

The struct page only points to the BAR - it is not related to the
actual GPU memory in any way. The struct page is just an alternative
way to specify the physical address of the BAR page.

I think this boils down to one call to setup the entire BAR, like nvme
does, and then using the struct page in the p2p_map SGL??

Jason
