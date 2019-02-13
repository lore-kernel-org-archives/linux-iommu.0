From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/21] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
Date: Wed, 13 Feb 2019 19:29:02 +0100
Message-ID: <20190213182920.16764-4-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Add a Kconfig symbol that indicates an architecture provides a
arch_dma_prep_coherent implementation, and provide a stub otherwise.

This will allow the generic dma-iommu code to it while still allowing
to be built for cache coherent architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/Kconfig              | 1 +
 arch/csky/Kconfig               | 1 +
 include/linux/dma-noncoherent.h | 6 ++++++
 kernel/dma/Kconfig              | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 87ec7be25e97..52175007ffb7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -13,6 +13,7 @@ config ARM64
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_MMAP_PGPROT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..8b84d4362ff6 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,5 +1,6 @@
 config CSKY
 	def_bool y
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 69b36ed31a99..9741767e400f 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
 
+#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
+#else
+static inline void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+}
+#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index bde9179c6ed7..c3b2a5ae2dd4 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -35,6 +35,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	bool
 
+config ARCH_HAS_DMA_PREP_COHERENT
+	bool
+
 config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
 
-- 
2.20.1
