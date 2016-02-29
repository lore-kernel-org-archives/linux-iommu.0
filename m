From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Add r8a7795 DT binding
Date: Mon, 29 Feb 2016 23:33:09 +0900
Message-ID: <20160229143309.28517.77269.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, joro@8bytes.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, galak@codeaurora.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the IPMMU DT binding documentation to include the r8a7795 compat
string as well as the "renesas,ipmmu-main" property that on r8a7795 will
be used to describe the topology and the relationship between the various
cache IPMMU instances and the main IPMMU.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against linux-next tag next-20160229

 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |   15 ++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- 0001/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ work/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt	2016-02-29 23:25:15.540513000 +0900
@@ -7,23 +7,34 @@ connected to the IPMMU through a port ca
 
 Required Properties:
 
-  - compatible: Must contain SoC-specific and generic entries from below.
+  - compatible: Must contain SoC-specific and generic entry below in case
+    the device is compatible with the R-Car Gen2 VMSA-compatible IPMMU.
 
     - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
     - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
     - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
     - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
     - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
+    - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
     - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
 
   - reg: Base address and size of the IPMMU registers.
   - interrupts: Specifiers for the MMU fault interrupts. For instances that
     support secure mode two interrupts must be specified, for non-secure and
     secure mode, in that order. For instances that don't support secure mode a
-    single interrupt must be specified.
+    single interrupt must be specified. Not required for cache IPMMUs.
 
   - #iommu-cells: Must be 1.
 
+Optional properties:
+
+  - renesas,ipmmu-main: reference to the main IPMMU instance in two cells.
+    The first cell is a phandle to the main IPMMU and the second cell is
+    the interrupt bit number associated with the particular cache IPMMU device.
+    The interrupt bit number needs to match the main IPMMU IMSSTR register.
+    Only used by cache IPMMU instances.
+
+
 Each bus master connected to an IPMMU must reference the IPMMU in its device
 node with the following property:
 
