From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/20] iommu/amd: Remove align-parameter from __map_single()
Date: Fri,  8 Jul 2016 13:45:01 +0200
Message-ID: <1467978311-28322-11-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This parameter is not required anymore because the
iova-allocations are always aligned to its size.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fbfe51b..b91843c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2170,22 +2170,17 @@ static dma_addr_t __map_single(struct device *dev,
 			       phys_addr_t paddr,
 			       size_t size,
 			       int direction,
-			       bool align,
 			       u64 dma_mask)
 {
 	dma_addr_t offset = paddr & ~PAGE_MASK;
 	dma_addr_t address, start, ret;
 	unsigned int pages;
-	unsigned long align_mask = 0;
 	int prot = 0;
 	int i;
 
 	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
 	paddr &= PAGE_MASK;
 
-	if (align)
-		align_mask = (1UL << get_order(size)) - 1;
-
 	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
 	if (address == DMA_ERROR_CODE)
 		goto out;
@@ -2281,8 +2276,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 
 	dma_mask = *dev->dma_mask;
 
-	return __map_single(dev, domain->priv, paddr, size, dir, false,
-			    dma_mask);
+	return __map_single(dev, domain->priv, paddr, size, dir, dma_mask);
 }
 
 /*
@@ -2325,8 +2319,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		paddr = sg_phys(s);
 
 		s->dma_address = __map_single(dev, domain->priv,
-					      paddr, s->length, dir, false,
-					      dma_mask);
+					      paddr, s->length, dir, dma_mask);
 
 		if (s->dma_address) {
 			s->dma_length = s->length;
@@ -2410,7 +2403,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 		dma_mask = *dev->dma_mask;
 
 	*dma_addr = __map_single(dev, domain->priv, page_to_phys(page),
-				 size, DMA_BIDIRECTIONAL, true, dma_mask);
+				 size, DMA_BIDIRECTIONAL, dma_mask);
 
 	if (*dma_addr == DMA_ERROR_CODE)
 		goto out_free;
-- 
1.9.1
