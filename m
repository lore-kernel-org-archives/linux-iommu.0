From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 18/21] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Date: Wed, 13 Feb 2019 19:29:17 +0100
Message-ID: <20190213182920.16764-19-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8b13fb7d0263..d9a25715650e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -94,7 +94,6 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5f3c70c65d50..35a5c219b82e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -501,6 +501,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 	return page_address(page);
 }
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -783,6 +784,7 @@ static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
 				gfp, attrs);
 	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
 }
+#endif /* CONFIG_DMA_DIRECT_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1065,6 +1067,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (!dev_is_dma_coherent(dev))
 		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
@@ -1072,6 +1075,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+#endif
 
 	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
@@ -1091,6 +1095,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 *
 	 * Hence how dodgy the below logic looks...
 	 */
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
 		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
 		return;
@@ -1104,6 +1109,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	iommu_dma_free_contiguous(dev, size, page, dma_handle);
@@ -1126,11 +1132,13 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_mmap_remap(cpu_addr, size, vma);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else
+#endif
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
@@ -1144,11 +1152,13 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
 		page = vmalloc_to_page(cpu_addr);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-- 
2.20.1
