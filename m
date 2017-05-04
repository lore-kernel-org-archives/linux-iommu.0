From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] Docs: dt: document qcom iommu bindings
Date: Thu,  4 May 2017 09:34:33 -0400
Message-ID: <20170504133436.24288-2-robdclark@gmail.com>
References: <20170504133436.24288-1-robdclark@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170504133436.24288-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
new file mode 100644
index 0000000..0d50f84
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
+- #iommu-cells     : Must be 1.
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
+			interrupts = <GIC_SPI 70 0>;
+		};
+
+		// venus_ns:
+		iommu-ctx@5000 {
+			compatible = "qcom,msm-iommu-v1-sec";
+			reg = <0x5000 0x1000>;
+			interrupts = <GIC_SPI 70 0>;
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
+		iommu-ctx@1f09000 {
+			compatible = "qcom,msm-iommu-v1-ns";
+			reg = <0x1000 0x1000>;
+			interrupts = <GIC_SPI 241 0>;
+		};
+
+		// gfx3d_priv:
+		iommu-ctx@1f0a000 {
+			compatible = "qcom,msm-iommu-v1-ns";
+			reg = <0x2000 0x1000>;
+			interrupts = <GIC_SPI 242 0>;
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
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
