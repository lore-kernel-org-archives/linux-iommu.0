From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 12:44:17 -0700
Message-ID: <c82228c8-1879-b9f6-6b07-6867df826d2c@deltatee.com>
References: <20190130041841.GB30598@mellanox.com>
 <20190130080006.GB29665@lst.de> <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
 <20190131193513.GC16593@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131193513.GC16593@redhat.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-31 12:35 p.m., Jerome Glisse wrote:
> So what is this O_DIRECT thing that keep coming again and again here :)
> What is the use case ? Note that bio will always have valid struct page
> of regular memory as using PCIE BAR for filesystem is crazy (you do not
> have atomic or cache coherence and many CPU instruction have _undefined_
> effect so what ever the userspace would do might do nothing.

The point is to be able to use a BAR as the source of data to write/read
from a file system. So as a simple example, if an NVMe drive had a CMB,
and you could map that CMB to userspace, you could do an O_DIRECT read
to the BAR on one drive and an O_DIRECT write from the BAR on another
drive. Thus you could bypass the upstream port of a switch (and
therefore all CPU resources) altogether.

For the most part nobody would want to put a filesystem on a BAR.
(Though there have been some crazy ideas to put persistent memory behind
a CMB...)

> Now if you want to use BAR address as destination or source of directIO
> then let just update the directIO code to handle this. There is no need
> to go hack every single place in the kernel that might deal with struct
> page or sgl. Just update the place that need to understand this. We can
> even update directIO to work on weird platform. The change to directIO
> will be small, couple hundred line of code at best.

Well if you want to figure out how to remove struct page from the entire
block layer that would help everybody. But until then, it's pretty much
impossible to use the block layer (and therefore O_DIRECT) without
struct page.

Logan
