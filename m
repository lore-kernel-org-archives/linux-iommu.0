From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/3] dma-mapping: clear dma_ops pointer also on ARM
Date: Thu, 13 Sep 2018 17:17:15 +0200
Message-ID: <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-renesas-soc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: iommu@lists.linux-foundation.org

The generic fallback of arch_teardown_dma_ops() clears the dma_ops
pointer but the ARM specific version does not. Rename the generic one,
so it can be called from ARM specific one, too. This will ensure
consistent behaviour.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mm/dma-mapping.c   | 6 +++---
 include/linux/dma-mapping.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e3b04786838f..466b0242e8af 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2396,8 +2396,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	if (!dev->archdata.dma_ops_setup)
-		return;
+	if (dev->archdata.dma_ops_setup)
+		arm_teardown_iommu_dma_ops(dev);
 
-	arm_teardown_iommu_dma_ops(dev);
+	generic_teardown_dma_ops(dev);
 }
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eafd6f318e78..020512cb7f0e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -663,11 +663,12 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      bool coherent) { }
 #endif
 
-#ifndef arch_teardown_dma_ops
-static inline void arch_teardown_dma_ops(struct device *dev)
+static inline void generic_teardown_dma_ops(struct device *dev)
 {
 	dev->dma_ops = NULL;
 }
+#ifndef arch_teardown_dma_ops
+#define arch_teardown_dma_ops generic_teardown_dma_ops
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.18.0
