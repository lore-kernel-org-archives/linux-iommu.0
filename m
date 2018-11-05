From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
Date: Mon,  5 Nov 2018 13:19:23 +0100
Message-ID: <20181105121931.13481-2-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Some architectures support remapping highmem into DMA coherent
allocations.  To use the common code for them we need variants of
dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  3 +++
 kernel/dma/direct.c        | 32 ++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..5a7a3bbb912f 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,6 +67,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
+struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
+void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab5a5e9..680287779b0a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -103,14 +103,13 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
 }
 
-void *dma_direct_alloc_pages(struct device *dev, size_t size,
+struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
 	struct page *page = NULL;
 	u64 phys_mask;
-	void *ret;
 
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
@@ -150,11 +149,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		}
 	}
 
+	return page;
+}
+
+void *dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	struct page *page;
+	void *ret;
+
+	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!page)
 		return NULL;
+
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
-		set_memory_decrypted((unsigned long)ret, 1 << page_order);
+		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 	} else {
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
@@ -163,20 +173,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	return ret;
 }
 
-/*
- * NOTE: this function must never look at the dma_addr argument, because we want
- * to be able to use it as a helper for iommu implementations as well.
- */
+void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (!dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(size));
+}
+
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned int page_order = get_order(size);
 
 	if (force_dma_unencrypted())
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
-	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
-		free_pages((unsigned long)cpu_addr, page_order);
+	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
-- 
2.19.1
