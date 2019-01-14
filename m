From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] Revert
 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Date: Mon, 14 Jan 2019 14:22:40 +0100
Message-ID: <20190114132240.12125-1-m.szyprowski@samsung.com>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <treding@nvidia.com>, Russell King <rmk+kernel@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.

That patch broke IOMMU support for devices, which fails to probe for the
first time and use deferred probe approach. When non-NULL dma_ops is set
in arm_iommu_detach_device(), the given device later ignored by
arch_setup_dma_ops() and stays with non-IOMMU dma_ops.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3c8534904209..5827a89b7de1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1145,11 +1145,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
 	return __dma_supported(dev, mask, false);
 }
 
-static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-{
-	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
-}
-
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
@@ -2294,7 +2289,7 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
+	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
@@ -2355,6 +2350,11 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
+static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
+}
+
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-- 
2.17.1
