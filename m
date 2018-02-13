From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/4] dma-direct: comment the dma_direct_free calling convention
Date: Mon, 12 Feb 2018 17:47:30 -0800
Message-ID: <20180213014731.29742-4-hch@lst.de>
References: <20180213014731.29742-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180213014731.29742-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/dma-direct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index fdc733cf9e30..c9e8e21cb334 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -84,6 +84,10 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	return page_address(page);
 }
 
+/*
+ * NOTE: this function must never look at the dma_addr argument, because we want
+ * to be able to use it as a helper for iommu implementations as well.
+ */
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-- 
2.14.2
