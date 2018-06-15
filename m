From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 02/25] MIPS: simplify CONFIG_DMA_NONCOHERENT ifdefs
Date: Fri, 15 Jun 2018 13:08:31 +0200
Message-ID: <20180615110854.19253-3-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615110854.19253-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

CONFIG_DMA_MAYBE_COHERENT already selects CONFIG_DMA_NONCOHERENT, so we
can remove the extra conditions.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reviewed-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
---
 arch/mips/include/asm/io.h | 4 ++--
 arch/mips/mm/c-r4k.c       | 4 ++--
 arch/mips/mm/cache.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a7d0b836f2f7..6d6bdc6a48eb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -588,7 +588,7 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int
  *
  * This API used to be exported; it now is for arch code internal use only.
  */
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 extern void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 extern void (*_dma_cache_wback)(unsigned long start, unsigned long size);
@@ -607,7 +607,7 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define dma_cache_inv(start,size)	\
 	do { (void) (start); (void) (size); } while (0)
 
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
  * Read a 32-bit register that requires a 64-bit read cycle on the bus.
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e12dfa48b478..b83ecfb2fbfc 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -830,7 +830,7 @@ static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
 	return __r4k_flush_icache_range(start, end, true);
 }
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
@@ -904,7 +904,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	bc_inv(addr, size);
 	__sync();
 }
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 struct flush_cache_sigtramp_args {
 	struct mm_struct *mm;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 0d3c656feba0..70a523151ff3 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 EXPORT_SYMBOL(flush_icache_all);
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
+#ifdef CONFIG_DMA_NONCOHERENT
 
 /* DMA cache operations. */
 void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
@@ -65,7 +65,7 @@ void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 EXPORT_SYMBOL(_dma_cache_wback_inv);
 
-#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
  * We could optimize the case where the cache argument is not BCACHE but
-- 
2.17.1
