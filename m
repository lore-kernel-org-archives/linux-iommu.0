From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 3/7] ia64: remove iommu_dma_supported
Date: Fri, 25 May 2018 16:35:08 +0200
Message-ID: <20180525143512.1466-4-hch@lst.de>
References: <20180525143512.1466-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180525143512.1466-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The generic dma_direct_supported helper already used by intel-iommu on
x86 does a better job than the ia64 reimplementation.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/ia64/kernel/pci-dma.c  | 13 -------------
 drivers/iommu/intel-iommu.c |  2 --
 2 files changed, 15 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 50b6ad282a90..3c2884bef3d4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -51,18 +51,6 @@ iommu_dma_init(void)
 	return;
 }
 
-int iommu_dma_supported(struct device *dev, u64 mask)
-{
-	/* Copied from i386. Doesn't make much sense, because it will
-	   only work for pci_alloc_coherent.
-	   The caller just has to use GFP_DMA in this case. */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-EXPORT_SYMBOL(iommu_dma_supported);
-
 void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
@@ -71,7 +59,6 @@ void __init pci_iommu_alloc(void)
 	intel_dma_ops.sync_sg_for_cpu = machvec_dma_sync_sg;
 	intel_dma_ops.sync_single_for_device = machvec_dma_sync_single;
 	intel_dma_ops.sync_sg_for_device = machvec_dma_sync_sg;
-	intel_dma_ops.dma_supported = iommu_dma_supported;
 
 	/*
 	 * The order of these functions is important for
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f235346..5e0bef3754d1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3841,9 +3841,7 @@ const struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.mapping_error = intel_mapping_error,
-#ifdef CONFIG_X86
 	.dma_supported = dma_direct_supported,
-#endif
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.17.0
