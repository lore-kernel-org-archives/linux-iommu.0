From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 23:02:25 +0000
Message-ID: <20190129224016.GD4713@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com> <20190129202429.GL10108@mellanox.com>
 <20190129204359.GM3176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129204359.GM3176@redhat.com>
Content-Language: en-US
Content-ID: <80A32BC881EDF545A23BE7BA9D3E7E68@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 03:44:00PM -0500, Jerome Glisse wrote:

> > But this API doesn't seem to offer any control - I thought that
> > control was all coming from the mm/hmm notifiers triggering p2p_unmaps?
>=20
> The control is within the driver implementation of those callbacks.=20

Seems like what you mean by control is 'the exporter gets to choose
the physical address at the instant of map' - which seems reasonable
for GPU.


> will only allow p2p map to succeed for objects that have been tagged by t=
he
> userspace in some way ie the userspace application is in control of what
> can be map to peer device.

I would have thought this means the VMA for the object is created
without the map/unmap ops? Or are GPU objects and VMAs unrelated?

> For moving things around after a successful p2p_map yes the exporting
> device have to call for instance zap_vma_ptes() or something
> similar.

Okay, great, RDMA needs this flow for hotplug - we zap the VMA's when
unplugging the PCI device and we can delay the PCI unplug completion
until all the p2p_unmaps are called...

But in this case a future p2p_map will have to fail as the BAR no
longer exists. How to handle this?

> > I would think that the importing driver can assume the BAR page is
> > kept alive until it calls unmap (presumably triggered by notifiers)?
> >=20
> > ie the exporting driver sees the BAR page as pinned until unmap.
>=20
> The intention with this patchset is that it is not pin ie the importer
> device _must_ abide by all mmu notifier invalidations and they can
> happen at anytime. The importing device can however re-p2p_map the
> same range after an invalidation.
>
> I would like to restrict this to importer that can invalidate for
> now because i believe all the first device to use can support the
> invalidation.

This seems reasonable (and sort of says importers not getting this
from HMM need careful checking), was this in the comment above the
ops?

Jason
