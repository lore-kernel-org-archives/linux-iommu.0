From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH, RFC] unicore32: remove swiotlb support
Date: Thu, 27 Sep 2018 06:54:34 -0700
Message-ID: <20180927135434.6866-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@pku.edu.cn>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

unicore32 is a bog standard 32-bit port without larger physical address
space, highmem or any other obvious addressing limitation.  There should
be no need to bounce buffer using swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Guan, can you double check my assumptions?  I really can't find a
reason why unicore32 would need swiotlb.

 arch/unicore32/Kconfig                   |  2 +-
 arch/unicore32/include/asm/Kbuild        |  1 +
 arch/unicore32/include/asm/dma-mapping.h | 22 ----------------------
 arch/unicore32/mm/init.c                 |  3 ---
 4 files changed, 2 insertions(+), 26 deletions(-)
 delete mode 100644 arch/unicore32/include/asm/dma-mapping.h

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 60eae744d8fd..3a3b40f79558 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -4,6 +4,7 @@ config UNICORE32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select DMA_DIRECT_OPS
 	select HAVE_MEMBLOCK
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
@@ -20,7 +21,6 @@ config UNICORE32
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
-	select SWIOTLB
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index bfc7abe77905..1372553dc0a9 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += compat.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
deleted file mode 100644
index 790bc2ef4af2..000000000000
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * linux/arch/unicore32/include/asm/dma-mapping.h
- *
- * Code specific to PKUnity SoC and UniCore ISA
- *
- * Copyright (C) 2001-2010 GUAN Xue-tao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __UNICORE_DMA_MAPPING_H__
-#define __UNICORE_DMA_MAPPING_H__
-
-#include <linux/swiotlb.h>
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &swiotlb_dma_ops;
-}
-
-#endif
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index f4950fbfe574..5f72a8d1d953 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -234,9 +234,6 @@ void __init bootmem_init(void)
 
 	uc32_bootmem_init(min, max_low);
 
-#ifdef CONFIG_SWIOTLB
-	swiotlb_init(1);
-#endif
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
-- 
2.19.0
