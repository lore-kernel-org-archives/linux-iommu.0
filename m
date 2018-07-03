From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Tue,  3 Jul 2018 14:08:30 +0100
Message-ID: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: JuergenUrban-Mmb7MZpHnFY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The reasons why dma_free_attrs() should not be called from IRQ context
are not necessarily obvious and somewhat buried in the development
history, so let's start by documenting the warning itself to help anyone
who does happen to hit it and wonder what the deal is.

However, this check turns out to be slightly over-restrictive for the
way that per-device memory has been spliced into the general API, since
for that case we know that dma_declare_coherent_memory() has created an
appropriate CPU mapping for the entire area and nothing dynamic should
be happening. Given that the usage model for per-device memory is often
more akin to streaming DMA than 'real' coherent DMA (e.g. allocating and
freeing space to copy short-lived packets in and out), it is also
somewhat more reasonable for those operations to happen in IRQ handlers
for such devices.

A somewhat similar line of reasoning also applies at the other end for
the mask check in dma_alloc_attrs() too - indeed, a device which cannot
access anything other than its own local memory probably *shouldn't*
have a valid mask for the general coherent DMA API.

Therefore, let's move the per-device area hooks up ahead of the assorted
checks, so that they get a chance to resolve the request before we get
as far as definite "you're doing it wrong" territory.

Reported-by: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/dma-mapping.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f9cc309507d9..ffeca3ab59c0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -512,12 +512,12 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
 
-	BUG_ON(!ops);
-	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
-
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
+	BUG_ON(!ops);
+	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
+
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
@@ -537,12 +537,19 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	BUG_ON(!ops);
-	WARN_ON(irqs_disabled());
-
 	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
 		return;
 
+	BUG_ON(!ops);
+	/*
+	 * On non-coherent platforms which implement DMA-coherent buffers via
+	 * non-cacheable remaps, ops->free() may call vunmap(). Thus arriving
+	 * here in IRQ context is a) at risk of a BUG_ON() or trying to sleep
+	 * on some machines, and b) an indication that the driver is probably
+	 * misusing the coherent API anyway.
+	 */
+	WARN_ON(irqs_disabled());
+
 	if (!ops->free || !cpu_addr)
 		return;
 
-- 
2.17.1.dirty
