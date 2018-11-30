From: John Garry <john.garry@huawei.com>
Subject: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in __iommu_dma_alloc_pages()
Date: Fri, 30 Nov 2018 19:14:00 +0800
Message-ID: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
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

The motivation for this change is to have a policy for page allocation
consistent with direct DMA mapping, which attempts to allocate pages local
to the device, as mentioned in [1].

In addition, for certain workloads it has been observed a marginal
performance improvement. The patch caused an observation of 0.9% average
throughput improvement for running tcrypt with HiSilicon crypto engine.

We also include a modification to use kvzalloc() for kzalloc()/vzalloc()
combination.

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[JPG: Added kvzalloc(), drop pages ** being device local, remove ternary operator, update message]
Signed-off-by: John Garry <john.garry@huawei.com>
---
Difference:
v1->v2:
- Add Ganapatrao's tag and change author

v2->v3:
- removed ternary operator
- stopped making pages ** allocation local to device

v3->v4:
- Update commit message to include motivation for patch, including
  headline performance improvement for test.

Some notes:
This patch was originally posted by Ganapatrao in [2].

However, after initial review, it was never reposted (due to lack of
cycles, I think). In addition, the functionality in its sibling patches
were merged through patches, as mentioned in [2]; this also refers to a
discussion on device local allocations vs CPU local allocations for DMA
pool, and which is better [1].

However, as mentioned in [1], dma_alloc_coherent() uses the locality
information from the device - as in direct DMA - so this patch is just
applying this same policy.

And from some testing, mentioned in commit message, shows marginal
improvement.

[2] https://lore.kernel.org/patchwork/patch/833004/
[3] https://lkml.org/lkml/2018/8/22/391

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
