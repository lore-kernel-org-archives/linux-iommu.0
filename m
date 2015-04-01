From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/9] iommu/amd: Add support for contiguous dma allocator
Date: Wed,  1 Apr 2015 14:58:47 +0200
Message-ID: <1427893132-18310-5-git-send-email-joro@8bytes.org>
References: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427893132-18310-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Add code to allocate memory from the contiguous memory
allocator to support coherent allocations larger than 8MB.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c2e6f13..49ecf00 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -33,6 +33,7 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
+#include <linux/dma-contiguous.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -2913,37 +2914,42 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			    dma_addr_t *dma_addr, gfp_t flag,
 			    struct dma_attrs *attrs)
 {
-	unsigned long flags;
-	void *virt_addr;
-	struct protection_domain *domain;
-	phys_addr_t paddr;
 	u64 dma_mask = dev->coherent_dma_mask;
+	struct protection_domain *domain;
+	unsigned long flags;
+	struct page *page;
 
 	INC_STATS_COUNTER(cnt_alloc_coherent);
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL) {
-		virt_addr = (void *)__get_free_pages(flag, get_order(size));
-		*dma_addr = __pa(virt_addr);
-		return virt_addr;
+		page = alloc_pages(flag, get_order(size));
+		*dma_addr = page_to_phys(page);
+		return page_address(page);
 	} else if (IS_ERR(domain))
 		return NULL;
 
+	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
 	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
 
-	virt_addr = (void *)__get_free_pages(flag, get_order(size));
-	if (!virt_addr)
-		return NULL;
+	page = alloc_pages(flag | __GFP_NOWARN,  get_order(size));
+	if (!page) {
+		if (!(flag & __GFP_WAIT))
+			return NULL;
 
-	paddr = virt_to_phys(virt_addr);
+		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+						 get_order(size));
+		if (!page)
+			return NULL;
+	}
 
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	*dma_addr = __map_single(dev, domain->priv, paddr,
+	*dma_addr = __map_single(dev, domain->priv, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, true, dma_mask);
 
 	if (*dma_addr == DMA_ERROR_CODE) {
@@ -2955,11 +2961,12 @@ static void *alloc_coherent(struct device *dev, size_t size,
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	return virt_addr;
+	return page_address(page);
 
 out_free:
 
-	free_pages((unsigned long)virt_addr, get_order(size));
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
 
 	return NULL;
 }
@@ -2971,11 +2978,15 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  struct dma_attrs *attrs)
 {
-	unsigned long flags;
 	struct protection_domain *domain;
+	unsigned long flags;
+	struct page *page;
 
 	INC_STATS_COUNTER(cnt_free_coherent);
 
+	page = virt_to_page(virt_addr);
+	size = PAGE_ALIGN(size);
+
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
 		goto free_mem;
@@ -2989,7 +3000,8 @@ static void free_coherent(struct device *dev, size_t size,
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 free_mem:
-	free_pages((unsigned long)virt_addr, get_order(size));
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
 }
 
 /*
-- 
1.9.1
