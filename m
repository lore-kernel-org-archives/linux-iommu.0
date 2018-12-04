From: Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and tlb_sync to iotlb_sync
Date: Tue,  4 Dec 2018 18:27:34 +0000
Message-ID: <20181204182734.20184-1-murphyt7@tcd.ie>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: tom <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: tom <murphyt7@tcd.ie>

Someone forgot to update this comment.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 include/linux/iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..11db18b9ffe8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -168,8 +168,8 @@ struct iommu_resv_region {
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
- * @tlb_range_add: Add a given iova range to the flush queue for this domain
- * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
+ * @iotlb_range_add: Add a given iova range to the flush queue for this domain
+ * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
-- 
2.11.0
