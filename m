From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
Date: Wed, 27 Mar 2019 09:04:35 +0100
Message-ID: <20190327080448.5500-9-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Move the vm_area handling into __iommu_dma_mmap, which is renamed
to iommu_dma_mmap_remap.

Inline __iommu_dma_mmap_pfn into the main function to simplify the code
flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 50 ++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d14fe9f8c692..43bd3c7e0f6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -597,23 +597,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 /**
- * __iommu_dma_mmap - Map a buffer into provided user VMA
- * @pages: Array representing buffer from __iommu_dma_alloc()
+ * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
+ * @cpu_addr: virtual address of the memory to be remapped
  * @size: Size of buffer in bytes
  * @vma: VMA describing requested userspace mapping
  *
- * Maps the pages of the buffer in @pages into @vma. The caller is responsible
+ * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
  * for verifying the correct size and protection of @vma beforehand.
  */
-static int __iommu_dma_mmap(struct page **pages, size_t size,
+static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
 		struct vm_area_struct *vma)
 {
+	struct vm_struct *area = find_vm_area(cpu_addr);
 	unsigned long uaddr = vma->vm_start;
 	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int ret = -ENXIO;
 
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
 	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
+		ret = vm_insert_page(vma, uaddr, area->pages[i]);
 		if (ret)
 			break;
 		uaddr += PAGE_SIZE;
@@ -1052,21 +1056,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	}
 }
 
-static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	struct vm_struct *area;
+	unsigned long pfn;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1077,25 +1073,15 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+			return iommu_dma_mmap_remap(cpu_addr, size, vma);
+		pfn = vmalloc_to_pfn(cpu_addr);
+	} else
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
-
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return __iommu_dma_mmap(area->pages, size, vma);
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
 }
 
 static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-- 
2.20.1
