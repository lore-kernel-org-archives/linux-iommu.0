From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Date: Mon, 22 Apr 2019 19:59:18 +0200
Message-ID: <20190422175942.18788-3-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190422175942.18788-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The nr_pages checks should be done for all mmap requests, not just those
using remap_pfn_range.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/arm64/mm/dma-mapping.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 674860e3e478..604c638b2787 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -73,19 +73,9 @@ static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
 static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			      vma->vm_end - vma->vm_start,
+			      vma->vm_page_prot);
 }
 #endif /* CONFIG_IOMMU_DMA */
 
@@ -241,6 +231,8 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
 			      unsigned long attrs)
 {
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
 	struct vm_struct *area;
 	int ret;
 
@@ -249,6 +241,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
+	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
+		return -ENXIO;
+
 	if (!is_vmalloc_addr(cpu_addr)) {
 		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
 		return __swiotlb_mmap_pfn(vma, pfn, size);
-- 
2.20.1
