From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] dma-mapping: add a kconfig symbol for arch_teardown_dma_ops availability
Date: Mon,  4 Feb 2019 09:14:20 +0100
Message-ID: <20190204081420.15083-3-hch@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Cc: linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                     |  1 +
 arch/arm/include/asm/dma-mapping.h   |  5 -----
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h |  5 -----
 include/linux/dma-mapping.h          | 10 +++++++---
 kernel/dma/Kconfig                   |  3 +++
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1cf44f00870..4bb36ae71b14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -16,6 +16,7 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
+	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a224b6e39e58..03ba90ffc0f8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -96,11 +96,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-#ifdef CONFIG_MMU
-#define arch_teardown_dma_ops arch_teardown_dma_ops
-extern void arch_teardown_dma_ops(struct device *dev);
-#endif
-
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 63909f318d56..87ec7be25e97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index de96507ee2c1..de98191e4c7d 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -29,11 +29,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#ifdef CONFIG_IOMMU_DMA
-void arch_teardown_dma_ops(struct device *dev);
-#define arch_teardown_dma_ops	arch_teardown_dma_ops
-#endif
-
 /*
  * Do not use this function in a driver, it is only provided for
  * arch/arm/mm/xen.c, which is used by arm64 as well.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2b20d60e6158..4210c5c1dd21 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -681,9 +681,13 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 }
 #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
 
-#ifndef arch_teardown_dma_ops
-static inline void arch_teardown_dma_ops(struct device *dev) { }
-#endif
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev);
+#else
+static inline void arch_teardown_dma_ops(struct device *dev)
+{
+}
+#endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c44599d128e8..77a352259796 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -22,6 +22,9 @@ config HAVE_GENERIC_DMA_COHERENT
 config ARCH_HAS_SETUP_DMA_OPS
 	bool
 
+config ARCH_HAS_TEARDOWN_DMA_OPS
+	bool
+
 config ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	bool
 
-- 
2.20.1
