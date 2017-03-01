From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 9/9] ARM64: DT: add iommu for msm8916
Date: Wed,  1 Mar 2017 12:42:58 -0500
Message-ID: <20170301174258.14618-10-robdclark@gmail.com>
References: <20170301174258.14618-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170301174258.14618-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7bcf4cd..10ca05a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -705,6 +705,59 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		apps_iommu: msm-iommu-v1@1e20000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			compatible = "qcom,msm-iommu-v1";
+			ranges = <0 0x1e20000 0x40000>;
+			reg = <0x1ef0000 0x3000>;
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_APSS_TCU_CLK>;
+			clock-names = "iface_clk", "bus_clk";
+			qcom,iommu-secure-id = <17>;
+
+			// mdp_0:
+			msm-iommu-v1-ctx@4000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x4000 0x1000>;
+				interrupts = <GIC_SPI 70 0>;
+			};
+
+			// venus_ns:
+			msm-iommu-v1-ctx@5000 {
+				compatible = "qcom,msm-iommu-v1-sec";
+				reg = <0x5000 0x1000>;
+				interrupts = <GIC_SPI 70 0>;
+			};
+		};
+
+		gpu_iommu: msm-iommu-v1@1f08000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+			compatible = "qcom,msm-iommu-v1";
+			ranges = <0 0x1f08000 0x10000>;
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_GFX_TCU_CLK>;
+			clock-names = "iface_clk", "bus_clk";
+			qcom,iommu-secure-id = <18>;
+
+			// gfx3d_user:
+			msm-iommu-v1-ctx@1f09000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x1000 0x1000>;
+				interrupts = <GIC_SPI 241 0>;
+			};
+
+			// gfx3d_priv:
+			msm-iommu-v1-ctx@1f0a000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x2000 0x1000>;
+				interrupts = <GIC_SPI 242 0>;
+			};
+		};
+
 		gpu@01c00000 {
 			compatible = "qcom,adreno-306.0", "qcom,adreno";
 			reg = <0x01c00000 0x20000>;
@@ -726,6 +779,7 @@
 			    <&gcc GCC_BIMC_GPU_CLK>,
 			    <&gcc GFX3D_CLK_SRC>;
 			power-domains = <&gcc OXILI_GDSC>;
+			iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
 		};
 
 		mdss: mdss@1a00000 {
@@ -769,6 +823,8 @@
 					      "core_clk",
 					      "vsync_clk";
 
+				iommus = <&apps_iommu 4>;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1207,6 +1263,7 @@
 				 <&gcc GCC_VENUS0_AHB_CLK>,
 				 <&gcc GCC_VENUS0_AXI_CLK>;
 			clock-names = "core", "iface", "bus";
+			iommus = <&apps_iommu 5>;
 			memory-region = <&venus_mem>;
 			status = "okay";
 
-- 
2.9.3
