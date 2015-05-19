From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 24/25] ARM: DMA-mapping: add support for creating reserved
 mappings in iova space
Date: Tue, 19 May 2015 15:20:44 +0200
Message-ID: <1432041645-11172-25-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Some devices (like frame buffers) are enabled by bootloader and configured
to perform DMA operations automatically (like displaying boot logo or splash
screen). Such devices operate and perform DMA operation usually until the
proper driver for them is loaded and probed. However before that happens,
system usually loads IOMMU drivers and configures DMA parameters for each
device. When such initial configuration is created and enabled, it usually
contains empty translation rules between IO address space and physical
memory, because no buffers nor memory regions have been requested by the
respective driver.

This patch adds support for "iommu-reserved-mapping", which can be used
to provide definitions for mappings that need to be created on system
boot to let such devices (enabled by bootloader) to operate properly
until respective driver is probed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/iommu/iommu.txt |  44 ++++++++
 arch/arm/mm/dma-mapping.c                         | 121 ++++++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..da620d1ff976 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,35 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- iommu-reserved-mapping: A list of entries describing additional
+  reserved mapping, that will be inserted to the default IO address space
+  created for given master device. Each entry consist of IO address,
+  physical memory address and size of the region.
+
+Some devices (like frame buffers) are enabled by bootloader and configured
+to perform DMA operations automatically (like displaying boot logo or splash
+screen). Such devices operate and perform DMA operation usually until the
+proper driver for them is loaded and probed. However before that happens,
+system usually loads IOMMU drivers and configures DMA parameters for each
+device. When such initial configuration is created and enabled, it usually
+contains empty translation rules between IO address space and physical
+memory, because no buffers nor memory regions have been requested by the
+respective driver.
+
+To avoid IOMMU page fault, one can provide "iommu-reserved-mapping"
+property, which defines all memory regions which must be mapped to IO
+address space to boot properly when device has been enabled by the
+bootloader. More than one region can be defined for given master device.
+Each region is defined by the following triplet: first entry is IO
+address (encoded in "address" cells), second is base physical memory
+address for this regions (also encoded in "address" cells) and the last
+is size of the region (encoded in "size" cells). To ensure that that
+given master device will not trigger page fault after enabling IOMMU,
+one should define identity mapping between physical memory and IO
+address space for the range of addresses accessed by the device.
+
 
 Notes:
 ======
@@ -113,6 +142,21 @@ Single-master IOMMU:
 		iommus = <&{/iommu}>;
 	};
 
+
+Single-master IOMMU, which has been left enabled by bootloader:
+---------------------------------------------------------------
+
+	iommu {
+		#iommu-cells = <0>;
+	};
+
+	master {
+		iommus = <&{/iommu}>;
+		/* bootloader configures framebuffer at 0x40000000 (32MiB)
+		iommu-reserved-mapping = <0x40000000 0x40000000 0x2000000>;
+	};
+
+
 Multiple-master IOMMU with fixed associations:
 ----------------------------------------------
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7e7583ddd607..423cb9f8ab0d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1019,6 +1019,50 @@ fs_initcall(dma_debug_do_init);
 
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
 
+static inline int __reserve_iova(struct dma_iommu_mapping *mapping,
+				 dma_addr_t iova, size_t size)
+{
+	unsigned long count, start;
+	unsigned long flags;
+	int i, sbitmap, ebitmap;
+
+	if (iova < mapping->base)
+		return -EINVAL;
+
+	start = (iova - mapping->base) >> PAGE_SHIFT;
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	sbitmap = start / mapping->bits;
+	ebitmap = (start + count) / mapping->bits;
+	start = start % mapping->bits;
+
+	if (ebitmap > mapping->extensions)
+		return -EINVAL;
+
+	spin_lock_irqsave(&mapping->lock, flags);
+
+	for (i = mapping->nr_bitmaps; i <= ebitmap; i++) {
+		if (extend_iommu_mapping(mapping)) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return -ENOMEM;
+		}
+	}
+
+	for (i = sbitmap; count && i < mapping->nr_bitmaps; i++) {
+		int bits = count;
+
+		if (bits + start > mapping->bits)
+			bits = mapping->bits - start;
+		bitmap_set(mapping->bitmaps[i], start, bits);
+		start = 0;
+		count -= bits;
+	}
+
+	spin_unlock_irqrestore(&mapping->lock, flags);
+
+	return 0;
+}
+
 static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 				      size_t size)
 {
@@ -2048,6 +2092,75 @@ void arm_iommu_detach_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
+static int arm_iommu_add_reserved(struct device *dev,
+			struct dma_iommu_mapping *domain, phys_addr_t phys,
+			dma_addr_t dma, size_t size)
+{
+	int ret;
+
+	ret = __reserve_iova(domain, dma, size);
+	if (ret) {
+		dev_err(dev, "failed to reserve mapping\n");
+		return -EINVAL;
+	}
+
+	ret = iommu_map(domain->domain, dma, phys, size, IOMMU_READ);
+	if (ret != 0) {
+		dev_err(dev, "create IOMMU mapping\n");
+		return ret;
+	}
+
+	dev_info(dev, "created reserved DMA mapping (%pa -> %pad, %zu bytes)\n",
+		 &phys, &dma, size);
+
+	return 0;
+}
+
+static int arm_iommu_init_reserved(struct device *dev,
+				   struct dma_iommu_mapping *domain)
+{
+	const char *name = "iommu-reserved-mapping";
+	const __be32 *prop = NULL;
+	int ret = 0, len, naddr, nsize, regions, cells;
+	struct device_node *node = dev->of_node;
+	phys_addr_t phys;
+	dma_addr_t dma;
+	size_t size;
+
+	if (!node)
+		return 0;
+
+	naddr = of_n_addr_cells(node);
+	nsize = of_n_size_cells(node);
+
+	prop = of_get_property(node, name, &len);
+	if (!prop)
+		return 0;
+
+	len /= sizeof(u32);
+	cells = 2 * naddr + nsize;
+	regions = len / cells;
+
+	if (len % cells) {
+		dev_err(dev, "invalid length (%d cells) of %s property\n",
+			len, name);
+		return -EINVAL;
+	}
+
+	while (regions--) {
+		phys = of_read_number(prop, naddr);
+		dma = of_read_number(prop + naddr, naddr);
+		size = of_read_number(prop + 2*naddr, nsize);
+		prop += cells;
+
+		ret = arm_iommu_add_reserved(dev, domain, phys, dma, size);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
 {
 	return coherent ? &iommu_coherent_ops : &iommu_ops;
@@ -2068,6 +2181,14 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return false;
 	}
 
+	if (arm_iommu_init_reserved(dev, mapping) != 0) {
+		pr_warn("Failed to initialize reserved mapping for device %s\n",
+			dev_name(dev));
+		__arm_iommu_detach_device(dev);
+		arm_iommu_release_mapping(mapping);
+		return false;
+	}
+
 	if (__arm_iommu_attach_device(dev, mapping)) {
 		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
 				dev_name(dev));
-- 
1.9.2
