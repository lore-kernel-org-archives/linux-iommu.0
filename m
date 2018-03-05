From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Mon, 5 Mar 2018 16:10:10 +0100
Message-ID: <20180305151010.GA15965@lst.de>
References: <20180302180704.GA3846@localhost.localdomain>
	<20180302213711.GA30356@lst.de>
	<20180303082234.GB24991@localhost.localdomain>
	<20180303161249.GA9516@lst.de>
	<20180303181904.GA19076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180303181904.GA19076-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, =?iso-8859-1?Q?J=FCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Mar 03, 2018 at 07:19:06PM +0100, Fredrik Noring wrote:
> Christoph, Alan,
> 
> > If it is allocating / freeing this memory all the time in the hot path
> > it should really use a dma pool (see include/ilinux/dmapool.h).
> > The dma coherent APIs aren't really built for being called in the
> > hot path.
> 
> hcd_buffer_free uses a combination of dma pools and dma coherent APIs:
> 
> 	...
> 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
> 		if (size <= pool_max[i]) {
> 			dma_pool_free(hcd->pool[i], addr, dma);
> 			return;
> 		}
> 	}
> 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
> 
> Alan, can dma_free_coherent be delayed to a point when IRQs are enabled?

The point is that you should always use a pool, period.
dma_alloc*/dma_free* are fundamentally expensive operations on my
architectures, so if you call them from a fast path you are doing
something wrong.
