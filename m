From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH] fix flush_tlb_all typo
Date: Mon, 11 Feb 2019 15:50:33 +0000
Message-ID: <20190211155033.7850-1-murphyt7@tcd.ie>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fix typo, flush_tlb_all should be flush_iotlb_all

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..bb4bf1269e5d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,7 +167,7 @@ struct iommu_resv_region {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
+ * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @tlb_range_add: Add a given iova range to the flush queue for this domain
  * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
-- 
2.17.1
