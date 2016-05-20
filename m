From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V5 2/7] documentation: iommu: Add bindings for msm,iommu-v0 ip
Date: Fri, 20 May 2016 16:24:49 +0530
Message-ID: <1463741694-1735-3-git-send-email-sricharan@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org, architt@codeaurora.org, arnd@arndb.de
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The MSM IOMMU is an implementation compatible with the ARM VMSA short
descriptor page tables. It provides address translation for bus masters outside
of the CPU, each connected to the IOMMU through a port called micro-TLB.
Adding the DT bindings for the same.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
new file mode 100644
index 0000000..2023638
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
@@ -0,0 +1,64 @@
+* QCOM IOMMU
+
+The MSM IOMMU is an implementation compatible with the ARM VMSA short
+descriptor page tables. It provides address translation for bus masters outside
+of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+Required Properties:
+
+  - compatible: Must contain "qcom,apq8064-iommu".
+  - reg: Base address and size of the IOMMU registers.
+  - interrupts: Specifiers for the MMU fault interrupts. For instances that
+    support secure mode two interrupts must be specified, for non-secure and
+    secure mode, in that order. For instances that don't support secure mode a
+    single interrupt must be specified.
+  - #iommu-cells: The number of cells needed to specify the stream id. This
+		  is always 1.
+  - qcom,ncb:	  The total number of context banks in the IOMMU.
+  - clocks	: List of clocks to be used during SMMU register access. See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for information about the format. For each clock specified
+		  here, there must be a corresponding entry in clock-names
+		  (see below).
+
+  - clock-names	: List of clock names corresponding to the clocks specified in
+		  the "clocks" property (above).
+		  Should be "smmu_pclk" for specifying the interface clock
+		  required for iommu's register accesses.
+		  Should be "smmu_clk" for specifying the functional clock
+		  required by iommu for bus accesses.
+
+Each bus master connected to an IOMMU must reference the IOMMU in its device
+node with the following property:
+
+  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
+	    phandle to the IOMMU and the second cell is the stream id.
+	    A single master device can be connected to more than one iommu
+	    and multiple contexts in each of the iommu. So multiple entries
+	    are required to list all the iommus and the stream ids that the
+	    master is connected to.
+
+Example: mdp iommu and its bus master
+
+                mdp_port0: iommu@7500000 {
+			compatible = "qcom,apq8064-iommu";
+			#iommu-cells = <1>;
+			clock-names =
+			    "smmu_pclk",
+			    "smmu_clk";
+			clocks =
+			    <&mmcc SMMU_AHB_CLK>,
+			    <&mmcc MDP_AXI_CLK>;
+			reg = <0x07500000 0x100000>;
+			interrupts =
+			    <GIC_SPI 63 0>,
+			    <GIC_SPI 64 0>;
+			qcom,ncb = <2>;
+		};
+
+		mdp: qcom,mdp@5100000 {
+			compatible = "qcom,mdp";
+			...
+			iommus = <&mdp_port0 0
+				  &mdp_port0 2>;
+		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
