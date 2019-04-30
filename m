From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 22/25] iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
Date: Tue, 30 Apr 2019 06:52:11 -0400
Message-ID: <20190430105214.24628-23-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
IS_ENABLED() checks and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 16 +++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bdc14baf2ee5..6f07f3b21816 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -95,7 +95,6 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9ace9ad73e10..bbd475be567a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -923,10 +923,11 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 	struct page *page = NULL, **pages = NULL;
 
 	/* Non-coherent atomic allocation? Easy */
-	if (dma_free_from_pool(cpu_addr, alloc_size))
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_free_from_pool(cpu_addr, alloc_size))
 		return;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		/*
 		 * If it the address is remapped, then it's either non-coherent
 		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
@@ -970,7 +971,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if (!coherent || PageHighMem(page)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
@@ -1003,11 +1004,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	gfp |= __GFP_ZERO;
 
-	if (gfpflags_allow_blocking(gfp) &&
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 
-	if (!gfpflags_allow_blocking(gfp) && !coherent)
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !gfpflags_allow_blocking(gfp) && !coherent)
 		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
@@ -1039,7 +1041,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages)
@@ -1061,7 +1063,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages) {
-- 
2.20.1
