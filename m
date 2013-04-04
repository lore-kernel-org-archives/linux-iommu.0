From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Thu,  4 Apr 2013 17:50:59 +0100
Message-ID: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

This patch adds a description of the device tree binding for the ARM
System MMU architecture.

Cc: Rob Herring <robherring2@gmail.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hello,

The driver for this is still a WIP. Both Andreas and myself have prototype
code, but we're planning to merge that together to get something more
general. Deciding on the binding is a good first step.

All comments welcome,

Will

 .../devicetree/bindings/iommu/arm,smmu.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
new file mode 100644
index 0000000..938325f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -0,0 +1,61 @@
+* ARM System MMU Architecture Implementation
+
+ARM SoCs may contain an implementation of the ARM System Memory
+Management Unit Architecture, which can be used to provide 1 or 2 stages
+of address translation to bus masters external to the CPU.
+
+The SMMU may also raise interrupts in response to various fault
+conditions.
+
+** System MMU required properties:
+
+- compatible    : Should be one of "arm,smmu-v1" or "arm,smmu-v2"
+                  depending on the version of the architecture
+                  implemented.
+
+- reg           : Base address and size of the SMMU.
+
+- #global-interrupts : The number of global interrupts exposed by the
+                       device.
+
+- interrupts    : Interrupt list, with the first #global-irqs entries
+                  corresponding to the global interrupts and any
+                  following entries corresponding to context interrupts,
+                  specified in order of their indexing by the SMMU.
+
+- mmu-masters   : A list of phandles to device nodes representing bus
+                  masters for which the SMMU can provide a translation.
+
+- stream-ids    : A list of 16-bit values corresponding to the StreamIDs
+                  for the devices listed in the mmu-masters property.
+                  This list must be same length as mmu-masters, so
+                  masters with multiple stream-ids will have multiple
+                  entries in mmu-masters.
+
+** System MMU optional properties:
+
+- smmu-parent   : When multiple SMMUs are chained together, this
+                  property can be used to provide a phandle to the
+                  parent SMMU (that is the next SMMU on the path going
+                  from the mmu-masters towards memory) node for this
+                  SMMU.
+
+Example:
+
+        smmu {
+                compatible = "arm,smmu-v1";
+                reg = <0xba5e0000 0x10000>;
+                #global-interrupts = <2>;
+                interrupts = <0 32 4>,
+                             <0 33 4>,
+                             <0 34 4>, /* This is the first context interrupt */
+                             <0 35 4>,
+                             <0 36 4>,
+                             <0 37 4>;
+                mmu-masters = <&dma0>,
+                              <&dma0>,
+                              <&dma1>;
+                stream-ids  = <0xd01d>,
+                              <0xd01e>,
+                              <0xd11c>;
+        };
-- 
1.8.0
