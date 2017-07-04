From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 2/2] iommu/dma: Use __GFP_NOWARN only for high-order
	allocations
Date: Tue,  4 Jul 2017 22:55:56 +0900
Message-ID: <20170704135556.21704-2-tfiga@chromium.org>
References: <20170704135556.21704-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170704135556.21704-1-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Memory allocation routines are expected to report allocation errors to
kernel log. However, current implementation of __iommu_dma_alloc_pages()
adds __GFP_NOWARN for all calls to alloc_pages(), which completely
disables any logging.

Fix it by adding __GFP_NOWARN only to high order allocation attempts,
which are not critical.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Changes from v1:
 - Fix typo in subject.
 - Add Robin's Reviewed-by.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index bf23989b5158..6ed8c8f941d8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -433,6 +433,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
+	const gfp_t high_order_gfp = __GFP_NOWARN | __GFP_NORETRY;
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
@@ -452,8 +453,6 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 	if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
 		gfp |= __GFP_HIGHMEM;
 
-	gfp |= __GFP_NOWARN;
-
 	while (count) {
 		struct page *page = NULL;
 		unsigned int order_size;
@@ -469,7 +468,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 
 			order_size = 1U << order;
 			page = alloc_pages((order_mask - order_size) ?
-					   gfp | __GFP_NORETRY : gfp, order);
+					   gfp | high_order_gfp : gfp, order);
 			if (!page)
 				continue;
 			if (!order)
-- 
2.13.2.725.g09c95d1e9-goog
