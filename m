From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 05/25] MIPS: Octeon: refactor swiotlb code
Date: Fri, 15 Jun 2018 13:08:34 +0200
Message-ID: <20180615110854.19253-6-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615110854.19253-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Share a common set of swiotlb operations, and to instead branch out in
__phys_to_dma/__dma_to_phys for the PCI vs non-PCI case.  Also use const
structures for the PCI methods so that attackers can't use them as
exploit vectors.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/cavium-octeon/dma-octeon.c          | 161 ++++++++----------
 .../asm/mach-cavium-octeon/dma-coherence.h    |   2 -
 arch/mips/pci/pci-octeon.c                    |   2 -
 3 files changed, 71 insertions(+), 94 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index e5d00c79bd26..7f0c9f926b6e 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -23,10 +23,16 @@
 #include <asm/octeon/octeon.h>
 
 #ifdef CONFIG_PCI
+#include <linux/pci.h>
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-pci-defs.h>
 
+struct octeon_dma_map_ops {
+	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
+	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
+};
+
 static dma_addr_t octeon_hole_phys_to_dma(phys_addr_t paddr)
 {
 	if (paddr >= CVMX_PCIE_BAR1_PHYS_BASE && paddr < (CVMX_PCIE_BAR1_PHYS_BASE + CVMX_PCIE_BAR1_PHYS_SIZE))
@@ -60,6 +66,11 @@ static phys_addr_t octeon_gen1_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_gen1_ops = {
+	.phys_to_dma	= octeon_gen1_phys_to_dma,
+	.dma_to_phys	= octeon_gen1_dma_to_phys,
+};
+
 static dma_addr_t octeon_gen2_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return octeon_hole_phys_to_dma(paddr);
@@ -70,6 +81,11 @@ static phys_addr_t octeon_gen2_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return octeon_hole_dma_to_phys(daddr);
 }
 
+static const struct octeon_dma_map_ops octeon_gen2_ops = {
+	.phys_to_dma	= octeon_gen2_phys_to_dma,
+	.dma_to_phys	= octeon_gen2_dma_to_phys,
+};
+
 static dma_addr_t octeon_big_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (paddr >= 0x410000000ull && paddr < 0x420000000ull)
@@ -92,6 +108,11 @@ static phys_addr_t octeon_big_dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_big_ops = {
+	.phys_to_dma	= octeon_big_phys_to_dma,
+	.dma_to_phys	= octeon_big_dma_to_phys,
+};
+
 static dma_addr_t octeon_small_phys_to_dma(struct device *dev,
 					   phys_addr_t paddr)
 {
@@ -120,6 +141,32 @@ static phys_addr_t octeon_small_dma_to_phys(struct device *dev,
 	return daddr;
 }
 
+static const struct octeon_dma_map_ops octeon_small_ops = {
+	.phys_to_dma	= octeon_small_phys_to_dma,
+	.dma_to_phys	= octeon_small_dma_to_phys,
+};
+
+static const struct octeon_dma_map_ops *octeon_pci_dma_ops;
+
+void __init octeon_pci_dma_init(void)
+{
+	switch (octeon_dma_bar_type) {
+	case OCTEON_DMA_BAR_TYPE_PCIE:
+		octeon_pci_dma_ops = &octeon_gen1_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_PCIE2:
+		octeon_pci_dma_ops = &octeon_gen2_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_BIG:
+		octeon_pci_dma_ops = &octeon_big_ops;
+		break;
+	case OCTEON_DMA_BAR_TYPE_SMALL:
+		octeon_pci_dma_ops = &octeon_small_ops;
+		break;
+	default:
+		BUG();
+	}
+}
 #endif /* CONFIG_PCI */
 
 static dma_addr_t octeon_dma_map_page(struct device *dev, struct page *page,
@@ -165,57 +212,37 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-static dma_addr_t octeon_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	return paddr;
-}
-
-static phys_addr_t octeon_unity_dma_to_phys(struct device *dev, dma_addr_t daddr)
-{
-	return daddr;
-}
-
-struct octeon_dma_map_ops {
-	const struct dma_map_ops dma_map_ops;
-	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
-	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
-};
-
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
-						      struct octeon_dma_map_ops,
-						      dma_map_ops);
-
-	return ops->phys_to_dma(dev, paddr);
+#ifdef CONFIG_PCI
+	if (dev && dev_is_pci(dev))
+		return octeon_pci_dma_ops->phys_to_dma(dev, paddr);
+#endif
+	return paddr;
 }
 
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
-						      struct octeon_dma_map_ops,
-						      dma_map_ops);
-
-	return ops->dma_to_phys(dev, daddr);
+#ifdef CONFIG_PCI
+	if (dev && dev_is_pci(dev))
+		return octeon_pci_dma_ops->dma_to_phys(dev, daddr);
+#endif
+	return daddr;
 }
 
