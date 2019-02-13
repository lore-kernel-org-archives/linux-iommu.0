From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/32] powerpc/dma: remove max_direct_dma_addr
Date: Wed, 13 Feb 2019 08:01:20 +0100
Message-ID: <20190213070133.11259-20-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

The max_direct_dma_addr duplicates the bus_dma_mask field in struct
device.  Use the generic field instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/device.h     |  3 ---
 arch/powerpc/include/asm/dma-direct.h |  4 +---
 arch/powerpc/kernel/dma-swiotlb.c     | 21 +--------------------
 arch/powerpc/kernel/dma.c             |  5 ++---
 arch/powerpc/sysdev/fsl_pci.c         |  4 ++--
 5 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 3814e1c2d4bc..a130be13ee83 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -38,9 +38,6 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void			*iommu_domain;
 #endif
-#ifdef CONFIG_SWIOTLB
-	dma_addr_t		max_direct_dma_addr;
-#endif
 #ifdef CONFIG_PPC64
 	struct pci_dn		*pci_data;
 #endif
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index 7702875aabb7..e00ab5d0612d 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -5,9 +5,7 @@
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 #ifdef CONFIG_SWIOTLB
-	struct dev_archdata *sd = &dev->archdata;
-
-	if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
+	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
 		return false;
 #endif
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 42badc4bf536..0e21c318300e 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -24,21 +24,6 @@
 
 unsigned int ppc_swiotlb_enable;
 
-static u64 swiotlb_powerpc_get_required(struct device *dev)
-{
-	u64 end, mask, max_direct_dma_addr = dev->archdata.max_direct_dma_addr;
-
-	end = memblock_end_of_DRAM();
-	if (max_direct_dma_addr && end > max_direct_dma_addr)
-		end = max_direct_dma_addr;
-	end += get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 /*
  * At the moment, all platforms that use this code only require
  * swiotlb to be used if we're operating on HIGHMEM.  Since
@@ -59,22 +44,18 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.sync_single_for_device = dma_direct_sync_single_for_device,
 	.sync_sg_for_cpu = dma_direct_sync_sg_for_cpu,
 	.sync_sg_for_device = dma_direct_sync_sg_for_device,
-	.get_required_mask = swiotlb_powerpc_get_required,
+	.get_required_mask = dma_direct_get_required_mask,
 };
 
 static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 				  unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct dev_archdata *sd;
 
 	/* We are only intereted in device addition */
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	sd = &dev->archdata;
-	sd->max_direct_dma_addr = 0;
-
 	/* May need to bounce if the device can't address all of DRAM */
 	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
 		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 9def69c8f602..1e191eb3f0ec 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -30,11 +30,10 @@
 static u64 __maybe_unused get_pfn_limit(struct device *dev)
 {
 	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
-	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
-		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
+	if (dev->bus_dma_mask && dev->dma_ops == &powerpc_swiotlb_dma_ops)
+		pfn = min_t(u64, pfn, dev->bus_dma_mask >> PAGE_SHIFT);
 #endif
 
 	return pfn;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 561f97d698cc..b710cee023a2 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -117,9 +117,8 @@ static u64 pci64_dma_offset;
 static void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct dev_archdata *sd = &pdev->dev.archdata;
 
-	sd->max_direct_dma_addr =
+	pdev->dev.bus_dma_mask =
 		hose->dma_window_base_cur + hose->dma_window_size;
 }
 
@@ -144,6 +143,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 * mapping that allows addressing any RAM address from across PCI.
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
+		dev->bus_dma_mask = 0;
 		set_dma_ops(dev, &dma_nommu_ops);
 		set_dma_offset(dev, pci64_dma_offset);
 	}
-- 
2.20.1
