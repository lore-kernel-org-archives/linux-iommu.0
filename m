From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/1] iommu/arm-smmu: Add support for qcom,smmu-500 variant
Date: Wed,  7 Mar 2018 12:02:19 +0530
Message-ID: <20180307063219.14409-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Qualcomm's arm-smmu 500 implementation supports runtime pm
so enable the same.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

 Based on iommu/arm-smmu pm runtime support series [1]:
 [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
 
 Tested on sdm845 with necessary support to enable the smmu
 and with necessary user.

 [1] https://lkml.org/lkml/2018/3/2/325

 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 14 ++++++++++++++
 drivers/iommu/arm-smmu.c                             |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 6ea27bd4f785..0b5c6d2a9865 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -18,6 +18,7 @@ conditions.
                         "arm,mmu-500"
                         "cavium,smmu-v2"
                         "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
+                        "qcom,<soc>-smmu-500", "qcom,smmu-500"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -30,6 +31,10 @@ conditions.
                   An example string would be -
                   "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
 
+                  "qcom,smmu-500" is arm,mmu-500 implementation that supports
+                  efficient power management by supporting smmu's state
+                  retention.
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -179,3 +184,12 @@ conditions.
 			 <&mmcc SMMU_MDP_AHB_CLK>;
 		clock-names = "bus", "iface";
 	};
+
+	smmu5: iommu {
+		compatible = "qcom,sdm845-smmu-500", "qcom,smmu-500";
+		reg = <0x15000000 0x80000>;
+		#iommu-cells = <2>;
+		#global-interrupts = <1>;
+
+		...
+	};
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7a96c924ae22..7f52456c6b25 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2008,6 +2008,12 @@ static const char * const qcom_smmuv2_clks[] = {
 	"bus", "iface",
 };
 
+static const struct arm_smmu_match_data qcom_smmu500 = {
+	.version = ARM_SMMU_V2,
+	.model = ARM_MMU500,
+	.rpm_supported = true,
+};
+
 static const struct arm_smmu_match_data qcom_smmuv2 = {
 	.version = ARM_SMMU_V2,
 	.model = QCOM_SMMUV2,
@@ -2024,6 +2030,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu500 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
@@ -2394,6 +2401,7 @@ IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
 IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
 IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
 IOMMU_OF_DECLARE(qcom_smmuv2, "qcom,smmu-v2");
+IOMMU_OF_DECLARE(qcom_smmu500, "qcom,smmu-500");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
