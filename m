From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Mon, 14 Jan 2019 09:04:56 -0200
Message-ID: <20190114090456.03071201@coco.lan>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de>
 <20190111175416.7d291e25@coco.lan> <20190114103139.GA31005@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190114103139.GA31005@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>, Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Em Mon, 14 Jan 2019 11:31:39 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> On Fri, Jan 11, 2019 at 05:54:16PM -0200, Mauro Carvalho Chehab wrote:
> > Em Fri, 11 Jan 2019 19:17:31 +0100
> > Christoph Hellwig <hch@lst.de> escreveu:
> >   
> > > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > > resemblance of a dma address for a a physical address that does is
> > > not backed by a page struct.  Not only is this not portable to other
> > > architectures with dma direct mapping offsets, but also not to uses
> > > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > > dma_unmap_resource interface instead.  
> > 
> > Makes sense to me. I'm assuming that you'll be pushing it together
> > with other mm patches, so:  
> 
> Not really mm, but rather DMA mapping, but yes, I'd love to take it
> all together.

Ah, OK! Anyway, feel free to place it altogether. 

It would be good if you could later send us a stable branch where
you merged, in order to allow us to run some tests with the new
DMA mapping patchset and be sure that it won't cause regressions
to videobuf2.

Thank you!

Mauro
