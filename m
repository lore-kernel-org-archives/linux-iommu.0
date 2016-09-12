From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 05/22] Docs: dt: document ARM SMMUv3 generic binding usage
Date: Mon, 12 Sep 2016 17:13:43 +0100
Message-ID: <2273645f1fa5c76b6b98b5fd03804ab8b55a7691.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We're about to ratify our use of the generic binding, so document it.

CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- Reference PCI "iommu-map" binding instead, as that's our main concern
- Fix "IDs" typo
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 7b94c88cf2ee..be57550e14e4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -27,6 +27,12 @@ the PCIe specification.
                       * "cmdq-sync" - CMD_SYNC complete
                       * "gerror"    - Global Error activated
 
+- #iommu-cells      : See the generic IOMMU binding described in
+                        devicetree/bindings/pci/pci-iommu.txt
+                      for details. For SMMUv3, must be 1, with each cell
+                      describing a single stream ID. All possible stream
+                      IDs which a device may emit must be described.
+
 ** SMMUv3 optional properties:
 
 - dma-coherent      : Present if DMA operations made by the SMMU (page
@@ -54,6 +60,6 @@ the PCIe specification.
                              <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
                 dma-coherent;
-                #iommu-cells = <0>;
+                #iommu-cells = <1>;
                 msi-parent = <&its 0xff0000>;
         };
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
