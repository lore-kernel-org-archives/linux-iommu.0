From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] dma-mapping: Relax warning for per-device areas
Date: Mon, 23 Jul 2018 22:42:48 +0100
Message-ID: <392ab8fa5a089cf8469cbeb8ce43d656d8a9801d.1532382039.git.robin.murphy@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
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

Therefore, let's move the irqs_disabled() check down past the per-device
area hook, so that that gets a chance to resolve the request before we
reach definite "you're doing it wrong" territory.

Reported-by: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Tested-by: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/dma-mapping.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f9cc309507d9..1db6a6b46d0d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -538,10 +538,17 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!ops);
-	WARN_ON(irqs_disabled());
 
 	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
 		return;
+	/*
+	 * On non-coherent platforms which implement DMA-coherent buffers via
+	 * non-cacheable remaps, ops->free() may call vunmap(). Thus getting
+	 * this far in IRQ context is a) at risk of a BUG_ON() or trying to
+	 * sleep on some machines, and b) an indication that the driver is
+	 * probably misusing the coherent API anyway.
+	 */
+	WARN_ON(irqs_disabled());
 
 	if (!ops->free || !cpu_addr)
 		return;
-- 
2.17.1.dirty
