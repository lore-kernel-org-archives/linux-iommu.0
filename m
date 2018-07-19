From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
Date: Thu, 19 Jul 2018 23:23:55 +0530
Message-ID: <20180719175356.14753-3-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com, andy.gross@linaro.org
Cc: mark.rutland@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tfiga@chromium.org, sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org, david.brown@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Add device node for qcom,smmu-v2 available on sdm845.
This smmu is available only to GPU device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

One power domain required for this GPU smmu - GPU_CX_GDSC,
commented out in the node is coming from gpu clock controller [1].

[1] https://lore.kernel.org/patchwork/cover/962208/

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 13b50dff440f..969aa76bdceb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -62,3 +62,7 @@
 &apps_smmu {
 	status = "okay";
 };
+
+&gpu_smmu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 70ca18ae6cb3..db9f9e84d162 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -980,6 +980,29 @@
 			cell-index = <0>;
 		};
 
+		gpu_smmu: arm,smmu@5040000 {
+			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			reg = <0x5040000 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "bus", "iface";
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_CFG_AHB_CLK>;
+
+			/* power-domains = <&gpucc GPU_CX_GDSC>; */
+			status = "disabled";
+		};
+
 		apps_smmu: arm,smmu@15000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x15000000 0x80000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
