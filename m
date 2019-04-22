From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/26] iommu/dma: Refactor iommu_dma_free
Date: Mon, 22 Apr 2019 19:59:30 +0200
Message-ID: <20190422175942.18788-15-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

The freeing logic was made particularly horrible by part of it being
opaque to the arch wrapper, which led to a lot of convoluted repetition
to ensure each path did everything in the right order. Now that it's
all private, we can pick apart and consolidate the logically-distinct
steps of freeing the IOMMU mapping, the underlying pages, and the CPU
remap (if necessary) into something much more manageable.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[various cosmetic changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 75 ++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4632b9d301a1..9658c4cc3cfe 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -916,6 +916,41 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(dev, handle, size);
 }
 
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	size_t alloc_size = PAGE_ALIGN(size);
+	int count = alloc_size >> PAGE_SHIFT;
+	struct page *page = NULL;
+
+	__iommu_dma_unmap(dev, handle, size);
+
+	/* Non-coherent atomic allocation? Easy */
+	if (dma_free_from_pool(cpu_addr, alloc_size))
+		return;
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		/*
+		 * If it the address is remapped, then it's either non-coherent
+		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
+		 */
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+
+		if (pages)
+			__iommu_dma_free_pages(pages, count);
+		else
+			page = vmalloc_to_page(cpu_addr);
+
+		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
+	} else {
+		/* Lowmem means a coherent atomic or CMA allocation */
+		page = virt_to_page(cpu_addr);
+	}
+
+	if (page && !dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(alloc_size));
+}
+
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
@@ -985,46 +1020,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return addr;
 }
 
-static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	size_t iosize = size;
-
-	size = PAGE_ALIGN(size);
-	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
-	 * Hence how dodgy the below logic looks...
-	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_free_from_pool(cpu_addr, size);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		struct page *page = vmalloc_to_page(cpu_addr);
-
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
-
-		if (WARN_ON(!pages))
-			return;
-		__iommu_dma_unmap(dev, handle, iosize);
-		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else {
-		__iommu_dma_unmap(dev, handle, iosize);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
-	}
-}
-
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-- 
2.20.1
