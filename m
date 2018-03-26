From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
	CONFIG_DMA_DIRECT_OPS
Date: Mon, 26 Mar 2018 15:42:59 +0200
Message-ID: <20180326134259.GA15387@lst.de>
References: <20180323174930.17767-1-hch@lst.de>
	<20180323185707.GD25533@char.us.oracle.com>
	<20180324170351.GA511@lst.de>
	<20180324200545.GC23658@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180324200545.GC23658-he5eyhs8q0BAdwtm4QZOy9BPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Mar 24, 2018 at 04:05:45PM -0400, Konrad Rzeszutek Wilk wrote:
> > > > Otherwise we might get unused symbol warnings for configs that built
> > > > swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> > > > CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> > > > 
> > > > Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> > > > Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
> > > > Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> > > 
> > > 
> > > Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?
> > 
> > 
> > IFF we build swiotlb.c only for xen-swiotlb we don't need DMA_DIRECT_OPS.
> 
> I don't think there is ever an case where you want a Xen specific build.

arm never uses swiotlb directly, so any swiotlb.c build on arm is purely
for xen-swiotlb.c
