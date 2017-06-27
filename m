From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] iommu/dma: Respect __GFP_DMA and __GFP_DMA32 in incoming
	GFP flags
Date: Tue, 27 Jun 2017 16:28:11 +0900
Message-ID: <20170627072812.15316-1-tfiga@chromium.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Current implementation of __iommu_dma_alloc_pages() keeps adding
__GFP_HIGHMEM to GFP flags regardless of whether other zone flags are
already included in the incoming flags. If __GFP_DMA or __GFP_DMA32 is
set at the same time as __GFP_HIGHMEM, the allocation fails due to
invalid zone flag combination.

Fix this by checking for __GFP_DMA and __GFP_DMA32 in incoming GFP flags
and adding __GFP_HIGHMEM only if they are not present.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..29965a092a69 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -445,8 +445,14 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 	if (!pages)
 		return NULL;
 
-	/* IOMMU can map any pages, so himem can also be used here */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	/*
+	 * IOMMU can map any pages, so himem can also be used here,
+	 * unless another DMA zone is explicitly requested.
+	 */
+	if (!(gfp & (__GFP_DMA | __GFP_DMA32)))
+		gfp |= __GFP_HIGHMEM;
+
+	gfp |= __GFP_NOWARN;
 
 	while (count) {
 		struct page *page = NULL;
-- 
2.13.1.611.g7e3b11ae1-goog
