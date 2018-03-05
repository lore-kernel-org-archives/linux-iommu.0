From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/13] x86: remove dma_alloc_coherent_gfp_flags
Date: Mon,  5 Mar 2018 09:46:51 -0800
Message-ID: <20180305174655.9878-10-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180305174655.9878-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

All dma_ops implementations used on x86 now take care of setting their own
required GFP_ masks for the allocation.  And given that the common code
now clears harmful flags itself that means we can stop the flags in all
the iommu implementations as well.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/x86/include/asm/dma-mapping.h | 11 -----------
 arch/x86/kernel/pci-calgary_64.c   |  2 --
 arch/x86/kernel/pci-dma.c          |  2 --
 arch/x86/mm/mem_encrypt.c          |  7 -------
 4 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index df9816b385eb..89ce4bfd241f 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -36,15 +36,4 @@ int arch_dma_supported(struct device *dev, u64 mask);
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
-static inline gfp_t dma_alloc_coherent_gfp_flags(struct device *dev, gfp_t gfp)
-{
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
-		gfp |= GFP_DMA;
-#ifdef CONFIG_X86_64
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
-		gfp |= GFP_DMA32;
-#endif
-       return gfp;
-}
-
 #endif
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 5647853053bd..bbfc8b1e9104 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -446,8 +446,6 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 	npages = size >> PAGE_SHIFT;
 	order = get_order(size);
 
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-
 	/* alloc enough pages (and possibly more) */
 	ret = (void *)__get_free_pages(flag, order);
 	if (!ret)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index db0b88ea8d1b..14437116ffea 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -82,8 +82,6 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp)
 	if (!*dev)
 		*dev = &x86_dma_fallback_dev;
 
-	*gfp = dma_alloc_coherent_gfp_flags(*dev, *gfp);
-
 	if (!is_device_dma_capable(*dev))
 		return false;
 	return true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 75dc8b525c12..66beedc8fe3d 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -208,13 +208,6 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	void *vaddr = NULL;
 
 	order = get_order(size);
-
-	/*
-	 * Memory will be memset to zero after marking decrypted, so don't
-	 * bother clearing it before.
-	 */
-	gfp &= ~__GFP_ZERO;
-
 	page = alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (page) {
 		dma_addr_t addr;
-- 
2.14.2
