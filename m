From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Date: Thu, 31 Jan 2019 12:19:31 -0700
Message-ID: <e4fd743f-61cb-a443-bc53-9a1c036ebe8c@deltatee.com>
References: <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
 <20190131081355.GC26495@lst.de> <20190131190202.GC7548@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131190202.GC7548@mellanox.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc: Jerome Glisse <jglisse@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-31 12:02 p.m., Jason Gunthorpe wrote:
> I still think the right direction is to build on what Logan has done -
> realize that he created a DMA-only SGL - make that a formal type of
> the kernel and provide the right set of APIs to work with this type,
> without being forced to expose struct page.

> Basically invert the API flow - the DMA map would be done close to
> GUP, not buried in the driver. This absolutely doesn't work for every
> flow we have, but it does enable the ones that people seem to care
> about when talking about P2P.
> It also does present a path to solve some cases of the O_DIRECT
> problems if the block stack can develop some way to know if an IO will
> go down a DMA-only IO path or not... This seems less challenging that
> auditing every SGL user for iomem safety??


The DMA-only SGL will work for some use cases, but I think it's going to
be a challenge for others. We care most about NVMe and, therefore, the
block layer.

Given my understanding of the block layer, and it's queuing
infrastructure, I don't think having a DMA-only IO path makes sense. I
think it has to be the same path, but with a special DMA-only bio; and
endpoints would have to indicate support for that bio. I can't say I
have a deep enough understanding of the block layer to know how possible
that would be.

Logan
