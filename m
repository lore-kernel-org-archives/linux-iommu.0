From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 1/4] Docs: dt: document qcom iommu bindings
Date: Mon, 26 Jun 2017 08:43:49 -0400
Message-ID: <20170626124352.21726-2-robdclark@gmail.com>
References: <20170626124352.21726-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170626124352.21726-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
new file mode 100644
index 0000000..b2641ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -0,0 +1,121 @@
+* QCOM IOMMU v1 Implementation
+
+Qualcomm "B" family devices which are not compatible with arm-smmu have
+a similar looking IOMMU but without access to the global register space,
+and optionally requiring additional configuration to route context irqs
+to non-secure vs secure interrupt line.
+
+** Required properties:
+
+- compatible       : Should be one of:
+
+                        "qcom,msm8916-iommu"
+
+                     Followed by "qcom,msm-iommu-v1".
+
+- clock-names      : Should be a pair of "iface" (required for IOMMUs
+                     register group access) and "bus" (required for
+                     the IOMMUs underlying bus access).
+
+- clocks           : Phandles for respective clocks described by
+                     clock-names.
+
+- #address-cells   : must be 1.
+
+- #size-cells      : must be 1.
+
+- #iommu-cells     : Must be 1.  Index identifies the context-bank #.
+
+- ranges           : Base address and size of the iommu context banks.
+
+- qcom,iommu-secure-id  : secure-id.
+
+- List of sub-nodes, one per translation context bank.  Each sub-node
+  has the following required properties:
+
+  - compatible     : Should be one of:
+        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
+        - "qcom,msm-iommu-v1-sec" : secure context bank
+  - reg            : Base address and size of context bank within the iommu
+  - interrupts     : The context fault irq.
+
+** Optional properties:
+
+- reg              : Base address and size of the SMMU local base, should
+                     be only specified if the iommu requires configuration
+                     for routing of context bank irq's to secure vs non-
+                     secure lines.  (Ie. if the iommu contains secure
+                     context banks)
+
+
+** Examples:
+
+	apps_iommu: iommu@1e20000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#iommu-cells = <1>;
+		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
+		ranges = <0 0x1e20000 0x40000>;
+		reg = <0x1ef0000 0x3000>;
+		clocks = <&gcc GCC_SMMU_CFG_CLK>,
+			 <&gcc GCC_APSS_TCU_CLK>;
+		clock-names = "iface", "bus";
+		qcom,iommu-secure-id = <17>;
+
+		// mdp_0:
+		iommu-ctx@4000 {
+			compatible = "qcom,msm-iommu-v1-ns";
+			reg = <0x4000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		// venus_ns:
+		iommu-ctx@5000 {
+			compatible = "qcom,msm-iommu-v1-sec";
+			reg = <0x5000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	gpu_iommu: iommu@1f08000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#iommu-cells = <1>;
+		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
+		ranges = <0 0x1f08000 0x10000>;
+		clocks = <&gcc GCC_SMMU_CFG_CLK>,
+			 <&gcc GCC_GFX_TCU_CLK>;
+		clock-names = "iface", "bus";
+		qcom,iommu-secure-id = <18>;
+
+		// gfx3d_user:
+		iommu-ctx@1000 {
+			compatible = "qcom,msm-iommu-v1-ns";
+			reg = <0x1000 0x1000>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		// gfx3d_priv:
+		iommu-ctx@2000 {
+			compatible = "qcom,msm-iommu-v1-ns";
+			reg = <0x2000 0x1000>;
+			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	...
+
+	venus: video-codec@1d00000 {
+		...
+		iommus = <&apps_iommu 5>;
+	};
+
+	mdp: mdp@1a01000 {
+		...
+		iommus = <&apps_iommu 4>;
+	};
+
+	gpu@01c00000 {
+		...
+		iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
+	};
-- 
2.9.4
