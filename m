From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 13:05:41 -0500
Message-ID: <20190130180541.GA5061@redhat.com>
References: <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com>
 <20190130080208.GC29665@lst.de>
 <4e0637ba-0d7c-66a5-d3de-bc1e7dc7c0ef@amd.com>
 <20190130155543.GC3177@redhat.com>
 <20190130172653.GA6707@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130172653.GA6707@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 06:26:53PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 10:55:43AM -0500, Jerome Glisse wrote:
> > Even outside GPU driver, device driver like RDMA just want to share their
> > doorbell to other device and they do not want to see those doorbell page
> > use in direct I/O or anything similar AFAICT.
> 
> At least Mellanox HCA support and inline data feature where you
> can copy data directly into the BAR.  For something like a usrspace
> NVMe target it might be very useful to do direct I/O straight into
> the BAR for that.

And what i am proposing is not exclusive of that. If exporting device
wants to have struct page for its BAR than it can do so. What i do not
want is imposing that burden on everyone as many devices do not want
or do not care for that. Moreover having struct page and allowing that
struct page to trickle know in obscure corner of the kernel means that
exporter that want that will also have the burden to check that what
they are doing does not end up in something terribly bad.

While i would like a one API fits all i do not think that we can sanely
do that for P2P. They are too much differences between how different
devices expose and manage their BAR to make any such attempt reasonably
sane.

Maybe thing will evolve oragnicaly, but for now i do not see a way out
side the API i am proposing (again this is not exclusive of the struct
page API that is upstream both can co-exist and a device can use both
or just one).

Cheers,
Jérôme
