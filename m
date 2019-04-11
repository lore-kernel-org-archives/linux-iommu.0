From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dma-mapping: remove the dma_get_sgtable API comments from arm to common code
Date: Thu, 11 Apr 2019 09:11:16 +0200
Message-ID: <20190411071116.29862-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The comments are spot on and should be near the central API, not just
near a single implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 11 -----------
 kernel/dma/mapping.c      | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 43f46aa7ef33..6e7a4574d4da 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -898,17 +898,6 @@ static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_add
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
-/*
- * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
- * that the intention is to allow exporting memory allocated via the
- * coherent DMA APIs through the dma_buf API, which only accepts a
- * scattertable.  This presents a couple of problems:
- * 1. Not all memory allocated via the coherent DMA APIs is backed by
- *    a struct page
- * 2. Passing coherent DMA memory into the streaming APIs is not allowed
- *    as we will try to flush the memory through a different alias to that
- *    actually being used (and the flushes are redundant.)
- */
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c000906348c9..21352da4929e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -131,6 +131,17 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
+/*
+ * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
+ * that the intention is to allow exporting memory allocated via the
+ * coherent DMA APIs through the dma_buf API, which only accepts a
+ * scattertable.  This presents a couple of problems:
+ * 1. Not all memory allocated via the coherent DMA APIs is backed by
+ *    a struct page
+ * 2. Passing coherent DMA memory into the streaming APIs is not allowed
+ *    as we will try to flush the memory through a different alias to that
+ *    actually being used (and the flushes are redundant.)
+ */
 int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
-- 
2.20.1
