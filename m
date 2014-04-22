From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V1 19/22] iommu/vt-d: simplify intel_unmap_sg() and kill
	duplicated code
Date: Tue, 22 Apr 2014 15:07:30 +0800
Message-ID: <1398150453-28141-20-git-send-email-jiang.liu@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398150453-28141-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Simplify intel_unmap_sg() by calling intel_unmap_page() and
kill duplicated code, no functionality changes.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   63 +++++++++++++------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f2143b59ad68..4738e64fe097 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -979,6 +979,8 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
 	BUG_ON(start_pfn > last_pfn);
 
+	dma_pte_clear_range(domain, start_pfn, last_pfn);
+
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw),
 			   domain->pgd, 0, start_pfn, last_pfn);
@@ -2031,12 +2033,14 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			/* It is large page*/
 			if (largepage_lvl > 1) {
 				pteval |= DMA_PTE_LARGE_PAGE;
-				/* Ensure that old small page tables are removed to make room
-				   for superpage, if they exist. */
-				dma_pte_clear_range(domain, iov_pfn,
-						    iov_pfn + lvl_to_nr_pages(largepage_lvl) - 1);
+				lvl_pages = lvl_to_nr_pages(largepage_lvl);
+				/*
+				 * Ensure that old small page tables are
+				 * removed to make room for superpage,
+				 * if they exist.
+				 */
 				dma_pte_free_pagetable(domain, iov_pfn,
-						       iov_pfn + lvl_to_nr_pages(largepage_lvl) - 1);
+						       iov_pfn + lvl_pages - 1);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
 			}
@@ -3256,43 +3260,17 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   struct dma_attrs *attrs)
 {
-	struct dmar_domain *domain;
-	unsigned long start_pfn, last_pfn;
-	struct iova *iova;
-	struct intel_iommu *iommu;
-	struct page *freelist;
-
-	if (iommu_no_mapping(dev))
-		return;
-
-	domain = find_domain(dev);
-	BUG_ON(!domain);
-
-	iommu = domain_get_iommu(domain);
-
-	iova = find_iova(&domain->iovad, IOVA_PFN(sglist[0].dma_address));
-	if (WARN_ONCE(!iova, "Driver unmaps unmatched sglist at PFN %llx\n",
-		      (unsigned long long)sglist[0].dma_address))
-		return;
-
-	start_pfn = mm_to_dma_pfn(iova->pfn_lo);
-	last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
+	size_t size = 0;
+#if 0
+	/* current the third argument of intel_unmap_page is unsued */
+	int i;
+	struct scatterlist *sg;
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+	for_each_sg(sglist, sg, nelems, i)
+		size += sg->length;
+#endif
 
-	if (intel_iommu_strict) {
-		iommu_flush_iotlb_psi(iommu, domain->id, start_pfn,
-				      last_pfn - start_pfn + 1, !freelist, 0);
-		/* free iova */
-		__free_iova(&domain->iovad, iova);
-		dma_free_pagelist(freelist);
-	} else {
-		add_unmap(domain, iova, freelist);
-		/*
-		 * queue up the release of the unmap to save the 1/6th of the
-		 * cpu used up by the iotlb flush operation...
-		 */
-	}
+	intel_unmap_page(dev, sglist[0].dma_address, size, dir, attrs);
 }
 
 static int intel_nontranslate_map_sg(struct device *hddev,
@@ -3356,13 +3334,8 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
 	if (unlikely(ret)) {
-		/*  clear the page */
-		dma_pte_clear_range(domain, start_vpfn,
-				    start_vpfn + size - 1);
-		/* free page tables */
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1);
-		/* free iova */
 		__free_iova(&domain->iovad, iova);
 		return 0;
 	}
-- 
1.7.10.4
