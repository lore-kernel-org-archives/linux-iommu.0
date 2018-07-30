From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 02/20] kernel/dma/direct: refine dma_direct_alloc zone
	selection
Date: Mon, 30 Jul 2018 18:38:06 +0200
Message-ID: <20180730163824.10064-3-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We need to take the DMA offset and encryption bit into account when selecting
a zone.  Add a helper that takes those into account and use it.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 kernel/dma/direct.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d32d4f0d2c0c..c2c1df8827f2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -58,6 +58,14 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 	return addr + size - 1 <= dev->coherent_dma_mask;
 }
 
+static bool dma_coherent_below(struct device *dev, u64 mask)
+{
+	dma_addr_t addr = force_dma_unencrypted() ?
+		__phys_to_dma(dev, mask) : phys_to_dma(dev, mask);
+
+	return dev->coherent_dma_mask <= addr;
+}
+
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -70,9 +78,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	gfp &= ~__GFP_ZERO;
 
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (dma_coherent_below(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		gfp |= GFP_DMA;
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
+	if (dma_coherent_below(dev, DMA_BIT_MASK(32) && !(gfp & GFP_DMA)))
 		gfp |= GFP_DMA32;
 
 again:
@@ -92,14 +100,14 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
+		    dma_coherent_below(dev, DMA_BIT_MASK(64)) &&
 		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
 			gfp |= GFP_DMA32;
 			goto again;
 		}
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    dma_coherent_below(dev, DMA_BIT_MASK(32)) &&
 		    !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
-- 
2.18.0
