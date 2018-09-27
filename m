From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
Date: Thu, 27 Sep 2018 15:35:38 -0700
Message-ID: <20180927223539.28449-5-hch@lst.de>
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

Instead of rejecting devices with a too small bus_dma_mask we can handle
by taking the bus dma_mask into account for allocations and bounce
buffering decisions.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-direct.h |  3 ++-
 kernel/dma/direct.c        | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b79496d8c75b..fbca184ff5a0 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -27,7 +27,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index e78548397a92..60c433b880e0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -44,10 +44,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 			return false;
 		}
 
-		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
+		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
 			dev_err(dev,
-				"%s: overflow %pad+%zu of device mask %llx\n",
-				caller, &dma_addr, size, *dev->dma_mask);
+				"%s: overflow %pad+%zu of device mask %llx bus mask %llx\n",
+				caller, &dma_addr, size,
+				*dev->dma_mask, dev->bus_dma_mask);
 		}
 		return false;
 	}
@@ -66,12 +67,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
+	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
+		max_dma = dev->bus_dma_mask;
+
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 		u64 *phys_mask)
 {
+	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
+		dma_mask = dev->bus_dma_mask;
+
 	if (force_dma_unencrypted())
 		*phys_mask = __dma_to_phys(dev, dma_mask);
 	else
@@ -88,7 +95,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
-			dev->coherent_dma_mask;
+			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -292,12 +299,6 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
-	/*
-	 * Upstream PCI/PCIe bridges or SoC interconnects may not carry
-	 * as many DMA address bits as the device itself supports.
-	 */
-	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
-		return 0;
 	return 1;
 }
 
-- 
2.19.0
