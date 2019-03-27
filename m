From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/21] dma-iommu: cleanup dma-iommu.h
Date: Wed, 27 Mar 2019 09:04:31 +0100
Message-ID: <20190327080448.5500-5-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

No need for a __KERNEL__ guard outside uapi and add a missing comment
describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-iommu.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..3e206f4ee173 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -16,14 +16,14 @@
 #ifndef __DMA_IOMMU_H
 #define __DMA_IOMMU_H
 
-#ifdef __KERNEL__
+#include <linux/errno.h>
 #include <linux/types.h>
-#include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 
 int iommu_dma_init(void);
 
@@ -74,7 +74,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
+#else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_msg;
@@ -108,5 +108,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1
