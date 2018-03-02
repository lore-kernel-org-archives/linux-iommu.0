From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Fri, 2 Mar 2018 19:55:48 +0000
Message-ID: <bfe85e97-2974-06ee-8c6d-f8e8a83348ea@arm.com>
References: <20180302180704.GA3846@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302180704.GA3846-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Fredrik,

On 02/03/18 18:07, Fredrik Noring wrote:
> Hello DMA mapping helpers maintainers,
> 
> I'm porting the PS2 OHCI driver to v4.15 and it triggers
> 
> 	WARN_ON(irqs_disabled());
> 
> in include/linux/dma-mapping.h:dma_free_attrs (trace below). USB maintainer
> Alan Stern notes in
> 
> https://www.spinics.net/lists/linux-usb/msg162817.html
> 
> that
> 
> 	This is caused by a deficiency in the DMA core: dma_free_coherent()
> 	wants interrupts to be enabled when it is called.  I'm not sure how
> 	the other host controller drivers cope with this.
> 
> What is the best way to proceed? Can dma_free_attrs be reworked to handle
> disabled IRQs?

Historically, that particular line of code appears to date back to 
commit aa24886e379d (and tracking it's ancestry was quite fun).

Now, I'm sure not all of the considerations of 11-and-a-half years ago 
still apply, but one certainly does: ARM* still uses non-cacheable 
mappings for coherent allocations on systems which aren't 
hardware-coherent (i.e. most of them), thus the alloc and free paths may 
respectively set up and tear down those mappings, and the latter 
involves this guy:

	void vunmap(const void *addr)
	{
		BUG_ON(in_interrupt());
		might_sleep();
		if (addr)
			__vunmap(addr, 0);
	}

Even in the non-coherent ARM case it *would* technically be viable to 
free a coherent buffer from interrupt context iff it was allocated with 
GFP_ATOMIC, as those are satisfied from a statically-mapped pool rather 
than dynamically vmapped, but that doesn't really expand to the general 
case, and I certainly can't speak for all the other architectures.

As Alan implies, I guess the way forward is to figure out how similar 
drivers manage - your backtrace suggests that you might be using 
HCD_LOCAL_MEM, which probably isn't the common case but does seem to 
appear in at least a couple of other OHCI drivers.

On the other hand, HCD_LOCAL_MEM implies a per-device coherent pool. 
Since those bypass the arch-specific code, then depending on how 
unlikely we think it is for devices covered by a single driver to exist 
both with and without their own memory then it *might* also be 
reasonable to make the change below. Christoph, what do you reckon?

Robin.

*plus now arm64 and probably others too

----->8-----
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 34fe8463d10e..eb8e42ce89a0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -542,11 +542,11 @@ static inline void dma_free_attrs(struct device 
*dev, size_t size,
  	const struct dma_map_ops *ops = get_dma_ops(dev);

  	BUG_ON(!ops);
-	WARN_ON(irqs_disabled());

  	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
  		return;

+	WARN_ON(irqs_disabled());
  	if (!ops->free || !cpu_addr)
  		return;
