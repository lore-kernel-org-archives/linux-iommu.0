From: John Garry <john.garry@huawei.com>
Subject: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()
Date: Wed, 21 Nov 2018 22:54:10 +0800
Message-ID: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: robin.murphy@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com, hch@lst.de, m.szyprowski@samsung.com, linuxarm@huawei.com, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
respective device NUMA node. The ternary operator which would be for
alloc_pages_node() is tidied along with this.

We also include a change to use kvzalloc() for kzalloc()/vzalloc()
combination.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..4afb1a8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 	kvfree(pages);
 }
 
-static struct page **__iommu_dma_alloc_pages(unsigned int count,
-		unsigned long order_mask, gfp_t gfp)
+static struct page **__iommu_dma_alloc_pages(struct device *dev,
+		unsigned int count, unsigned long order_mask, gfp_t gfp)
 {
 	struct page **pages;
-	unsigned int i = 0, array_size = count * sizeof(*pages);
+	unsigned int i = 0, nid = dev_to_node(dev);
 
 	order_mask &= (2U << MAX_ORDER) - 1;
 	if (!order_mask)
 		return NULL;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
@@ -481,10 +478,12 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 		for (order_mask &= (2U << __fls(count)) - 1;
 		     order_mask; order_mask &= ~order_size) {
 			unsigned int order = __fls(order_mask);
+			gfp_t alloc_flags = gfp;
 
 			order_size = 1U << order;
-			page = alloc_pages((order_mask - order_size) ?
-					   gfp | __GFP_NORETRY : gfp, order);
+			if (order_mask > order_size)
+				alloc_flags |= __GFP_NORETRY;
+			page = alloc_pages_node(nid, alloc_flags, order);
 			if (!page)
 				continue;
 			if (!order)
@@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		alloc_sizes = min_size;
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
+	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
+					gfp);
 	if (!pages)
 		return NULL;
 
-- 
1.9.1
