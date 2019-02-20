From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] iommu: Document iommu_ops.iotlb_sync_map()
Date: Wed, 20 Feb 2019 14:00:52 +0100
Message-ID: <20190220130053.784-3-geert+renesas@glider.be>
References: <20190220130053.784-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Add missing kerneldoc for iommu_ops.iotlb_sync_map().

Fixes: 1d7ae53b152dbc5b ("iommu: Introduce iotlb_sync_map callback")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 848fb07026b67169..3ed5d372b090af54 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -169,6 +169,7 @@ struct iommu_resv_region {
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_range_add: Add a given iova range to the flush queue for this domain
+ * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
  * @iova_to_phys: translate iova to physical address
-- 
2.17.1
