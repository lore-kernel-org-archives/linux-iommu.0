From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 8/9] ARM64: DT: add video codec devicetree node
Date: Tue, 14 Mar 2017 11:18:10 -0400
Message-ID: <20170314151811.17234-9-robdclark@gmail.com>
References: <20170314151811.17234-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170314151811.17234-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b0daf39..7bcf4cd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -88,6 +88,13 @@
 			no-map;
 		};
 
+		venus_mem: venus@89900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x89900000 0x0 0x800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
 		mba_mem: mba@8ea00000 {
 			no-map;
 			reg = <0 0x8ea00000 0 0x100000>;
@@ -1190,6 +1197,27 @@
 				};
 			};
 		};
+
+		venus: video-codec@1d00000 {
+			compatible = "qcom,msm8916-venus";
+			reg = <0x01d00000 0xff000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&gcc VENUS_GDSC>;
+			clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
+				 <&gcc GCC_VENUS0_AHB_CLK>,
+				 <&gcc GCC_VENUS0_AXI_CLK>;
+			clock-names = "core", "iface", "bus";
+			memory-region = <&venus_mem>;
+			status = "okay";
+
+			video-decoder {
+				compatible = "venus-decoder";
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+			};
+		};
 	};
 
 	smd {
-- 
2.9.3
