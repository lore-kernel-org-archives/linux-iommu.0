From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/29] dma-mapping: remove the default map_resource implementation
Date: Wed, 13 Feb 2019 19:28:32 +0100
Message-ID: <20190213182900.16707-2-hch@lst.de>
References: <20190213182900.16707-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213182900.16707-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Instead provide a proper implementation in the direct mapping code, and
also wire it up for arm and powerpc, leaving an error return for all the
IOMMU or virtual mapping instances for which we'd have to wire up an
actual implementation

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c         |  2 ++
 arch/powerpc/kernel/dma-swiotlb.c |  1 +
 arch/powerpc/kernel/dma.c         |  1 +
 include/linux/dma-mapping.h       | 12 +++++++-----
 kernel/dma/direct.c               | 14 ++++++++++++++
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..3c8534904209 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -188,6 +188,7 @@ const struct dma_map_ops arm_dma_ops = {
 	.unmap_page		= arm_dma_unmap_page,
 	.map_sg			= arm_dma_map_sg,
 	.unmap_sg		= arm_dma_unmap_sg,
+	.map_resource		= dma_direct_map_resource,
 	.sync_single_for_cpu	= arm_dma_sync_single_for_cpu,
 	.sync_single_for_device	= arm_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
@@ -211,6 +212,7 @@ const struct dma_map_ops arm_coherent_dma_ops = {
 	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= arm_coherent_dma_map_page,
 	.map_sg			= arm_dma_map_sg,
+	.map_resource		= dma_direct_map_resource,
 	.dma_supported		= arm_dma_supported,
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 7d5fc9751622..fbb2506a414e 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -55,6 +55,7 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.dma_supported = swiotlb_dma_supported,
 	.map_page = dma_direct_map_page,
 	.unmap_page = dma_direct_unmap_page,
+	.map_resource = dma_direct_map_resource,
 	.sync_single_for_cpu = dma_direct_sync_single_for_cpu,
 	.sync_single_for_device = dma_direct_sync_single_for_device,
 	.sync_sg_for_cpu = dma_direct_sync_sg_for_cpu,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index b1903ebb2e9c..258b9e8ebb99 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -273,6 +273,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
 	.unmap_page			= dma_nommu_unmap_page,
+	.map_resource			= dma_direct_map_resource,
 	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f6ded992c183..9842085e6774 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -208,6 +208,8 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long attrs);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
@@ -346,19 +348,19 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
 					  unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr;
+	dma_addr_t addr = DMA_MAPPING_ERROR;
 
 	BUG_ON(!valid_dma_direction(dir));
 
 	/* Don't allow RAM to be mapped */
 	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
 
-	addr = phys_addr;
-	if (ops && ops->map_resource)
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
 	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
-
 	return addr;
 }
 
@@ -369,7 +371,7 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops && ops->unmap_resource)
+	if (!dma_is_direct(ops) && ops->unmap_resource)
 		ops->unmap_resource(dev, addr, size, dir, attrs);
 	debug_dma_unmap_resource(dev, addr, size, dir);
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..25bd19974223 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -356,6 +356,20 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 }
 EXPORT_SYMBOL(dma_direct_map_sg);
 
+dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t dma_addr = paddr;
+
+	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
+		report_addr(dev, dma_addr, size);
+		return DMA_MAPPING_ERROR;
+	}
+
+	return dma_addr;
+}
+EXPORT_SYMBOL(dma_direct_map_resource);
+
 /*
  * Because 32-bit DMA masks are so common we expect every architecture to be
  * able to satisfy them - either by not supporting more physical memory, or by
-- 
2.20.1
