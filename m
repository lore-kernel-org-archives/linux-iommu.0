From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Wed, 30 Jan 2019 13:50:27 -0500
Message-ID: <20190130185027.GC5061@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com>
 <20190130080208.GC29665@lst.de>
 <20190130174424.GA17080@mellanox.com>
 <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 11:13:11AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-30 10:44 a.m., Jason Gunthorpe wrote:
> > I don't see why a special case with a VMA is really that different.
> 
> Well one *really* big difference is the VMA changes necessarily expose
> specialized new functionality to userspace which has to be supported
> forever and may be difficult to change. The p2pdma code is largely
> in-kernel and we can rework and change the interfaces all we want as we
> improve our struct page infrastructure.

I do not see how VMA changes are any different than using struct page
in respect to userspace exposure. Those vma callback do not need to be
set by everyone, in fact expectation is that only handful of driver
will set those.

How can we do p2p between RDMA and GPU for instance, without exposure
to userspace ? At some point you need to tell userspace hey this kernel
does allow you to do that :)

RDMA works on vma, and GPU driver can easily setup vma for an object
hence why vma sounds like a logical place. In fact vma (mmap of a device
file) is very common device driver pattern.

In the model i am proposing the exporting device is in control of
policy ie wether to allow or not the peer to peer mapping. So each
device driver can define proper device specific API to enable and
expose that feature to userspace.

If they do, the only thing we have to preserve is the end result for
the user. The userspace does not care one bit if we achieve this in
the kernel with a set of new callback within the vm_operations struct
or in some other way. Only the end result matter.

So question is do we want to allow RDMA to access GPU driver object ?
I believe we do, they are people using non upstream solution with open
source driver to do just that, so it is a testimony that they are
users for this. More use case have been propose too.

> 
> I'd also argue that p2pdma isn't nearly as specialized as this VMA thing
> and can be used pretty generically to do other things. Though, the other
> ideas we've talked about doing are pretty far off and may have other
> challenges.

I believe p2p is highly specialize on non cache-coherent inter-connect
platform like x86 with PCIE. So i do not think that using struct page
for this is a good idea, it is not warranted/needed, and it can only be
problematic if some random kernel code get holds of those struct page
without understanding it is not regular memory.

I believe the vma callback are the simplest solution with the minimum
burden for the device driver and for the kernel. If they are any better
solution that emerge there is nothing that would block us to remove
this to replace it with the other solution.

Cheers,
Jérôme
