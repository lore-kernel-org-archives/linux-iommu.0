From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 16/20] iommu/amd: Optimize map_sg and unmap_sg
Date: Fri,  8 Jul 2016 13:45:07 +0200
Message-ID: <1467978311-28322-17-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Optimize these functions so that they need only one call
into the address alloctor. This also saves a couple of
io-tlb flushes in the unmap_sg path.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 77 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 78b278b..e5f8e7f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2409,45 +2409,70 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
  * lists).
  */
 static int map_sg(struct device *dev, struct scatterlist *sglist,
-		  int nelems, enum dma_data_direction dir,
+		  int nelems, enum dma_data_direction direction,
 		  struct dma_attrs *attrs)
 {
+	int mapped_pages = 0, npages = 0, prot = 0, i;
+	unsigned long start_addr, address;
 	struct protection_domain *domain;
-	int i;
+	struct dma_ops_domain *dma_dom;
 	struct scatterlist *s;
-	phys_addr_t paddr;
-	int mapped_elems = 0;
 	u64 dma_mask;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return 0;
 
+	dma_dom  = domain->priv;
 	dma_mask = *dev->dma_mask;
 
+	for_each_sg(sglist, s, nelems, i)
+		npages += iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+
+	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
+	if (address == DMA_ERROR_CODE)
+		goto out_err;
+
+	start_addr = address;
+	prot       = dir2prot(direction);
+
 	for_each_sg(sglist, s, nelems, i) {
-		paddr = sg_phys(s);
+		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+
+		for (j = 0; j < pages; ++j) {
+			unsigned long bus_addr, phys_addr;
+			int ret;
 
-		s->dma_address = __map_single(dev, domain->priv,
-					      paddr, s->length, dir, dma_mask);
+			bus_addr  = address + (j << PAGE_SHIFT);
+			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
+			ret = iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, GFP_ATOMIC);
+			if (ret)
+				goto out_unmap;
+
+			mapped_pages += 1;
+		}
 
-		if (s->dma_address) {
-			s->dma_length = s->length;
-			mapped_elems++;
-		} else
-			goto unmap;
+		s->dma_address = address + s->offset;
+		s->dma_length  = s->length;
+		address += pages << PAGE_SHIFT;
 	}
 
-	return mapped_elems;
+	return nelems;
 
-unmap:
-	for_each_sg(sglist, s, mapped_elems, i) {
-		if (s->dma_address)
-			__unmap_single(domain->priv, s->dma_address,
-				       s->dma_length, dir);
-		s->dma_address = s->dma_length = 0;
+
+out_unmap:
+	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
+	       dev_name(dev), npages);
+
+	for (i = 0; i < mapped_pages; ++i) {
+		iommu_unmap_page(domain,
+				 start_addr + (i << PAGE_SHIFT),
+				 PAGE_SIZE);
 	}
 
+	free_iova_fast(&dma_dom->iovad, start_addr, npages);
+
+out_err:
 	return 0;
 }
 
@@ -2460,18 +2485,20 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
+	unsigned long startaddr;
 	struct scatterlist *s;
-	int i;
+	int i,npages = 0;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return;
 
-	for_each_sg(sglist, s, nelems, i) {
-		__unmap_single(domain->priv, s->dma_address,
-			       s->dma_length, dir);
-		s->dma_address = s->dma_length = 0;
-	}
+	for_each_sg(sglist, s, nelems, i)
+		npages += iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+
+	startaddr = sg_dma_address(sglist) & PAGE_MASK;
+
+	__unmap_single(domain->priv, startaddr, npages << PAGE_SHIFT, dir);
 }
 
 /*
-- 
1.9.1
