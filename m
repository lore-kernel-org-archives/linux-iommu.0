From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] iommu: Fix kerneldoc for iommu_ops.flush_iotlb_all()
Date: Wed, 20 Feb 2019 14:00:51 +0100
Message-ID: <20190220130053.784-2-geert+renesas@glider.be>
References: <20190220130053.784-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

While the API wrapper is called iommu_flush_tlb_all(), the actual
iommu_ops method is called .flush_iotlb_all(), not .flush_tlb_all().

Fixes: add02cfdc9bc2987 ("iommu: Introduce Interface for IOMMU TLB Flushing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 477ef47c357c0553..848fb07026b67169 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,7 +167,7 @@ struct iommu_resv_region {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
+ * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_range_add: Add a given iova range to the flush queue for this domain
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
-- 
2.17.1
