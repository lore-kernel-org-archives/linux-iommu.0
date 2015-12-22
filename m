From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/23] iommu/amd: Optimize dma_ops_free_addresses
Date: Tue, 22 Dec 2015 23:21:21 +0100
Message-ID: <1450822888-22590-17-git-send-email-joro@8bytes.org>
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

Don't flush the iommu tlb when we free something behind the
current next_bit pointer. Update the next_bit pointer
instead and let the flush happen on the next wraparound in
the allocation path.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 39a2048..c657e48 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1633,8 +1633,7 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 		return;
 #endif
 
-	if (amd_iommu_unmap_flush ||
-	    (address + pages > range->next_bit)) {
+	if (amd_iommu_unmap_flush) {
 		domain_flush_tlb(&dom->domain);
 		domain_flush_complete(&dom->domain);
 	}
@@ -1642,6 +1641,8 @@ static void dma_ops_free_addresses(struct dma_ops_domain *dom,
 	address = (address % APERTURE_RANGE_SIZE) >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&range->bitmap_lock, flags);
+	if (address + pages > range->next_bit)
+		range->next_bit = address + pages;
 	bitmap_clear(range->bitmap, address, pages);
 	spin_unlock_irqrestore(&range->bitmap_lock, flags);
 
-- 
1.9.1
