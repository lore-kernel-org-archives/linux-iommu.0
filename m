From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal page
	allocations
Date: Tue, 26 Mar 2019 16:01:27 -0700
Message-ID: <20190326230131.16275-2-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190326230131.16275-1-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a90f298af96..febaf637a25b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -589,6 +589,8 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	void *ptr = NULL;
 
 	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
+	if (!page)
+		page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
@@ -600,7 +602,8 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	if (PageHighMem(page)) {
 		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
 		if (!ptr) {
-			dma_release_from_contiguous(dev, page, count);
+			if (!dma_release_from_contiguous(dev, page, count))
+				__free_pages(page, get_order(size));
 			return NULL;
 		}
 	} else {
@@ -622,7 +625,8 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 		else
 			__dma_remap(page, size, PAGE_KERNEL);
 	}
-	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
 }
 
 static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
@@ -1295,6 +1299,8 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, order);
 		if (!page)
 			goto error;
 
@@ -1369,7 +1375,8 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 	int i;
 
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		dma_release_from_contiguous(dev, pages[0], count);
+		if (!dma_release_from_contiguous(dev, pages[0], count))
+			__free_pages(page[0], get_order(size));
 	} else {
 		for (i = 0; i < count; i++)
 			if (pages[i])
-- 
2.17.1
