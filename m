From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 06/20] dma-noncoherent: add an optional arch hook for
	->get_required_mask
Date: Mon, 30 Jul 2018 18:38:10 +0200
Message-ID: <20180730163824.10064-7-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is need for powerpc for now.  Hopefully we can come up with a clean
generic implementation mid-term.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-noncoherent.h | 6 ++++++
 kernel/dma/Kconfig              | 4 ++++
 kernel/dma/noncoherent.c        | 1 +
 3 files changed, 11 insertions(+)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 10b2654d549b..61394c6e56df 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -17,6 +17,12 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 #define arch_dma_mmap NULL
 #endif /* CONFIG_DMA_NONCOHERENT_MMAP */
 
+#ifdef CONFIG_DMA_NONCOHERENT_GET_REQUIRED
+u64 arch_get_required_mask(struct device *dev);
+#else
+#define arch_get_required_mask NULL
+#endif
+
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..b523104d6199 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -36,6 +36,10 @@ config DMA_NONCOHERENT_MMAP
 	bool
 	depends on DMA_NONCOHERENT_OPS
 
+config DMA_NONCOHERENT_GET_REQUIRED
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 	depends on DMA_NONCOHERENT_OPS
diff --git a/kernel/dma/noncoherent.c b/kernel/dma/noncoherent.c
index 79e9a757387f..cf4ffbe4a09d 100644
--- a/kernel/dma/noncoherent.c
+++ b/kernel/dma/noncoherent.c
@@ -98,5 +98,6 @@ const struct dma_map_ops dma_noncoherent_ops = {
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
+	.get_required_mask	= arch_get_required_mask,
 };
 EXPORT_SYMBOL(dma_noncoherent_ops);
-- 
2.18.0
