From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 01/20] kernel/dma/direct: take DMA offset into account in
	dma_direct_supported
Date: Mon, 30 Jul 2018 18:38:05 +0200
Message-ID: <20180730163824.10064-2-hch@lst.de>
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

When a device has a DMA offset the dma capable result will change due
to the difference between the physical and DMA address.  Take that into
account.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 kernel/dma/direct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8be8106270c2..d32d4f0d2c0c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -167,7 +167,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_ZONE_DMA
-	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		return 0;
 #else
 	/*
@@ -176,14 +176,14 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
 	 * architecture needs to use an IOMMU instead of the direct mapping.
 	 */
-	if (mask < DMA_BIT_MASK(32))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
 	/*
 	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
 	 * if the device itself might support it.
 	 */
-	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+	if (dev->dma_32bit_limit && mask > phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 	return 1;
 }
-- 
2.18.0
