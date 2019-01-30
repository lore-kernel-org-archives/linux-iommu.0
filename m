From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 04:18:48 +0000
Message-ID: <20190130041841.GB30598@mellanox.com>
References: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
Content-Language: en-US
Content-ID: <82BFF7F760AB5D47935C40953858BB8C@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 29, 2019 at 06:17:43PM -0700, Logan Gunthorpe wrote:

> This isn't answering my question at all... I specifically asked what is
> backing the VMA when we are *not* using HMM.

At least for RDMA what backs the VMA today is non-struct-page BAR
memory filled in with io_remap_pfn.

And we want to expose this for P2P DMA. None of the HMM stuff applies
here and the p2p_map/unmap are a nice simple approach that covers all
the needs RDMA has, at least.

Every attempt to give BAR memory to struct page has run into major
trouble, IMHO, so I like that this approach avoids that.

And if you don't have struct page then the only kernel object left to
hang meta data off is the VMA itself.

It seems very similar to the existing P2P work between in-kernel
consumers, just that VMA is now mediating a general user space driven
discovery process instead of being hard wired into a driver.

Jason
