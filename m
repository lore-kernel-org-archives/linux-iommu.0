From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/dma: Stop getting dma_32bit_pfn wrong
Date: Fri, 11 Nov 2016 18:30:45 +0000
Message-ID: <f9c96106e6253f7033be8dd975392f0edb12e603.1478889045.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu_dma_init_domain() was originally written under the misconception
that dma_32bit_pfn represented some sort of size limit for IOVA domains.
Since the truth is almost the exact opposite of that, rework the logic
and comments to reflect its real purpose of optimising lookups when
allocating from a subset of the available space.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab8667e6f2..ae045a14b530 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -139,6 +139,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 {
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long order, base_pfn, end_pfn;
+	bool pci = dev && dev_is_pci(dev);
 
 	if (!iovad)
 		return -ENODEV;
@@ -161,19 +162,31 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		end_pfn = min_t(unsigned long, end_pfn,
 				domain->geometry.aperture_end >> order);
 	}
+	/*
+	 * PCI devices may have larger DMA masks, but still prefer allocating
+	 * within a 32-bit mask to avoid DAC addressing. Such limitations don't
+	 * apply to the typical platform device, so for those we may as well
+	 * leave the cache limit at the top of the range they're likely to use.
+	 */
+	if (pci)
+		end_pfn = min_t(unsigned long, end_pfn,
+				DMA_BIT_MASK(32) >> order);
 
-	/* All we can safely do with an existing domain is enlarge it */
+	/* start_pfn is always nonzero for an already-initialised domain */
 	if (iovad->start_pfn) {
 		if (1UL << order != iovad->granule ||
-		    base_pfn != iovad->start_pfn ||
-		    end_pfn < iovad->dma_32bit_pfn) {
+		    base_pfn != iovad->start_pfn) {
 			pr_warn("Incompatible range for DMA domain\n");
 			return -EFAULT;
 		}
-		iovad->dma_32bit_pfn = end_pfn;
+		/*
+		 * If we have devices with different DMA masks, move the free
+		 * area cache limit down for the benefit of the smaller one.
+		 */
+		iovad->dma_32bit_pfn = min(end_pfn, iovad->dma_32bit_pfn);
 	} else {
 		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
-		if (dev && dev_is_pci(dev))
+		if (pci)
 			iova_reserve_pci_windows(to_pci_dev(dev), iovad);
 	}
 	return 0;
-- 
2.10.2.dirty
