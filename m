From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/9] iommu/amd: Remove map_sg_no_iommu()
Date: Tue,  9 Apr 2013 22:12:56 +0200
Message-ID: <1365538384-12426-2-git-send-email-joro@8bytes.org>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

This function was intended as a fall-back if the map_sg
function is called for a device not mapped by the IOMMU.
Since the AMD IOMMU driver uses per-device dma_ops this can
never happen. So this function isn't needed anymore.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b287ca3..3b2aff0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2839,24 +2839,6 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 }
 
 /*
- * This is a special map_sg function which is used if we should map a
- * device which is not handled by an AMD IOMMU in the system.
- */
-static int map_sg_no_iommu(struct device *dev, struct scatterlist *sglist,
-			   int nelems, int dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sglist, s, nelems, i) {
-		s->dma_address = (dma_addr_t)sg_phys(s);
-		s->dma_length  = s->length;
-	}
-
-	return nelems;
-}
-
-/*
  * The exported map_sg function for dma_ops (handles scatter-gather
  * lists).
  */
@@ -2875,9 +2857,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	INC_STATS_COUNTER(cnt_map_sg);
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return map_sg_no_iommu(dev, sglist, nelems, dir);
-	else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return 0;
 
 	dma_mask = *dev->dma_mask;
-- 
1.7.9.5
