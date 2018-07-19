From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] microblaze: remove consistent_sync and consistent_sync_page
Date: Thu, 19 Jul 2018 05:54:40 -0700
Message-ID: <20180719125440.424-3-hch@lst.de>
References: <20180719125440.424-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719125440.424-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Both unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/pgtable.h |  3 --
 arch/microblaze/mm/consistent.c       | 45 ---------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 8a2e654b709f..7b650ab14fa0 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,9 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void consistent_sync(void *vaddr, size_t size, int direction);
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction);
 unsigned long consistent_virt_to_pfn(void *vaddr);
 
 void setup_memory(void);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b9a9c8c3397b..c9a278ac795a 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -220,48 +220,3 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	flush_tlb_all();
 #endif
 }
-
-/*
- * make an area consistent.
- */
-void consistent_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start;
-	unsigned long end;
-
-	start = (unsigned long)vaddr;
-
-	/* Convert start address back down to unshadowed memory region */
-#ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	start &= ~UNCACHED_SHADOW_MASK;
-#endif
-	end = start + size;
-
-	switch (direction) {
-	case PCI_DMA_NONE:
-		BUG();
-	case PCI_DMA_FROMDEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
-		break;
-	case PCI_DMA_TODEVICE:		/* writeback only */
-		flush_dcache_range(start, end);
-		break;
-	case PCI_DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-EXPORT_SYMBOL(consistent_sync);
-
-/*
- * consistent_sync_page makes memory consistent. identical
- * to consistent_sync, but takes a struct page instead of a
- * virtual address
- */
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	consistent_sync((void *)start, size, direction);
-}
-EXPORT_SYMBOL(consistent_sync_page);
-- 
2.18.0
