From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 24/32] powerpc/dma: remove dma_nommu_get_required_mask
Date: Wed, 13 Feb 2019 08:01:25 +0100
Message-ID: <20190213070133.11259-25-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

This function is identical to the generic dma_direct_get_required_mask,
except that the generic version also takes the bus_dma_mask account,
which could lead to incorrect results in the powerpc version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  1 -
 arch/powerpc/kernel/dma-iommu.c        |  2 +-
 arch/powerpc/kernel/dma.c              | 14 +-------------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index f19c486e7b3f..af9a32d4fcf8 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -32,7 +32,6 @@ dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_nommu_dma_supported(struct device *dev, u64 mask);
-u64 dma_nommu_get_required_mask(struct device *dev);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index ed8b60829a90..4377b69a9d42 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -152,7 +152,7 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 		return 0;
 
 	if (dev_is_pci(dev)) {
-		u64 bypass_mask = dma_nommu_get_required_mask(dev);
+		u64 bypass_mask = dma_direct_get_required_mask(dev);
 
 		if (dma_iommu_bypass_supported(dev, bypass_mask))
 			return bypass_mask;
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 841c43355a7e..46afc66cc271 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -145,18 +145,6 @@ static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
-u64 dma_nommu_get_required_mask(struct device *dev)
-{
-	u64 end, mask;
-
-	end = memblock_end_of_DRAM() + get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -205,7 +193,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
 	.unmap_page			= dma_nommu_unmap_page,
-	.get_required_mask		= dma_nommu_get_required_mask,
+	.get_required_mask		= dma_direct_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
 	.sync_single_for_device 	= dma_nommu_sync_single,
-- 
2.20.1