-static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
-	.dma_map_ops = {
-		.alloc = octeon_dma_alloc_coherent,
-		.free = swiotlb_free,
-		.map_page = octeon_dma_map_page,
-		.unmap_page = swiotlb_unmap_page,
-		.map_sg = octeon_dma_map_sg,
-		.unmap_sg = swiotlb_unmap_sg_attrs,
-		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-		.sync_single_for_device = octeon_dma_sync_single_for_device,
-		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-		.sync_sg_for_device = octeon_dma_sync_sg_for_device,
-		.mapping_error = swiotlb_dma_mapping_error,
-		.dma_supported = swiotlb_dma_supported
-	},
-	.phys_to_dma = octeon_unity_phys_to_dma,
-	.dma_to_phys = octeon_unity_dma_to_phys
+static const struct dma_map_ops octeon_swiotlb_ops = {
+	.alloc			= octeon_dma_alloc_coherent,
+	.free			= swiotlb_free,
+	.map_page		= octeon_dma_map_page,
+	.unmap_page		= swiotlb_unmap_page,
+	.map_sg			= octeon_dma_map_sg,
+	.unmap_sg		= swiotlb_unmap_sg_attrs,
+	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
+	.sync_single_for_device	= octeon_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device	= octeon_dma_sync_sg_for_device,
+	.mapping_error		= swiotlb_dma_mapping_error,
+	.dma_supported		= swiotlb_dma_supported
 };
 
 char *octeon_swiotlb;
@@ -281,51 +308,5 @@ void __init plat_swiotlb_setup(void)
 	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
 		panic("Cannot allocate SWIOTLB buffer");
 
-	mips_dma_map_ops = &octeon_linear_dma_map_ops.dma_map_ops;
+	mips_dma_map_ops = &octeon_swiotlb_ops;
 }
-
-#ifdef CONFIG_PCI
-static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
-	.dma_map_ops = {
-		.alloc = octeon_dma_alloc_coherent,
-		.free = swiotlb_free,
-		.map_page = octeon_dma_map_page,
-		.unmap_page = swiotlb_unmap_page,
-		.map_sg = octeon_dma_map_sg,
-		.unmap_sg = swiotlb_unmap_sg_attrs,
-		.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
-		.sync_single_for_device = octeon_dma_sync_single_for_device,
-		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-		.sync_sg_for_device = octeon_dma_sync_sg_for_device,
-		.mapping_error = swiotlb_dma_mapping_error,
-		.dma_supported = swiotlb_dma_supported
-	},
-};
-
-const struct dma_map_ops *octeon_pci_dma_map_ops;
-
-void __init octeon_pci_dma_init(void)
-{
-	switch (octeon_dma_bar_type) {
-	case OCTEON_DMA_BAR_TYPE_PCIE2:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen2_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen2_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_PCIE:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_gen1_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_gen1_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_BIG:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_big_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_big_dma_to_phys;
-		break;
-	case OCTEON_DMA_BAR_TYPE_SMALL:
-		_octeon_pci_dma_map_ops.phys_to_dma = octeon_small_phys_to_dma;
-		_octeon_pci_dma_map_ops.dma_to_phys = octeon_small_dma_to_phys;
-		break;
-	default:
-		BUG();
-	}
-	octeon_pci_dma_map_ops = &_octeon_pci_dma_map_ops.dma_map_ops;
-}
-#endif /* CONFIG_PCI */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 6eb1ee548b11..c5cdeea495f8 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -72,8 +72,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 
-struct dma_map_ops;
-extern const struct dma_map_ops *octeon_pci_dma_map_ops;
 extern char *octeon_swiotlb;
 
 #endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 3e92a06fa772..a20697df3539 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -166,8 +166,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
 	}
 
-	dev->dev.dma_ops = octeon_pci_dma_map_ops;
-
 	return 0;
 }
 
-- 
2.17.1
