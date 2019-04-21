From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 10/10] iommu/vt-d: Use bounce buffer for untrusted devices
Date: Sun, 21 Apr 2019 09:17:19 +0800
Message-ID: <20190421011719.14909-11-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190421011719.14909-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The Intel VT-d hardware uses paging for DMA remapping.
The minimum mapped window is a page size. The device
drivers may map buffers not filling the whole IOMMU
window. This allows the device to access to possibly
unrelated memory and a malicious device could exploit
this to perform DMA attacks. To address this, the
Intel IOMMU driver will use bounce pages for those
buffers which don't fill a whole IOMMU page.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Xu Pengfei <pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 138 ++++++++++++++++++++++++++----------
 1 file changed, 99 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ed941ec9b9d5..52ccbd3f1425 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -52,6 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <trace/events/intel_iommu.h>
 
 #include "irq_remapping.h"
 #include "intel-pasid.h"
@@ -3410,15 +3411,17 @@ static int iommu_no_mapping(struct device *dev)
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
-				     size_t size, int dir, u64 dma_mask)
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs, u64 dma_mask)
 {
 	struct dmar_domain *domain;
-	phys_addr_t start_paddr;
+	dma_addr_t start_dma;
 	unsigned long iova_pfn;
 	int prot = 0;
 	int ret;
 	struct intel_iommu *iommu;
 	unsigned long paddr_pfn = paddr >> PAGE_SHIFT;
+	unsigned long nrpages;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -3430,9 +3433,10 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
-	size = aligned_nrpages(paddr, size);
+	nrpages = aligned_nrpages(paddr, size);
 
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	iova_pfn = intel_alloc_iova(dev, domain,
+				    dma_to_mm_pfn(nrpages), dma_mask);
 	if (!iova_pfn)
 		goto error;
 
@@ -3445,24 +3449,33 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		prot |= DMA_PTE_READ;
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
 		prot |= DMA_PTE_WRITE;
+
+	start_dma = (dma_addr_t)iova_pfn << PAGE_SHIFT;
+	start_dma += offset_in_page(paddr);
+
 	/*
 	 * paddr - (paddr + size) might be partial page, we should map the whole
 	 * page.  Note: if two part of one page are separately mapped, we
 	 * might have two guest_addr mapping to the same host paddr, but this
 	 * is not a big problem
 	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 mm_to_dma_pfn(paddr_pfn), size, prot);
+	if (device_needs_bounce(dev)) {
+		ret = iommu_bounce_map(dev, start_dma, paddr, size, dir, attrs);
+		if (!ret)
+			trace_bounce_map_single(dev, start_dma, paddr, size);
+	} else {
+		ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
+					 mm_to_dma_pfn(paddr_pfn),
+					 nrpages, prot);
+	}
 	if (ret)
 		goto error;
 
-	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
-	start_paddr += paddr & ~PAGE_MASK;
-	return start_paddr;
-
+	return start_dma;
 error:
 	if (iova_pfn)
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
+		free_iova_fast(&domain->iovad, iova_pfn,
+			       dma_to_mm_pfn(nrpages));
 	dev_err(dev, "Device request: %zx@%llx dir %d --- failed\n",
 		size, (unsigned long long)paddr, dir);
 	return DMA_MAPPING_ERROR;
@@ -3474,44 +3487,79 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long attrs)
 {
 	return __intel_map_single(dev, page_to_phys(page) + offset, size,
-				  dir, *dev->dma_mask);
+				  dir, attrs, *dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+	return __intel_map_single(dev, phys_addr, size,
+				  dir, attrs, *dev->dma_mask);
 }
 
-static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
+static void
+intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size,
+	    struct scatterlist *sglist, int nelems,
+	    enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
-	unsigned long nrpages;
+	unsigned long nrpages = 0;
 	unsigned long iova_pfn;
 	struct intel_iommu *iommu;
-	struct page *freelist;
+	struct page *freelist = NULL;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu_no_mapping(dev))
 		return;
 
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
+
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
 
-	iova_pfn = IOVA_PFN(dev_addr);
-
-	nrpages = aligned_nrpages(dev_addr, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
-
-	dev_dbg(dev, "Device unmapping: pfn %lx-%lx\n", start_pfn, last_pfn);
+	if (sglist) {
+		struct scatterlist *sg;
+		int i;
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+		dev_addr = sg_dma_address(sglist) & PAGE_MASK;
+		iova_pfn = IOVA_PFN(dev_addr);
+		for_each_sg(sglist, sg, nelems, i) {
+			nrpages += aligned_nrpages(sg_dma_address(sg),
+						   sg_dma_len(sg));
+		}
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
+
+		if (device_needs_bounce(dev))
+			for_each_sg(sglist, sg, nelems, i) {
+				iommu_bounce_unmap(dev, sg_dma_address(sg),
+						   sg->length, dir, attrs);
+				trace_bounce_unmap_sg(dev, i, nelems,
+						      sg_dma_address(sg),
+						      sg_phys(sg), sg->length);
+			}
+		else
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+	} else {
+		iova_pfn = IOVA_PFN(dev_addr);
+		nrpages = aligned_nrpages(dev_addr, size);
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
+
+		if (device_needs_bounce(dev)) {
+			iommu_bounce_unmap(dev, dev_addr, size, dir, attrs);
+			trace_bounce_unmap_single(dev, dev_addr, size);
+		} else {
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+		}
+	}
 
-	if (intel_iommu_strict) {
+	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
@@ -3531,7 +3579,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size, NULL, 0, dir, attrs);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3572,7 +3620,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	memset(page_address(page), 0, size);
 
 	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
+					 DMA_BIDIRECTIONAL, attrs,
 					 dev->coherent_dma_mask);
 	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
@@ -3591,7 +3639,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap(dev, dma_handle, size);
+	intel_unmap(dev, dma_handle, size, NULL, 0, 0, attrs);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
 }
@@ -3600,16 +3648,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   unsigned long attrs)
 {
-	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	unsigned long nrpages = 0;
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
-	}
-
-	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
+	intel_unmap(dev, 0, 0, sglist, nelems, dir, attrs);
 }
 
 static int intel_nontranslate_map_sg(struct device *hddev,
@@ -3671,7 +3710,28 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
-	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
+	if (device_needs_bounce(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
+			unsigned int pgoff = offset_in_page(sg->offset);
+			dma_addr_t addr;
+
+			addr = ((dma_addr_t)iova_pfn << PAGE_SHIFT) + pgoff;
+			ret = iommu_bounce_map(dev, addr, sg_phys(sg),
+					       sg->length, dir, attrs);
+			if (ret)
+				break;
+
+			trace_bounce_map_sg(dev, i, nelems, addr,
+					    sg_phys(sg), sg->length);
+
+			sg->dma_address = addr;
+			sg->dma_length = sg->length;
+			iova_pfn += aligned_nrpages(sg->offset, sg->length);
+		}
+	} else {
+		ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
+	}
+
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1,
-- 
2.17.1
