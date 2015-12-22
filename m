From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 20/23] iommu/amd: Relax locking in dma_ops path
Date: Tue, 22 Dec 2015 23:21:25 +0100
Message-ID: <1450822888-22590-21-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Remove the long holding times of the domain->lock and rely
on the bitmap_lock instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 70 ++++++++---------------------------------------
 1 file changed, 11 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 11ee885..e98a466 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1466,8 +1466,10 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 		}
 	}
 
+	spin_lock_irqsave(&dma_dom->domain.lock, flags);
+
 	/* First take the bitmap_lock and then publish the range */
-	spin_lock_irqsave(&range->bitmap_lock, flags);
+	spin_lock(&range->bitmap_lock);
 
 	old_size                 = dma_dom->aperture_size;
 	dma_dom->aperture[index] = range;
@@ -1518,7 +1520,9 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 
 	update_domain(&dma_dom->domain);
 
-	spin_unlock_irqrestore(&range->bitmap_lock, flags);
+	spin_unlock(&range->bitmap_lock);
+
+	spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
 
 	return 0;
 
@@ -2562,11 +2566,9 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 			   enum dma_data_direction dir,
 			   struct dma_attrs *attrs)
 {
-	unsigned long flags;
+	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct protection_domain *domain;
-	dma_addr_t addr;
 	u64 dma_mask;
-	phys_addr_t paddr = page_to_phys(page) + offset;
 
 	INC_STATS_COUNTER(cnt_map_single);
 
@@ -2578,19 +2580,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 
 	dma_mask = *dev->dma_mask;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
-	addr = __map_single(dev, domain->priv, paddr, size, dir, false,
+	return __map_single(dev, domain->priv, paddr, size, dir, false,
 			    dma_mask);
-	if (addr == DMA_ERROR_CODE)
-		goto out;
-
-	domain_flush_complete(domain);
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return addr;
 }
 
 /*
@@ -2599,7 +2590,6 @@ out:
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	unsigned long flags;
 	struct protection_domain *domain;
 
 	INC_STATS_COUNTER(cnt_unmap_single);
@@ -2608,13 +2598,7 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 	if (IS_ERR(domain))
 		return;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	__unmap_single(domain->priv, dma_addr, size, dir);
-
-	domain_flush_complete(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 /*
@@ -2625,7 +2609,6 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  int nelems, enum dma_data_direction dir,
 		  struct dma_attrs *attrs)
 {
-	unsigned long flags;
 	struct protection_domain *domain;
 	int i;
 	struct scatterlist *s;
@@ -2641,8 +2624,6 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 
 	dma_mask = *dev->dma_mask;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	for_each_sg(sglist, s, nelems, i) {
 		paddr = sg_phys(s);
 
@@ -2657,12 +2638,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 			goto unmap;
 	}
 
-	domain_flush_complete(domain);
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return mapped_elems;
+
 unmap:
 	for_each_sg(sglist, s, mapped_elems, i) {
 		if (s->dma_address)
@@ -2671,9 +2648,7 @@ unmap:
 		s->dma_address = s->dma_length = 0;
 	}
 
-	mapped_elems = 0;
-
-	goto out;
+	return 0;
 }
 
 /*
@@ -2684,7 +2659,6 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
 		     struct dma_attrs *attrs)
 {
-	unsigned long flags;
 	struct protection_domain *domain;
 	struct scatterlist *s;
 	int i;
@@ -2695,17 +2669,11 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	if (IS_ERR(domain))
 		return;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	for_each_sg(sglist, s, nelems, i) {
 		__unmap_single(domain->priv, s->dma_address,
 			       s->dma_length, dir);
 		s->dma_address = s->dma_length = 0;
 	}
-
-	domain_flush_complete(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 /*
@@ -2717,7 +2685,6 @@ static void *alloc_coherent(struct device *dev, size_t size,
 {
 	u64 dma_mask = dev->coherent_dma_mask;
 	struct protection_domain *domain;
-	unsigned long flags;
 	struct page *page;
 
 	INC_STATS_COUNTER(cnt_alloc_coherent);
@@ -2749,19 +2716,11 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	*dma_addr = __map_single(dev, domain->priv, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, true, dma_mask);
 
-	if (*dma_addr == DMA_ERROR_CODE) {
-		spin_unlock_irqrestore(&domain->lock, flags);
+	if (*dma_addr == DMA_ERROR_CODE)
 		goto out_free;
-	}
-
-	domain_flush_complete(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
 
 	return page_address(page);
 
@@ -2781,7 +2740,6 @@ static void free_coherent(struct device *dev, size_t size,
 			  struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
-	unsigned long flags;
 	struct page *page;
 
 	INC_STATS_COUNTER(cnt_free_coherent);
@@ -2793,14 +2751,8 @@ static void free_coherent(struct device *dev, size_t size,
 	if (IS_ERR(domain))
 		goto free_mem;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	__unmap_single(domain->priv, dma_addr, size, DMA_BIDIRECTIONAL);
 
-	domain_flush_complete(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
-- 
1.9.1
