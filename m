From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] ARM: dma-mapping: Don't tear third-party mappings
Date: Tue, 16 May 2017 18:14:34 +0300
Message-ID: <20170516151434.18830-1-laurent.pinchart+renesas@ideasonboard.com>
References: <6d9fa319-4401-c47a-7985-9a349838bcaf@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <6d9fa319-4401-c47a-7985-9a349838bcaf@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

arch_setup_dma_ops() is used in device probe code paths to create an
IOMMU mapping and attach it to the device. The function assumes that the
device is attached to a device-specific IOMMU instance (or at least a
device-specific TLB in a shared IOMMU instance) and thus creates a
separate mapping for every device.

On several systems (Renesas R-Car Gen2 being one of them), that
assumption is not true, and IOMMU mappings must be shared between
multiple devices. In those cases the IOMMU driver knows better than the
generic ARM dma-mapping layer and attaches mapping to devices manually
with arm_iommu_attach_device(), which sets the DMA ops for the device.

The arch_setup_dma_ops() function takes this into account and bails out
immediately if the device already has DMA ops assigned. However, the
corresponding arch_teardown_dma_ops() function, called from driver
unbind code paths (including probe deferral), will tear the mapping down
regardless of who created it. When the device is reprobed
arch_setup_dma_ops() will be called again but won't perform any
operation as the DMA ops will still be set.

We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
However, we can't do so unconditionally, as then a new mapping would be
created by arch_setup_dma_ops() when the device is reprobed, regardless
of whether the device needs to share a mapping or not. We must thus keep
track of whether arch_setup_dma_ops() created the mapping, and only in
that case tear it down in arch_teardown_dma_ops().

Keep track of that information in the dev_archdata structure. As the
structure is embedded in all instances of struct device let's not grow
it, but turn the existing dma_coherent bool field into a bitfield that
can be used for other purposes.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/include/asm/device.h | 3 ++-
 arch/arm/mm/dma-mapping.c     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 36ec9c8f6e16..3234fe9bba6e 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -19,7 +19,8 @@ struct dev_archdata {
 #ifdef CONFIG_XEN
 	const struct dma_map_ops *dev_dma_ops;
 #endif
-	bool dma_coherent;
+	unsigned int dma_coherent:1;
+	unsigned int dma_ops_setup:1;
 };
 
 struct omap_device;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c742dfd2967b..e0272f9140e2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2430,9 +2430,14 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dev->dma_ops = xen_dma_ops;
 	}
 #endif
+	dev->archdata.dma_ops_setup = true;
 }
 
 void arch_teardown_dma_ops(struct device *dev)
 {
+	if (!dev->archdata.dma_ops_setup)
+		return;
+
 	arm_teardown_iommu_dma_ops(dev);
+	set_dma_ops(dev, NULL);
 }
-- 
Regards,

Laurent Pinchart
