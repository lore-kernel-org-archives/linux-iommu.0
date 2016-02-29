From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 10/12] Docs: dt: document ARM SMMU generic binding usage
Date: Mon, 29 Feb 2016 13:46:19 +0000
Message-ID: <af1ce6d7d69e340ac839c69b475728f7aa50ff23.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Document how the generic "iommus" binding should be used to describe ARM
SMMU stream IDs instead of the old "mmu-masters" binding.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 40 ++++++++++++++--------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 7180745..a213f74 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -34,12 +34,11 @@ conditions.
                   interrupt per context bank. In the case of a single,
                   combined interrupt, it must be listed multiple times.
 
-- mmu-masters   : A list of phandles to device nodes representing bus
-                  masters for which the SMMU can provide a translation
-                  and their corresponding StreamIDs (see example below).
-                  Each device node linked from this list must have a
-                  "#stream-id-cells" property, indicating the number of
-                  StreamIDs associated with it.
+- #iommu-cells  : See Documentation/devicetree/bindings/iommu/iommu.txt
+                  for details. Should be 1, where each "iommus" entry on
+                  the device represents a distinct stream ID emitted by
+                  that device into the relevant SMMU. Cells beyond 1 are
+                  reserved for future use.
 
 ** System MMU optional properties:
 
@@ -55,9 +54,19 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
-Example:
+** Deprecated properties:
 
-        smmu {
+- mmu-masters (deprecated in favour of the generic "iommus" binding) :
+                  A list of phandles to device nodes representing bus
+                  masters for which the SMMU can provide a translation
+                  and their corresponding StreamIDs (see example below).
+                  Each device node linked from this list must have a
+                  "#stream-id-cells" property, indicating the number of
+                  StreamIDs associated with it.
+
+** Example:
+
+        smmu1: iommu {
                 compatible = "arm,smmu-v1";
                 reg = <0xba5e0000 0x10000>;
                 #global-interrupts = <2>;
@@ -67,11 +76,12 @@ Example:
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
         };
+
+        /* device with two stream IDs, 0 and 7 */
+        master {
+                iommus = <&smmu1 0>,
+                         <&smmu1 7>;
+        };
+
-- 
2.7.2.333.g70bd996.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
