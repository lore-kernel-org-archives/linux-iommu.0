From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 08/10] iommu/vt-d: Add dma sync ops for untrusted devices
Date: Wed, 27 Mar 2019 14:35:04 +0800
Message-ID: <20190327063506.32564-9-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the dma sync ops for dma buffers used by any
untrusted device. We need to sync such buffers because
they might have been mapped with bounce pages.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 114 +++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b95a94f2fd5a..b9f57ecd01b4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3928,16 +3928,112 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static inline void
+sync_dma_for_device(struct device *dev, dma_addr_t dev_addr, size_t size,
+		    enum dma_data_direction dir)
+{
+	enum dma_sync_target target = SYNC_FOR_DEVICE;
+
+	domain_bounce_sync_single(dev, dev_addr, size, dir, &target);
+}
+
+static inline void
+sync_dma_for_cpu(struct device *dev, dma_addr_t dev_addr, size_t size,
+		 enum dma_data_direction dir)
+{
+	enum dma_sync_target target = SYNC_FOR_CPU;
+
+	domain_bounce_sync_single(dev, dev_addr, size, dir, &target);
+}
+
+static void
+intel_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			  size_t size, enum dma_data_direction dir)
+{
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	sync_dma_for_cpu(dev, addr, size, dir);
+}
+
+static void
+intel_sync_single_for_device(struct device *dev, dma_addr_t addr,
+			     size_t size, enum dma_data_direction dir)
+{
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	sync_dma_for_device(dev, addr, size, dir);
+}
+
+static void
+intel_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
+		      int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	for_each_sg(sglist, sg, nelems, i)
+		sync_dma_for_cpu(dev, sg_dma_address(sg),
+				 sg_dma_len(sg), dir);
+}
+
+static void
+intel_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	for_each_sg(sglist, sg, nelems, i)
+		sync_dma_for_device(dev, sg_dma_address(sg),
+				    sg_dma_len(sg), dir);
+}
+
 static const struct dma_map_ops intel_dma_ops = {
-	.alloc = intel_alloc_coherent,
-	.free = intel_free_coherent,
-	.map_sg = intel_map_sg,
-	.unmap_sg = intel_unmap_sg,
-	.map_page = intel_map_page,
-	.unmap_page = intel_unmap_page,
-	.map_resource = intel_map_resource,
-	.unmap_resource = intel_unmap_page,
-	.dma_supported = dma_direct_supported,
+	.alloc			= intel_alloc_coherent,
+	.free			= intel_free_coherent,
+	.map_sg			= intel_map_sg,
+	.unmap_sg		= intel_unmap_sg,
+	.map_page		= intel_map_page,
+	.unmap_page		= intel_unmap_page,
+	.sync_single_for_cpu	= intel_sync_single_for_cpu,
+	.sync_single_for_device	= intel_sync_single_for_device,
+	.sync_sg_for_cpu	= intel_sync_sg_for_cpu,
+	.sync_sg_for_device	= intel_sync_sg_for_device,
+	.map_resource		= intel_map_resource,
+	.unmap_resource		= intel_unmap_page,
+	.dma_supported		= dma_direct_supported,
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.17.1
