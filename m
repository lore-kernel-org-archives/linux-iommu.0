From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/21] dma-iommu: refactor iommu_dma_free
Date: Wed, 13 Feb 2019 19:29:13 +0100
Message-ID: <20190213182920.16764-15-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Reorder the checks a bit so that a non-remapped allocation is the
fallthrough case, as this will ease making remapping conditional.
Also get rid of the confusing game with the size and iosize variables
and rename the handle argument to the more standard dma_handle.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b8a2159ca31a..ff6c6bf30c90 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1069,34 +1069,36 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
+		dma_addr_t dma_handle, unsigned long attrs)
 {
-	size_t iosize = size;
+	struct page *page;
 
-	size = PAGE_ALIGN(size);
 	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
+	 * cpu_addr can be one of 4 things depending on how it was allocated:
+	 *
+	 *  (1) A non-cacheable alias from the atomic pool.
+	 *  (2) A remapped array of pages from iommu_dma_alloc_remap().
+	 *  (3) A remapped contiguous lowmem allocation.
+	 *  (4) A normal lowmem address.
+	 *
 	 * Hence how dodgy the below logic looks...
 	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_free_pool(dev, size, cpu_addr, handle);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		iommu_dma_free_contiguous(dev, iosize,
-				vmalloc_to_page(cpu_addr), handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
-	} else {
-		iommu_dma_free_contiguous(dev, iosize, virt_to_page(cpu_addr),
-				handle);
+	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
+		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
+		return;
 	}
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+			iommu_dma_free_remap(dev, size, cpu_addr, dma_handle);
+			return;
+		}
+		page = vmalloc_to_page(cpu_addr);
+		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
+	} else
+		page = virt_to_page(cpu_addr);
+
+	iommu_dma_free_contiguous(dev, size, page, dma_handle);
 }
 
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-- 
2.20.1
