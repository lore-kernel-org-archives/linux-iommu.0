From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Mon, 14 Jan 2019 11:31:39 +0100
Message-ID: <20190114103139.GA31005@lst.de>
References: <20190111181731.11782-1-hch@lst.de> <20190111181731.11782-4-hch@lst.de> <20190111175416.7d291e25@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190111175416.7d291e25@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 11, 2019 at 05:54:16PM -0200, Mauro Carvalho Chehab wrote:
> Em Fri, 11 Jan 2019 19:17:31 +0100
> Christoph Hellwig <hch@lst.de> escreveu:
> 
> > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > resemblance of a dma address for a a physical address that does is
> > not backed by a page struct.  Not only is this not portable to other
> > architectures with dma direct mapping offsets, but also not to uses
> > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > dma_unmap_resource interface instead.
> 
> Makes sense to me. I'm assuming that you'll be pushing it together
> with other mm patches, so:

Not really mm, but rather DMA mapping, but yes, I'd love to take it
all together.

Thanks!
