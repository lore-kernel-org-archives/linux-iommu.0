From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] sh: use dma_direct_ops for the CONFIG_DMA_COHERENT case
Date: Wed, 25 Jul 2018 11:40:41 +0200
Message-ID: <20180725094043.32443-4-hch@lst.de>
References: <20180725094043.32443-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725094043.32443-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This is a slight change in behavior as we avoid the detour through the
virtual mapping for the coherent allocator, but if this CPU really is
coherent that should be the right thing to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig                   | 1 +
 arch/sh/include/asm/dma-mapping.h | 4 ++++
 arch/sh/kernel/Makefile           | 4 ++--
 arch/sh/kernel/dma-nommu.c        | 4 ----
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index dd4f3d3e644f..c9993a0cdc7e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -159,6 +159,7 @@ config SWAP_IO_SPACE
 	bool
 
 config DMA_COHERENT
+	select DMA_DIRECT_OPS
 	bool
 
 config DMA_NONCOHERENT
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 149e71f95be7..1ebc6a4eb1c5 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -6,7 +6,11 @@ extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_DMA_NONCOHERENT
 	return &nommu_dma_ops;
+#else
+	return &dma_direct_ops;
+#endif
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index dc80041f7363..cb5f1bfb52de 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -12,7 +12,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 		\
+obj-y	:= debugtraps.o dumpstack.o 		\
 	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
 	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 79a9edafa5b0..d8689b1cb743 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -51,7 +51,6 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
 static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
 			      size_t size, enum dma_data_direction dir)
 {
@@ -67,16 +66,13 @@ static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nelems, i)
 		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 }
-#endif
 
 const struct dma_map_ops nommu_dma_ops = {
 	.alloc			= dma_generic_alloc_coherent,
 	.free			= dma_generic_free_coherent,
 	.map_page		= nommu_map_page,
 	.map_sg			= nommu_map_sg,
-#ifdef CONFIG_DMA_NONCOHERENT
 	.sync_single_for_device	= nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
-#endif
 };
 EXPORT_SYMBOL(nommu_dma_ops);
-- 
2.18.0
