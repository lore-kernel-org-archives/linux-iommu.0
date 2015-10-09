From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v5 6/6] dts: mt8173: Add iommu/smi nodes for mt8173
Date: Fri, 9 Oct 2015 10:23:08 +0800
Message-ID: <1444357388-30257-7-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, Sricharan R <sricharan@codeaurora.org>, youhua.li@mediatek.com, k.zhang@mediatek.com, kendrick.hsu@mediatek.com, Yong Wu <yong.wu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

This patch add the iommu/larbs nodes for mt8173

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 42540b2..524d305 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/memory/mt8173-larb-port.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
@@ -265,6 +266,17 @@
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8173-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_M4U>;
+			clock-names = "bclk";
+			mediatek,larb = <&larb0 &larb1 &larb2
+					 &larb3 &larb4 &larb5>;
+			#iommu-cells = <2>;
+		};
+
 		apmixedsys: clock-controller@10209000 {
 			compatible = "mediatek,mt8173-apmixedsys";
 			reg = <0 0x10209000 0 0x1000>;
@@ -514,29 +526,98 @@
 			#clock-cells = <1>;
 		};
 
+		larb0: larb@14021000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14021000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+		};
+
+		smi_common: smi@14022000 {
+			compatible = "mediatek,mt8173-smi";
+			reg = <0 0x14022000 0 0x1000>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+		};
+
+		larb4: larb@14027000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14027000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_SMI_LARB4>,
+				 <&mmsys CLK_MM_SMI_LARB4>;
+			clock-names = "apb", "smi";
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8173-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_ISP>;
+			clocks = <&imgsys CLK_IMG_LARB2_SMI>,
+				 <&imgsys CLK_IMG_LARB2_SMI>;
+			clock-names = "apb", "smi";
+		};
+
 		vdecsys: clock-controller@16000000 {
 			compatible = "mediatek,mt8173-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb1: larb@16010000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+			clocks = <&vdecsys CLK_VDEC_CKEN>,
+				 <&vdecsys CLK_VDEC_LARB_CKEN>;
+			clock-names = "apb", "smi";
+		};
+
 		vencsys: clock-controller@18000000 {
 			compatible = "mediatek,mt8173-vencsys", "syscon";
 			reg = <0 0x18000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb3: larb@18001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x18001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
+			clocks = <&vencsys CLK_VENC_CKE1>,
+				 <&vencsys CLK_VENC_CKE0>;
+			clock-names = "apb", "smi";
+		};
+
 		vencltsys: clock-controller@19000000 {
 			compatible = "mediatek,mt8173-vencltsys", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb5: larb@19001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x19001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
+			clocks = <&vencltsys CLK_VENCLT_CKE1>,
+				 <&vencltsys CLK_VENCLT_CKE0>;
+			clock-names = "apb", "smi";
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
