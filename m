From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/4] dma-direct: mark as is_phys
Date: Mon, 12 Feb 2018 17:47:29 -0800
Message-ID: <20180213014731.29742-3-hch@lst.de>
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

Various PCI_DMA_BUS_IS_PHYS implementations rely on this flag to make proper
decisions for block and networking addressability.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 lib/dma-direct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 40b1f92f2214..fdc733cf9e30 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -152,5 +152,6 @@ const struct dma_map_ops dma_direct_ops = {
 	.map_sg			= dma_direct_map_sg,
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
+	.is_phys		= 1,
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
2.14.2
