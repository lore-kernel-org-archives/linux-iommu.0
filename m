From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 01/25] arm: dma-mapping: add support for creating reserved
	mappings in iova space
Date: Mon, 04 May 2015 10:15:56 +0200
Message-ID: <1430727380-10912-2-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1430727380-10912-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Some devices (like frame buffers) are enabled by bootloader and configured
to perform DMA operations automatically (like displaying boot logo or splash
screen). Such devices operate and perform DMA operation usually until the
proper driver for them is loaded and probed. However before that happens,
system usually loads IOMMU drivers and configures dma parameters for each
device. When such initial configuration is created and enabled, it usually
contains empty translation rules betweem IO address space and physical
memory, because no buffers nor memory regions have been requested by the
respective driver.

This patch adds support for "iommu-reserved-mapping", which can be used
to provide definitions for mappings that need to be created on system
boot to let such devices (enabled by bootloader) to operate properly
until respective driver is probed.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt |  44 +++++++++
 arch/arm/mm/dma-mapping.c                         | 112 ++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..fd54e6b597f0 100644
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
+system usually loads IOMMU drivers and configures dma parameters for each
+device. When such initial configuration is created and enabled, it usually
+contains empty translation rules betweem IO address space and physical
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
index 7e7583ddd607..3b4a94695b68 100644
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
@@ -2048,6 +2092,66 @@ void arm_iommu_detach_device(struct device *dev)
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
+	int len, naddr, nsize;
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
+
+	if (len < 2 * naddr + nsize) {
+		dev_err(dev, "invalid length (%d cells) of %s property\n",
+			len, name);
+		return -EINVAL;
+	}
+
+	phys = of_read_number(prop, naddr);
+	dma = of_read_number(prop + naddr, naddr);
+	size = of_read_number(prop + 2*naddr, nsize);
+
+	return arm_iommu_add_reserved(dev, domain, phys, dma, size);
+}
+
 static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
 {
 	return coherent ? &iommu_coherent_ops : &iommu_ops;
@@ -2068,6 +2172,14 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
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
