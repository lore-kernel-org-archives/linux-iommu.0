From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
 allocated dma coherent mem
Date: Fri, 26 Apr 2019 17:13:30 +0200
Message-ID: <20190426151330.GC20438@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com> <20190422181100.GB32490@lst.de> <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com> <20190424145705.GB21480@lst.de> <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Christoph Hellwig <hch@lst.de>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Leo Li <leoyang.li@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 25, 2019 at 11:30:54AM +0000, Laurentiu Tudor wrote:
> > I think the first step is to move the two USB controller that can only
> > DMA to their own BAR off the existing DMA coherent infrastructure.  The
> > controllers are already identified using the HCD_LOCAL_MEM flag, so we
> > just need to key off that in the hcd_buffer_* routines and call into a
> 
> So if HCD_LOCAL_MEM is set I should call into the gen_pool api instead 
> of existing dma_{alloc,free}_coherent().

Yes.

> > genalloc that has been fed using the bar, replacing the current
> > dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
> > for another example of allocating bits of a BAR using genalloc.
> 
> Where should I place the reference to the gen_pool? How does local_pool 
> in 'struct hcd_usb' sound?

Sounds fine to me, but in the end the usb maintainers will have
to decide.
