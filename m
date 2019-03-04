From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Mon,  4 Mar 2019 20:59:03 +0100
Message-ID: <20190304195951.1118807-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <sstabellini@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
introduced an overflow warning in configurations that have a larger
dma_addr_t than phys_addr_t:

In file included from include/linux/dma-direct.h:5,
                 from kernel/dma/swiotlb.c:23:
kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
 #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
                            ^
kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
  return DMA_MAPPING_ERROR;

The configuration that caused this is on 32-bit ARM, where the DMA address
space depends on the enabled hardware platforms, while the physical
address space depends on the type of MMU chosen (classic vs LPAE).

I tried a couple of alternative approaches, but the previous version
seems as good as any other, so I went back to that.

Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 include/linux/swiotlb.h   | 3 +++
 kernel/dma/swiotlb.c      | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 877baf2a94f4..57a98279bf4f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -406,7 +406,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
-	if (map == DMA_MAPPING_ERROR)
+	if (map == SWIOTLB_MAP_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
@@ -557,7 +557,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 								 sg_phys(sg),
 								 sg->length,
 								 dir, attrs);
-			if (map == DMA_MAPPING_ERROR) {
+			if (map == SWIOTLB_MAP_ERROR) {
 				dev_warn(hwdev, "swiotlb buffer is full\n");
 				/* Don't panic here, we expect map_sg users
 				   to do proper error handling. */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 361f62bb4a8e..a65a36551f58 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -44,6 +44,9 @@ enum dma_sync_target {
 	SYNC_FOR_DEVICE = 1,
 };
 
+/* define the last possible byte of physical address space as a mapping error */
+#define SWIOTLB_MAP_ERROR (~(phys_addr_t)0x0)
+
 extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
 					  phys_addr_t phys, size_t size,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 12059b78b631..922880b84387 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -541,7 +541,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
-	return DMA_MAPPING_ERROR;
+	return SWIOTLB_MAP_ERROR;
 found:
 	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
@@ -659,7 +659,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == DMA_MAPPING_ERROR)
+	if (*phys == SWIOTLB_MAP_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.20.0
