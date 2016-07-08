From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 20/20] iommu/amd: Use container_of to get dma_ops_domain
Date: Fri,  8 Jul 2016 13:45:11 +0200
Message-ID: <1467978311-28322-21-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This is better than storing an extra pointer in struct
protection_domain, because this pointer can now be removed
from the struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c       | 38 +++++++++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_types.h |  1 -
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4052997..945f0c5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -230,6 +230,12 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
+static struct dma_ops_domain* to_dma_ops_domain(struct protection_domain *domain)
+{
+	BUG_ON(domain->flags != PD_DMA_OPS_MASK);
+	return container_of(domain, struct dma_ops_domain, domain);
+}
+
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -435,7 +441,7 @@ static void init_iommu_group(struct device *dev)
 	if (!domain)
 		goto out;
 
-	dma_domain = to_pdomain(domain)->priv;
+	dma_domain = to_dma_ops_domain(to_pdomain(domain));
 
 out:
 	iommu_group_put(group);
@@ -1678,7 +1684,6 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	dma_dom->domain.mode = PAGE_MODE_2_LEVEL;
 	dma_dom->domain.pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 	dma_dom->domain.flags = PD_DMA_OPS_MASK;
-	dma_dom->domain.priv = dma_dom;
 	if (!dma_dom->domain.pt_root)
 		goto free_dma_dom;
 
@@ -2375,6 +2380,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 	u64 dma_mask;
 
 	domain = get_domain(dev);
@@ -2384,8 +2390,9 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 		return DMA_ERROR_CODE;
 
 	dma_mask = *dev->dma_mask;
+	dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, domain->priv, paddr, size, dir, dma_mask);
+	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
 }
 
 /*
@@ -2395,12 +2402,15 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return;
 
-	__unmap_single(domain->priv, dma_addr, size, dir);
+	dma_dom = to_dma_ops_domain(domain);
+
+	__unmap_single(dma_dom, dma_addr, size, dir);
 }
 
 /*
@@ -2422,7 +2432,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	if (IS_ERR(domain))
 		return 0;
 
-	dma_dom  = domain->priv;
+	dma_dom  = to_dma_ops_domain(domain);
 	dma_mask = *dev->dma_mask;
 
 	for_each_sg(sglist, s, nelems, i)
@@ -2484,6 +2494,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
 	struct scatterlist *s;
 	int i,npages = 0;
@@ -2496,8 +2507,9 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		npages += iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
 
 	startaddr = sg_dma_address(sglist) & PAGE_MASK;
+	dma_dom   = to_dma_ops_domain(domain);
 
-	__unmap_single(domain->priv, startaddr, npages << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
 }
 
 /*
@@ -2509,6 +2521,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 {
 	u64 dma_mask = dev->coherent_dma_mask;
 	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
 	domain = get_domain(dev);
@@ -2519,6 +2532,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	} else if (IS_ERR(domain))
 		return NULL;
 
+	dma_dom   = to_dma_ops_domain(domain);
 	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
 	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
@@ -2538,7 +2552,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
-	*dma_addr = __map_single(dev, domain->priv, page_to_phys(page),
+	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
 
 	if (*dma_addr == DMA_ERROR_CODE)
@@ -2562,6 +2576,7 @@ static void free_coherent(struct device *dev, size_t size,
 			  struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
+	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
 	page = virt_to_page(virt_addr);
@@ -2571,7 +2586,9 @@ static void free_coherent(struct device *dev, size_t size,
 	if (IS_ERR(domain))
 		goto free_mem;
 
-	__unmap_single(domain->priv, dma_addr, size, DMA_BIDIRECTIONAL);
+	dma_dom = to_dma_ops_domain(domain);
+
+	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
 
 free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
@@ -2861,7 +2878,7 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 		queue_flush_all();
 
 		/* Now release the domain */
-		dma_dom = domain->priv;
+		dma_dom = to_dma_ops_domain(domain);
 		dma_ops_domain_free(dma_dom);
 		break;
 	default:
@@ -3049,8 +3066,7 @@ static void amd_iommu_apply_dm_region(struct device *dev,
 				      struct iommu_domain *domain,
 				      struct iommu_dm_region *region)
 {
-	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dma_ops_domain *dma_dom = pdomain->priv;
+	struct dma_ops_domain *dma_dom = to_dma_ops_domain(to_pdomain(domain));
 	unsigned long start, end;
 
 	start = IOVA_PFN(region->start);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 590956a..caf5e38 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -421,7 +421,6 @@ struct protection_domain {
 	bool updated;		/* complete domain flush required */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
-	void *priv;             /* private data */
 };
 
 /*
-- 
1.9.1
