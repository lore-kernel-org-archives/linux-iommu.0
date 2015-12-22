From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/23] iommu/amd: Remove 'start' parameter from
	dma_ops_area_alloc
Date: Tue, 22 Dec 2015 23:21:16 +0100
Message-ID: <1450822888-22590-12-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Parameter is not needed because the value is part of the
already passed in struct dma_ops_domain.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index eb11996..2962c62 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1561,11 +1561,10 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 					struct dma_ops_domain *dom,
 					unsigned int pages,
 					unsigned long align_mask,
-					u64 dma_mask,
-					unsigned long start)
+					u64 dma_mask)
 {
 	int max_index = dom->aperture_size >> APERTURE_RANGE_SHIFT;
-	int i = start >> APERTURE_RANGE_SHIFT;
+	int i = dom->next_address >> APERTURE_RANGE_SHIFT;
 	unsigned long next_bit, boundary_size, mask;
 	unsigned long address = -1;
 
@@ -1612,13 +1611,12 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 	dom->need_flush = true;
 #endif
 
-	address = dma_ops_area_alloc(dev, dom, pages, align_mask,
-				     dma_mask, dom->next_address);
+	address = dma_ops_area_alloc(dev, dom, pages, align_mask, dma_mask);
 
 	if (address == -1) {
 		dom->next_address = 0;
 		address = dma_ops_area_alloc(dev, dom, pages, align_mask,
-					     dma_mask, 0);
+					     dma_mask);
 		dom->need_flush = true;
 	}
 
-- 
1.9.1
