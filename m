From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Date: Mon, 14 Jan 2019 10:41:42 +0100
Message-ID: <20190114094159.27326-3-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

No need for a __KERNEL__ guard outside uapi, make sure we pull in the
includes unconditionally so users can rely on it, and add a missing
comment describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-iommu.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..65aa888c2768 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -16,15 +16,13 @@
 #ifndef __DMA_IOMMU_H
 #define __DMA_IOMMU_H
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#include <asm/errno.h>
-
-#ifdef CONFIG_IOMMU_DMA
+#include <linux/errno.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 
+#ifdef CONFIG_IOMMU_DMA
 int iommu_dma_init(void);
 
 /* Domain management interface for IOMMU drivers */
@@ -74,11 +72,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
-
-struct iommu_domain;
-struct msi_msg;
-struct device;
+#else /* CONFIG_IOMMU_DMA */
 
 static inline int iommu_dma_init(void)
 {
@@ -108,5 +102,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1
