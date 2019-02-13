From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 26/32] swiotlb: remove swiotlb_dma_supported
Date: Wed, 13 Feb 2019 08:01:27 +0100
Message-ID: <20190213070133.11259-27-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

The only user left is powerpc, but even there the generic dma-direct
version works just as well, given that we guarantee that the swiotlb
buffer must always be addressable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/kernel/dma-swiotlb.c |  2 +-
 include/linux/swiotlb.h           |  3 ---
 kernel/dma/swiotlb.c              | 12 ------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index d5950a0cb758..6d2677b2daa6 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -36,7 +36,7 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.free = __dma_nommu_free_coherent,
 	.map_sg = dma_direct_map_sg,
 	.unmap_sg = dma_direct_unmap_sg,
-	.dma_supported = swiotlb_dma_supported,
+	.dma_supported = dma_direct_supported,
 	.map_page = dma_direct_map_page,
 	.unmap_page = dma_direct_unmap_page,
 	.sync_single_for_cpu = dma_direct_sync_single_for_cpu,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..54254388899e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -60,9 +60,6 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 				    size_t size, enum dma_data_direction dir,
 				    enum dma_sync_target target);
 
-extern int
-swiotlb_dma_supported(struct device *hwdev, u64 mask);
-
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 extern phys_addr_t io_tlb_start, io_tlb_end;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d6361776dc5c..cbf3498a46f9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -648,15 +648,3 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 
 	return true;
 }
-
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask to
- * this function.
- */
-int
-swiotlb_dma_supported(struct device *hwdev, u64 mask)
-{
-	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
-}
-- 
2.20.1
