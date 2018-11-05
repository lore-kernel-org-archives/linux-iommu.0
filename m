From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
Date: Mon,  5 Nov 2018 13:19:28 +0100
Message-ID: <20181105121931.13481-7-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Do not waste vmalloc space on allocations that do not require a mapping
into the kernel address space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/remap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 8f1fca34b894..10a545126b0b 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	size = PAGE_ALIGN(size);
 
-	if (!gfpflags_allow_blocking(flags)) {
+	if (!gfpflags_allow_blocking(flags) &&
+	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
@@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return page; /* opaqueue cookie */
+
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
@@ -227,7 +231,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* vaddr is a struct page cookie, not a kernel address */
+		__dma_direct_free_pages(dev, size, vaddr);
+	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
 		phys_addr_t phys = dma_to_phys(dev, dma_handle);
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
-- 
2.19.1
