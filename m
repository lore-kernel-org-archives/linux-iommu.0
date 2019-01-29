From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Tue, 29 Jan 2019 15:58:45 -0700
Message-ID: <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129215028.GQ3176@redhat.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-29 2:50 p.m., Jerome Glisse wrote:
> No this is the non HMM case i am talking about here. Fully ignore HMM
> in this frame. A GPU driver that do not support or use HMM in anyway
> has all the properties and requirement i do list above. So all the points
> i was making are without HMM in the picture whatsoever. I should have
> posted this a separate patches to avoid this confusion.
> 
> Regarding your HMM question. You can not map HMM pages, all code path
> that would try that would trigger a migration back to regular memory
> and will use the regular memory for CPU access.
> 

I thought this was the whole point of HMM... And eventually it would
support being able to map the pages through the BAR in cooperation with
the driver. If not, what's that whole layer for? Why not just have HMM
handle this situation?

And what struct pages are actually going to be backing these VMAs if
it's not using HMM?


> Again HMM has nothing to do here, ignore HMM it does not play any role
> and it is not involve in anyway here. GPU want to control what object
> they allow other device to access and object they do not allow. GPU driver
> _constantly_ invalidate the CPU page table and in fact the CPU page table
> do not have any valid pte for a vma that is an mmap of GPU device file
> for most of the vma lifetime. Changing that would highly disrupt and
> break GPU drivers. They need to control that, they need to control what
> to do if another device tries to peer map some of their memory. Hence
> why they need to implement the callback and decide on wether or not they
> allow the peer mapping or use device memory for it (they can decide to
> fallback to main memory).

But mapping is an operation of the memory/struct pages behind the VMA;
not of the VMA itself and I think that's evident by the code in that the
only way the VMA layer is involved is the fact that you're abusing
vm_ops by adding new ops there and calling it by other layers.

Logan
