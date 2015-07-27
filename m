From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 01/18] ARM: reduce visibility of dmac_* functions
Date: Mon, 27 Jul 2015 13:28:50 +0100
Message-ID: <E1ZJhWU-00043T-AR@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727122824.GH7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The dmac_* functions are private to the ARM DMA API implementation, and
should not be used by drivers.  In order to discourage their use, remove
their prototypes and macros from asm/*.h.

We have to leave dmac_flush_range() behind as Exynos and MSM IOMMU code
use these; once these sites are fixed, this can be moved also.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 arch/arm/include/asm/cacheflush.h |  4 ----
 arch/arm/include/asm/glue-cache.h |  2 --
 arch/arm/mm/dma-mapping.c         |  1 +
 arch/arm/mm/dma.h                 | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mm/dma.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 4812cda8fd17..c5230a44eeca 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -140,8 +140,6 @@ extern struct cpu_cache_fns cpu_cache;
  * is visible to DMA, or data written by DMA to system memory is
  * visible to the CPU.
  */
-#define dmac_map_area			cpu_cache.dma_map_area
-#define dmac_unmap_area			cpu_cache.dma_unmap_area
 #define dmac_flush_range		cpu_cache.dma_flush_range
 
 #else
@@ -161,8 +159,6 @@ extern void __cpuc_flush_dcache_area(void *, size_t);
  * is visible to DMA, or data written by DMA to system memory is
  * visible to the CPU.
  */
-extern void dmac_map_area(const void *, size_t, int);
-extern void dmac_unmap_area(const void *, size_t, int);
 extern void dmac_flush_range(const void *, const void *);
 
 #endif
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index a3c24cd5b7c8..cab07f69382d 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -158,8 +158,6 @@ static inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
 #define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
 #define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
 
-#define dmac_map_area			__glue(_CACHE,_dma_map_area)
-#define dmac_unmap_area			__glue(_CACHE,_dma_unmap_area)
 #define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
 #endif
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index cba12f34ff77..b7998df043ef 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -39,6 +39,7 @@
 #include <asm/system_info.h>
 #include <asm/dma-contiguous.h>
 
+#include "dma.h"
 #include "mm.h"
 
 /*
diff --git a/arch/arm/mm/dma.h b/arch/arm/mm/dma.h
new file mode 100644
index 000000000000..70ea6852f94e
--- /dev/null
+++ b/arch/arm/mm/dma.h
@@ -0,0 +1,32 @@
+#ifndef DMA_H
+#define DMA_H
+
+#include <asm/glue-cache.h>
+
+#ifndef MULTI_CACHE
+#define dmac_map_area			__glue(_CACHE,_dma_map_area)
+#define dmac_unmap_area 		__glue(_CACHE,_dma_unmap_area)
+
+/*
+ * These are private to the dma-mapping API.  Do not use directly.
+ * Their sole purpose is to ensure that data held in the cache
+ * is visible to DMA, or data written by DMA to system memory is
+ * visible to the CPU.
+ */
+extern void dmac_map_area(const void *, size_t, int);
+extern void dmac_unmap_area(const void *, size_t, int);
+
+#else
+
+/*
+ * These are private to the dma-mapping API.  Do not use directly.
+ * Their sole purpose is to ensure that data held in the cache
+ * is visible to DMA, or data written by DMA to system memory is
+ * visible to the CPU.
+ */
+#define dmac_map_area			cpu_cache.dma_map_area
+#define dmac_unmap_area 		cpu_cache.dma_unmap_area
+
+#endif
+
+#endif
-- 
2.1.0
