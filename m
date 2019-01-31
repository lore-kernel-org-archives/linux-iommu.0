From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 10:03:09 -0500
Message-ID: <20190131150309.GB4619@redhat.com>
References: <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com>
 <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com>
 <20190130080208.GC29665@lst.de>
 <20190130174424.GA17080@mellanox.com>
 <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
 <20190130185027.GC5061@redhat.com>
 <20190131080203.GA26495@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131080203.GA26495@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@mellanox.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 09:02:03AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 01:50:27PM -0500, Jerome Glisse wrote:
> > I do not see how VMA changes are any different than using struct page
> > in respect to userspace exposure. Those vma callback do not need to be
> > set by everyone, in fact expectation is that only handful of driver
> > will set those.
> > 
> > How can we do p2p between RDMA and GPU for instance, without exposure
> > to userspace ? At some point you need to tell userspace hey this kernel
> > does allow you to do that :)
> 
> To do RDMA on a memory region you need struct page backіng to start
> with..

No you do not with this patchset and there is no reason to tie RDMA to
struct page it does not provide a single feature we would need. So as
it can be done without and they are not benefit of using one i do not
see why we should use one.

Cheers,
Jérôme
