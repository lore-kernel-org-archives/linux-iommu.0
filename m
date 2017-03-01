From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 7/9] ARM64: DT: add gpu for msm8916
Date: Wed,  1 Mar 2017 12:42:56 -0500
Message-ID: <20170301174258.14618-8-robdclark@gmail.com>
References: <20170301174258.14618-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170301174258.14618-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 68a8e67..b0daf39 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -698,6 +698,29 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		gpu@01c00000 {
+			compatible = "qcom,adreno-306.0", "qcom,adreno";
+			reg = <0x01c00000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <0 33 0>;
+			interrupt-names = "kgsl_3d0_irq";
+			clock-names =
+			    "core",
+			    "iface",
+			    "mem",
+			    "mem_iface",
+			    "alt_mem_iface",
+			    "gfx3d_clk";
+			clocks =
+			    <&gcc GCC_OXILI_GFX3D_CLK>,
+			    <&gcc GCC_OXILI_AHB_CLK>,
+			    <&gcc GCC_OXILI_GMEM_CLK>,
+			    <&gcc GCC_BIMC_GFX_CLK>,
+			    <&gcc GCC_BIMC_GPU_CLK>,
+			    <&gcc GFX3D_CLK_SRC>;
+			power-domains = <&gcc OXILI_GDSC>;
+		};
+
 		mdss: mdss@1a00000 {
 			compatible = "qcom,mdss";
 			reg = <0x1a00000 0x1000>,
-- 
2.9.3
