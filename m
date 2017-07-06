From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V4 6/6] iommu/arm-smmu: Add support for qcom,msm8996-smmu-v2 clocks
Date: Thu,  6 Jul 2017 15:07:05 +0530
Message-ID: <1499333825-7658-7-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

qcom,msm8996-smmu-v2 is an arm,smmu-v2 implementation with
specific clock and power requirements. This smmu core is used
with multiple masters on msm8996, viz. mdss, video, etc.
Add bindings for the same.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 18 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                             | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 00331752d355..5d8e79775fae 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,6 +17,7 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+                        "qcom,msm8996-smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -74,11 +75,16 @@ conditions.
 - clock-names:    Should be "tcu" and "iface" for "arm,mmu-400",
                   "arm,mmu-401" and "arm,mmu-500"
 
+                  Should be "bus", and "iface" for "qcom,msm8996-smmu-v2"
+                  implementation.
+
                   "tcu" clock is required for smmu's register access using the
                   programming interface and ptw for downstream bus access. This
                   clock is also used for access to the TBU connected to the
                   master locally. Sometimes however, TBU is clocked along with
                   the master.
+                  "bus" clock for "qcom,msm8996-smmu-v2" is requierd for downstream
+                  bus access and for the smmu ptw.
 
                   "iface" clock is required to access the TCU's programming
                   interface, apart from the "tcu" clock.
@@ -161,3 +167,15 @@ conditions.
                 iommu-map = <0 &smmu3 0 0x400>;
                 ...
         };
+
+	/* Qcom's arm,smmu-v2 implementation for msm8996 */
+	smmu4: iommu {
+		compatible = "qcom,msm8996-smmu-v2";
+		...
+		#iommu-cells = <1>;
+		power-domains = <&mmcc MDSS_GDSC>;
+
+		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+			 <&mmcc SMMU_MDP_AHB_CLK>;
+		clock-names = "bus", "iface";
+	};
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7bb09280fa11..fe8e7fd61282 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -110,6 +110,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_MSM8996_SMMUV2,
 };
 
 /* Until ACPICA headers cover IORT rev. C */
@@ -1960,6 +1961,17 @@ struct arm_smmu_match_data {
 	.num_clks = ARRAY_SIZE(arm_mmu500_clks),
 };
 
+static const char * const qcom_msm8996_smmuv2_clks[] = {
+	"bus", "iface",
+};
+
+static const struct arm_smmu_match_data qcom_msm8996_smmuv2 = {
+	.version = ARM_SMMU_V2,
+	.model = QCOM_MSM8996_SMMUV2,
+	.clks = qcom_msm8996_smmuv2_clks,
+	.num_clks = ARRAY_SIZE(qcom_msm8996_smmuv2_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
@@ -1967,6 +1979,7 @@ struct arm_smmu_match_data {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,msm8996-smmu-v2", .data = &qcom_msm8996_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
