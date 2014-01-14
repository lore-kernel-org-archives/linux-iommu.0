From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/5] intel-iommu: integrate DMA CMA
Date: Tue, 14 Jan 2014 23:13:48 +0900
Message-ID: <1389708830-5841-4-git-send-email-akinobu.mita@gmail.com>
References: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389708830-5841-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds support for the DMA Contiguous Memory Allocator for intel-iommu.
This change enables dma_alloc_coherent() to allocate big contiguous
memory.

It is achieved in the same way as nommu_dma_ops currently does, i.e.
trying to allocate memory by dma_alloc_from_contiguous() and alloc_pages()
is used as a fallback.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
No change from the previous version

 drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fd426ca..172c2b0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3004,7 +3004,7 @@ static void *intel_alloc_coherent(struct device *hwdev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  struct dma_attrs *attrs)
 {
-	void *vaddr;
+	struct page *page = NULL;
 	int order;
 
 	size = PAGE_ALIGN(size);
@@ -3019,17 +3019,31 @@ static void *intel_alloc_coherent(struct device *hwdev, size_t size,
 			flags |= GFP_DMA32;
 	}
 
-	vaddr = (void *)__get_free_pages(flags, order);
-	if (!vaddr)
+	if (!(flags & GFP_ATOMIC)) {
+		unsigned int count = size >> PAGE_SHIFT;
+
+		page = dma_alloc_from_contiguous(hwdev, count, order);
+		if (page && iommu_no_mapping(hwdev) &&
+		    page_to_phys(page) + size > hwdev->coherent_dma_mask) {
+			dma_release_from_contiguous(hwdev, page, count);
+			page = NULL;
+		}
+	}
+
+	if (!page)
+		page = alloc_pages(flags, order);
+	if (!page)
 		return NULL;
-	memset(vaddr, 0, size);
+	memset(page_address(page), 0, size);
 
-	*dma_handle = __intel_map_single(hwdev, virt_to_bus(vaddr), size,
+	*dma_handle = __intel_map_single(hwdev, page_to_phys(page), size,
 					 DMA_BIDIRECTIONAL,
 					 hwdev->coherent_dma_mask);
 	if (*dma_handle)
-		return vaddr;
-	free_pages((unsigned long)vaddr, order);
+		return page_address(page);
+	if (!dma_release_from_contiguous(hwdev, page, size >> PAGE_SHIFT))
+		__free_pages(page, order);
+
 	return NULL;
 }
 
@@ -3037,12 +3051,14 @@ static void intel_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 				dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	int order;
+	struct page *page = virt_to_page(vaddr);
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
 	intel_unmap_page(hwdev, dma_handle, size, DMA_BIDIRECTIONAL, NULL);
-	free_pages((unsigned long)vaddr, order);
+	if (!dma_release_from_contiguous(hwdev, page, size >> PAGE_SHIFT))
+		__free_pages(page, order);
 }
 
 static void intel_unmap_sg(struct device *hwdev, struct scatterlist *sglist,
-- 
1.8.3.2
