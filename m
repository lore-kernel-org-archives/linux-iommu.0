From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 05/10] iommu/ipmmu-vmsa: Add device tree bindings documentation
Date: Tue, 16 Dec 2014 15:44:12 +0200
Message-ID: <1418737457-22042-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt

Cc: devicetree@vger.kernel.org

Changes compared to v1:

- Extend the register range over both the base registers bank and the
  non-secure aliases
- Specify both the secure and non-secure interrupt, when applicable

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
new file mode 100644
index 000000000000..ba225a091dcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -0,0 +1,41 @@
+* Renesas VMSA-Compatible IOMMU
+
+The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
+It provides address translation for bus masters outside of the CPU, each
+connected to the IPMMU through a port called micro-TLB.
+
+
+Required Properties:
+
+  - compatible: Must contain "renesas,ipmmu-vmsa".
+  - reg: Base address and size of the IPMMU registers.
+  - interrupts: Specifiers for the MMU fault interrupts. For instances that
+    support secure mode two interrupts must be specified, for non-secure and
+    secure mode, in that order. For instances that don't support secure mode a
+    single interrupt must be specified.
+
+  - #iommu-cells: Must be 1.
+
+Each bus master connected to an IPMMU must reference the IPMMU in its device
+node with the following property:
+
+  - iommus: A reference to the IPMMU in two cells. The first cell is a phandle
+    to the IPMMU and the second cell the number of the micro-TLB that the
+    device is connected to.
+
+
+Example: R8A7791 IPMMU-MX and VSP1-D0 bus master
+
+	ipmmu_mx: mmu@fe951800 {
+		compatible = "renasas,ipmmu-vmsa";
+		reg = <0 0xfe951000 0 0x1000>;
+		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+	};
+
+	vsp1@fe928000 {
+		...
+		iommus = <&ipmmu_mx 13>;
+		...
+	};
-- 
2.0.4

