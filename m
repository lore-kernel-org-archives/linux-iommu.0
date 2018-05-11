From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 3/3] arm64: Force swiotlb bounce buffering for non-coherent
	DMA with large CWG
Date: Fri, 11 May 2018 14:55:47 +0100
Message-ID: <20180511135547.34521-4-catalin.marinas@arm.com>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511135547.34521-1-catalin.marinas-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Yang Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On systems with a Cache Writeback Granule (CTR_EL0.CWG) greater than
ARCH_DMA_MINALIGN, DMA cache maintenance on sub-CWG ranges is not safe,
leading to data corruption. If such configuration is detected, the
kernel will force swiotlb bounce buffering for all non-coherent devices.

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Signed-off-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/dma-direct.h | 43 +++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c         | 17 +++++++++++++++
 arch/arm64/mm/init.c                |  3 ++-
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..ef56b2478205 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -17,6 +17,7 @@ config ARM64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 000000000000..0c18a4d56702
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_DMA_DIRECT_H
+#define __ASM_DMA_DIRECT_H
+
+#include <linux/jump_label.h>
+#include <linux/swiotlb.h>
+
+#include <asm/cache.h>
+
+DECLARE_STATIC_KEY_FALSE(swiotlb_noncoherent_bounce);
+
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	dma_addr_t dev_addr = (dma_addr_t)paddr;
+
+	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+}
+
+static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	phys_addr_t paddr = (phys_addr_t)dev_addr;
+
+	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+}
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	/*
+	 * Force swiotlb buffer bouncing when ARCH_DMA_MINALIGN < CWG. The
+	 * swiotlb bounce buffers are aligned to (1 << IO_TLB_SHIFT).
+	 */
+	if (static_branch_unlikely(&swiotlb_noncoherent_bounce) &&
+	    !is_device_dma_coherent(dev) &&
+	    !is_swiotlb_buffer(__dma_to_phys(dev, addr)))
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+#endif /* __ASM_DMA_DIRECT_H */
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a96ec0181818..1e9dac8684ca 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -33,6 +33,7 @@
 #include <asm/cacheflush.h>
 
 static int swiotlb __ro_after_init;
+DEFINE_STATIC_KEY_FALSE(swiotlb_noncoherent_bounce);
 
 static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
@@ -504,6 +505,14 @@ static int __init arm64_dma_init(void)
 	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
 		swiotlb = 1;
 
+	if (WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
+		       TAINT_CPU_OUT_OF_SPEC,
+		       "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
+		       ARCH_DMA_MINALIGN, cache_line_size())) {
+		swiotlb = 1;
+		static_branch_enable(&swiotlb_noncoherent_bounce);
+	}
+
 	return atomic_pool_init();
 }
 arch_initcall(arm64_dma_init);
@@ -882,6 +891,14 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
+	/*
+	 * Enable swiotlb for buffer bouncing if ARCH_DMA_MINALIGN < CWG.
+	 * dma_capable() forces the actual bounce if the device is
+	 * non-coherent.
+	 */
+	if (static_branch_unlikely(&swiotlb_noncoherent_bounce) && !coherent)
+		iommu = NULL;
+
 	if (!dev->dma_ops)
 		dev->dma_ops = &arm64_swiotlb_dma_ops;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f3c47acf8ff..664acf177799 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -586,7 +586,8 @@ static void __init free_unused_memmap(void)
 void __init mem_init(void)
 {
 	if (swiotlb_force == SWIOTLB_FORCE ||
-	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
+	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT) ||
+	    ARCH_DMA_MINALIGN < cache_line_size())
 		swiotlb_init(1);
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
