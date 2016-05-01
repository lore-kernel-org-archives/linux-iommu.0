From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V3 2/7] documentation: iommu: Add bindings for msm,iommu-v0 ip
Date: Mon,  2 May 2016 00:24:30 +0530
Message-ID: <1462128875-20988-3-git-send-email-sricharan@codeaurora.org>
References: <1462128875-20988-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462128875-20988-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The MSM IOMMU is an implementation compatible with the ARM VMSA short
descriptor page tables. It provides address translation for bus masters outside
of the CPU, each connected to the IOMMU through a port called micro-TLB.
Adding the DT bindings for the same.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
new file mode 100644
index 0000000..63b4f96
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
@@ -0,0 +1,62 @@
+* MSM IOMMU
+
+The MSM IOMMU is an implementation compatible with the ARM VMSA short
+descriptor page tables. It provides address translation for bus masters outside
+of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+Required Properties:
+
+  - compatible: Must contain "msm,iommu-v0".
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
+		  the "clocks" property (above). See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for more info.
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
+			compatible = "msm,iommu-v0";
+			#iommu-cells = <1>;
+			clock-names =
+			    "smmu_pclk",
+			    "iommu_clk";
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
