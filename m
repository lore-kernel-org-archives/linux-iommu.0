From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
Date: Tue, 28 Jun 2016 17:18:57 +0100
Message-ID: <ac9b11493dfa3500889268488adfa8d4d5c34962.1467129314.git.robin.murphy@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Certain peripherals may be bestowed with knowledge of the physical
memory map of the system in which they live, and refuse to handle
addresses that they do not think are memory, which causes issues when
remapping to arbitrary IOVAs. Sidestep the issue by restricting IOVA
domains to only allocate addresses within ranges which match the
physical memory layout.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Posting this as an RFC because it's something I've been having to use
on Juno for all the PCI IOMMU development - it's pretty horrible, but I
can't easily think of a nicer solution...

 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..2385fab382d8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -74,6 +75,23 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static void iova_match_mem(struct iova_domain *iovad)
+{
+	struct memblock_region *reg;
+	unsigned long blk, base = iovad->start_pfn;
+	unsigned long shift = iova_shift(iovad);
+
+	for_each_memblock(memory, reg) {
+		blk = (reg->base + iova_mask(iovad)) >> shift;
+		if (blk > base)
+			reserve_iova(iovad, base, blk - 1);
+		base = (reg->base + reg->size) >> shift;
+	}
+	blk = -1UL >> shift;
+	if (blk > base)
+		reserve_iova(iovad, base, blk);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -123,6 +141,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 		iovad->dma_32bit_pfn = end_pfn;
 	} else {
 		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+		iova_match_mem(iovad);
 	}
 	return 0;
 }
-- 
2.8.1.dirty
