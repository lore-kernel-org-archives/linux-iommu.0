From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/2] kernel/dma/direct: take DMA offset into account in
	dma_direct_supported
Date: Fri, 24 Aug 2018 08:53:23 +0200
Message-ID: <20180824065324.654-2-hch@lst.de>
References: <20180824065324.654-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180824065324.654-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When a device has a DMA offset the dma capable result will change due
to the difference between the physical and DMA address.  Take that into
account.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
 kernel/dma/direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1c35b7b945d0..de87b0282e74 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -168,7 +168,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_ZONE_DMA
-	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		return 0;
 #else
 	/*
@@ -177,7 +177,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
 	 * architecture needs to use an IOMMU instead of the direct mapping.
 	 */
-	if (mask < DMA_BIT_MASK(32))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
 	/*
-- 
2.18.0
