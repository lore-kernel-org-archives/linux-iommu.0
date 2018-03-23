From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
 CONFIG_DMA_DIRECT_OPS
Date: Fri, 23 Mar 2018 20:41:37 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803232039460.1481@nanos.tec.linutronix.de>
References: <20180323174930.17767-1-hch@lst.de> <20180323185707.GD25533@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323185707.GD25533@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, mingo@elte.hu, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 23 Mar 2018, Konrad Rzeszutek Wilk wrote:

> On Fri, Mar 23, 2018 at 06:49:30PM +0100, Christoph Hellwig wrote:
> > Otherwise we might get unused symbol warnings for configs that built
> > swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> > CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> > 
> > Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?

You only want to do that when you actually need the code. If not it's a
pointless exercise.

But Christoph change makes sense independent of that because the next
oddball Kconfig will come along sooner than later and run into the very
same problem.

Thanks,

	tglx
