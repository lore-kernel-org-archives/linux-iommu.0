From: Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
Date: Fri, 18 Jan 2019 17:05:59 -0700
Message-ID: <20190119000559.12784-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Currently the Intel IOMMU uses the default dma_[un]map_resource()
implementations does nothing and simply returns the physical address
unmodified.

However, this doesn't create the IOVA entries necessary for addresses
mapped this way to work when the IOMMU is enabled. Thus, when the
IOMMU is enabled, drivers relying on dma_map_resource() will trigger
DMAR errors. We see this when running ntb_transport with the IOMMU
enabled, DMA, and switchtec hardware.

The implementation for intel_map_resource() is nearly identical to
intel_map_page(), we just have to re-create __intel_map_single().
dma_unmap_resource() uses intel_unmap_page() directly as the
functions are identical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/intel-iommu.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..81fb265f7730 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3649,11 +3649,9 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size, int dir,
-				   u64 dma_mask)
+static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
+				     size_t size, int dir, u64 dma_mask)
 {
-	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
@@ -3710,6 +3708,14 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 	return DMA_MAPPING_ERROR;
 }
 
+static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size, int dir,
+				   u64 dma_mask)
+{
+	return __intel_map_single(dev, page_to_phys(page) + offset, size, dir,
+				  dma_mask);
+}
+
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
@@ -3718,6 +3724,13 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 	return __intel_map_page(dev, page, offset, size, dir, *dev->dma_mask);
 }
 
+static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+}
+
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 {
 	struct dmar_domain *domain;
@@ -3924,6 +3937,8 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+	.map_resource = intel_map_resource,
+	.unmap_resource = intel_unmap_page,
 	.dma_supported = dma_direct_supported,
 };
 
@@ -4080,7 +4095,7 @@ static int init_iommu_hw(void)
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
-	
+
 		iommu_flush_write_buffer(iommu);
 
 		iommu_set_root_entry(iommu);
-- 
2.19.0
