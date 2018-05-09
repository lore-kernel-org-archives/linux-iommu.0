From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/2] alpha: use dma_direct_ops for jensen
Date: Wed,  9 May 2018 16:04:51 +0200
Message-ID: <20180509140452.20716-2-hch@lst.de>
References: <20180509140452.20716-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180509140452.20716-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org, mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The generic dma_direct implementation does the same thing as the alpha
pci-noop implementation, just with more bells and whistles.  And unlike
the current code it at least has a theoretical chance to actually compile.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/alpha/Kconfig                   |  1 +
 arch/alpha/include/asm/dma-mapping.h |  4 ++++
 arch/alpha/kernel/pci-noop.c         | 33 ----------------------------
 3 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..f19dc31288c8 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -211,6 +211,7 @@ config ALPHA_EIGER
 config ALPHA_JENSEN
 	bool "Jensen"
 	depends on BROKEN
+	select DMA_DIRECT_OPS
 	help
 	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
 	  of the first-generation Alpha systems. A number of these systems
diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index b78f61f20796..76ce923ecca1 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -6,7 +6,11 @@ extern const struct dma_map_ops *dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_ALPHA_JENSEN
+	return &dma_direct_ops;
+#else
 	return dma_ops;
+#endif
 }
 
 #endif	/* _ALPHA_DMA_MAPPING_H */
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index b6ebb65127a8..c7c5879869d3 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -102,36 +102,3 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 	else
 		return -ENODEV;
 }
-
-static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp,
-				       unsigned long attrs)
-{
-	void *ret;
-
-	if (!dev || *dev->dma_mask >= 0xffffffffUL)
-		gfp &= ~GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-	if (ret) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-
-static int alpha_noop_supported(struct device *dev, u64 mask)
-{
-	return mask < 0x00ffffffUL ? 0 : 1;
-}
-
-const struct dma_map_ops alpha_noop_ops = {
-	.alloc			= alpha_noop_alloc_coherent,
-	.free			= dma_noop_free_coherent,
-	.map_page		= dma_noop_map_page,
-	.map_sg			= dma_noop_map_sg,
-	.mapping_error		= dma_noop_mapping_error,
-	.dma_supported		= alpha_noop_supported,
-};
-
-const struct dma_map_ops *dma_ops = &alpha_noop_ops;
-EXPORT_SYMBOL(dma_ops);
-- 
2.17.0
