From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 10:11:45 -0500
Message-ID: <20190131151145.GC4619@redhat.com>
References: <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com>
 <20190130080208.GC29665@lst.de>
 <20190130174424.GA17080@mellanox.com>
 <bcbdfae6-cfc6-c34f-4ff2-7bb9a08f38af@deltatee.com>
 <20190130191946.GD17080@mellanox.com>
 <3793c115-2451-1479-29a9-04bed2831e4b@deltatee.com>
 <20190130204414.GH17080@mellanox.com>
 <20190131080501.GB26495@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131080501.GB26495@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 09:05:01AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 08:44:20PM +0000, Jason Gunthorpe wrote:
> > Not really, for MRs most drivers care about DMA addresses only. The
> > only reason struct page ever gets involved is because it is part of
> > the GUP, SGL and dma_map family of APIs.
> 
> And the only way you get the DMA address is through the dma mapping
> APIs.  Which except for the little oddball dma_map_resource expect
> a struct page in some form.  And dma_map_resource isn't really up
> to speed for full blown P2P.
> 
> Now we could and maybe eventually should change all this.  But that
> is a pre-requisitive for doing anything more fancy, and not something
> to be hacked around.
> 
> > O_DIRECT seems to be the justification for struct page, but nobody is
> > signing up to make O_DIRECT have the required special GUP/SGL/P2P flow
> > that would be needed to *actually* make that work - so it really isn't
> > a justification today.
> 
> O_DIRECT is just the messenger.  Anything using GUP will need a struct
> page, which is all our interfaces that do I/O directly to user pages.

I do not want to allow GUP to pin I/O space this would open a pandora
box that we do not want to open at all. Many driver manage their IO
space and if they get random pinning because some other kernel bits
they never heard of starts to do GUP on their stuff it is gonna cause
havoc.

So far mmap of device file have always been special and it has been
reflected to userspace in all the instance i know of (media and GPU).
Pretending we can handle them like any other vma is a lie because
they were never designed that way in the first place and it would be
disruptive to all those driver.

Minimum disruption with minimun changes is what we should aim for and
is what i am trying to do with this patchset. Using struct page and
allowing GUP would mean rewritting huge chunk of GPU drivers (pretty
much rewritting their whole memory management) with no benefit at the
end.

When something is special it is better to leave it that way.

Cheers,
Jérôme
