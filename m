From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/21] arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtable
Date: Wed, 27 Mar 2019 09:04:28 +0100
Message-ID: <20190327080448.5500-2-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

DMA allocations that can't sleep may return non-remapped addresses, but
we do not properly handle them in the mmap and get_sgtable methods.
Resolve non-vmalloc addresses using virt_to_page to handle this corner
case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..be88beb2e377 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -249,6 +249,11 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
+	if (!is_vmalloc_addr(cpu_addr)) {
+		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
+		return __swiotlb_mmap_pfn(vma, pfn, size);
+	}
+
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
@@ -272,10 +277,15 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
+	if (!is_vmalloc_addr(cpu_addr)) {
+		struct page *page = virt_to_page(cpu_addr);
+		return __swiotlb_get_sgtable_page(sgt, page, size);
+	}
+
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
+		 *  hence in the vmalloc space.
 		 */
 		struct page *page = vmalloc_to_page(cpu_addr);
 		return __swiotlb_get_sgtable_page(sgt, page, size);
-- 
2.20.1
