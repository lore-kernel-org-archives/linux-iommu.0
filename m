From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/6] MIPS: don't select DMA_MAYBE_COHERENT from
	DMA_PERDEV_COHERENT
Date: Fri, 14 Sep 2018 11:58:04 +0200
Message-ID: <20180914095808.22202-3-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180914095808.22202-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

While both option select a form of conditional dma coherence they don't
actually share any code in the implementation, so untangle them.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
---
 arch/mips/Kconfig        |  2 +-
 arch/mips/kernel/setup.c |  2 +-
 arch/mips/mm/c-r4k.c     | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..0b25180028b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1111,7 +1111,7 @@ config DMA_MAYBE_COHERENT
 
 config DMA_PERDEV_COHERENT
 	bool
-	select DMA_MAYBE_COHERENT
+	select DMA_NONCOHERENT
 
 config DMA_NONCOHERENT
 	bool
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb7da59..6d840a44fa36 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1067,7 +1067,7 @@ static int __init debugfs_mips(void)
 arch_initcall(debugfs_mips);
 #endif
 
-#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
+#ifdef CONFIG_DMA_MAYBE_COHERENT
 /* User defined DMA coherency from command line. */
 enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
 EXPORT_SYMBOL_GPL(coherentio);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a9ef057c79fe..05bd77727fb9 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1955,22 +1955,21 @@ void r4k_cache_init(void)
 	__flush_icache_user_range	= r4k_flush_icache_user_range;
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
-# if defined(CONFIG_DMA_PERDEV_COHERENT)
-	if (0) {
-# else
-	if ((coherentio == IO_COHERENCE_ENABLED) ||
-	    ((coherentio == IO_COHERENCE_DEFAULT) && hw_coherentio)) {
-# endif
+#ifdef CONFIG_DMA_NONCOHERENT
+#ifdef CONFIG_DMA_MAYBE_COHERENT
+	if (coherentio == IO_COHERENCE_ENABLED ||
+	    (coherentio == IO_COHERENCE_DEFAULT && hw_coherentio)) {
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
 		_dma_cache_inv		= (void *)cache_noop;
-	} else {
+	} else
+#endif /* CONFIG_DMA_MAYBE_COHERENT */
+	{
 		_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
 		_dma_cache_wback	= r4k_dma_cache_wback_inv;
 		_dma_cache_inv		= r4k_dma_cache_inv;
 	}
-#endif
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 	build_clear_page();
 	build_copy_page();
-- 
2.18.0
