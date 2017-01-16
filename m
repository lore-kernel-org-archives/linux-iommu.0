From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/2] iommu/dma: Stop getting dma_32bit_pfn wrong
Date: Mon, 16 Jan 2017 13:24:54 +0000
Message-ID: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
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
allocating from a subset of the available 64-bit space.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Sending this as a v2 since both patches have been seen before, and #1 is
ever so slightly tweaked. #2 applies on top of Eric's MSI series, since
that seems ready to go now - there is a trivial merge conflict otherwise
around the extra argument in the __alloc_iova() call.

Robin.

 drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de41ead6542a..9aa432e8fbd3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -203,6 +203,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
+	bool pci = dev && dev_is_pci(dev);
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -225,19 +226,31 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		end_pfn = min_t(unsigned long, end_pfn,
 				domain->geometry.aperture_end >> order);
 	}
+	/*
+	 * PCI devices may have larger DMA masks, but still prefer allocating
+	 * within a 32-bit mask to avoid DAC addressing. Such limitations don't
+	 * apply to the typical platform device, so for those we may as well
+	 * leave the cache limit at the top of their range to save an rb_last()
+	 * traversal on every allocation.
+	 */
+	if (pci)
+		end_pfn &= DMA_BIT_MASK(32) >> order;
 
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
