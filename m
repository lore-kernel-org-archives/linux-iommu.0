From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 18/22] Docs: dt: document ARM SMMU generic binding usage
Date: Mon, 12 Sep 2016 17:13:56 +0100
Message-ID: <145a4e2cd695af51c32d907e305f9c605c819cea.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Document how the generic "iommus" binding should be used to describe ARM
SMMU stream IDs instead of the old "mmu-masters" binding.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- Remove missed reference to old "mmu-masters" example
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 63 ++++++++++++++++------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 19fe6f2c83f6..e862d1485205 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -35,12 +35,16 @@ conditions.
                   interrupt per context bank. In the case of a single,
                   combined interrupt, it must be listed multiple times.
 
-- mmu-masters   : A list of phandles to device nodes representing bus
-                  masters for which the SMMU can provide a translation
-                  and their corresponding StreamIDs (see example below).
-                  Each device node linked from this list must have a
-                  "#stream-id-cells" property, indicating the number of
-                  StreamIDs associated with it.
+- #iommu-cells  : See Documentation/devicetree/bindings/iommu/iommu.txt
+                  for details. With a value of 1, each "iommus" entry
+                  represents a distinct stream ID emitted by that device
+                  into the relevant SMMU.
+
+                  SMMUs with stream matching support and complex masters
+                  may use a value of 2, where the second cell represents
+                  an SMR mask to combine with the ID in the first cell.
+                  Care must be taken to ensure the set of matched IDs
+                  does not result in conflicts.
 
 ** System MMU optional properties:
 
@@ -56,9 +60,20 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
-Example:
+** Deprecated properties:
 
-        smmu {
+- mmu-masters (deprecated in favour of the generic "iommus" binding) :
+                  A list of phandles to device nodes representing bus
+                  masters for which the SMMU can provide a translation
+                  and their corresponding Stream IDs. Each device node
+                  linked from this list must have a "#stream-id-cells"
+                  property, indicating the number of Stream ID
+                  arguments associated with its phandle.
+
+** Examples:
+
+        /* SMMU with stream matching or stream indexing */
+        smmu1: iommu {
                 compatible = "arm,smmu-v1";
                 reg = <0xba5e0000 0x10000>;
                 #global-interrupts = <2>;
@@ -68,11 +83,29 @@ Example:
                              <0 35 4>,
                              <0 36 4>,
                              <0 37 4>;
-
-                /*
-                 * Two DMA controllers, the first with two StreamIDs (0xd01d
-                 * and 0xd01e) and the second with only one (0xd11c).
-                 */
-                mmu-masters = <&dma0 0xd01d 0xd01e>,
-                              <&dma1 0xd11c>;
+                #iommu-cells = <1>;
+        };
+
+        /* device with two stream IDs, 0 and 7 */
+        master1 {
+                iommus = <&smmu1 0>,
+                         <&smmu1 7>;
+        };
+
+
+        /* SMMU with stream matching */
+        smmu2: iommu {
+                ...
+                #iommu-cells = <2>;
+        };
+
+        /* device with stream IDs 0 and 7 */
+        master2 {
+                iommus = <&smmu2 0 0>,
+                         <&smmu2 7 0>;
+        };
+
+        /* device with stream IDs 1, 17, 33 and 49 */
+        master3 {
+                iommus = <&smmu2 1 0x30>;
         };
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
