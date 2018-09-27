From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date: Thu, 27 Sep 2018 15:35:39 -0700
Message-ID: <20180927223539.28449-6-hch@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180927223539.28449-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This way an architecture with less than 4G of RAM can support dma_mask
smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
case on powerpc.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 kernel/dma/direct.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 60c433b880e0..170bd322a94a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -284,21 +284,25 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	return nents;
 }
 
+/*
+ * Because 32-bit DMA masks are so common we expect every architecture to be
+ * able to satisfy them - either by not supporting more physical memory, or by
+ * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
+ * use an IOMMU instead of the direct mapping.
+ */
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-#ifdef CONFIG_ZONE_DMA
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
-		return 0;
-#else
-	/*
-	 * Because 32-bit DMA masks are so common we expect every architecture
-	 * to be able to satisfy them - either by not supporting more physical
-	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
-	 * architecture needs to use an IOMMU instead of the direct mapping.
-	 */
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
+	u64 min_mask;
+
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
+	else
+		min_mask = DMA_BIT_MASK(32);
+
+	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
+
+	if (mask >= phys_to_dma(dev, min_mask))
 		return 0;
-#endif
 	return 1;
 }
 
-- 
2.19.0
