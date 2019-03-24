From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] arm64: dts: Add m4u and smi-larbs nodes for mt8183
Date: Sun, 24 Mar 2019 15:41:15 +0800
Message-ID: <1553413275-10724-1-git-send-email-yong.wu@mediatek.com>
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
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, weiyi.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, anan.sun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add nodes for M4U, smi-common, and smi-larbs.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
This one is based on MTK IOMMU v6[1] and basical nodes of clocks and powers.

[1] https://patchwork.kernel.org/patch/10816827/
[2] https://patchwork.kernel.org/patch/10858941/
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 75c4881..1138da2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8183-larb-port.h>
 #include <dt-bindings/power/mt8183-power.h>
 
 / {
@@ -269,6 +270,15 @@
 			clock-names = "spi", "wrap";
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8183-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3
+					  &larb4 &larb5 &larb6>;
+			#iommu-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8183-uart",
 				     "mediatek,mt6577-uart";
@@ -317,9 +327,25 @@
 			#clock-cells = <1>;
 		};
 
+		larb0: larb@14017000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x14017000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_SMI_LARB0>;
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+			clock-names = "apb", "smi";
+		};
+
 		smi_common: smi@14019000 {
 			compatible = "mediatek,mt8183-smi-common", "syscon";
 			reg = <0 0x14019000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_GALS_COMM0>,
+				 <&mmsys CLK_MM_GALS_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
 		};
 
 		imgsys: syscon@15020000 {
@@ -328,18 +354,57 @@
 			#clock-cells = <1>;
 		};
 
+		larb5: larb@15021000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x15021000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB5>, <&imgsys CLK_IMG_LARB5>,
+				 <&mmsys CLK_MM_GALS_IMG2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_ISP>;
+		};
+
+		larb2: larb@1502f000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1502f000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB2>, <&imgsys CLK_IMG_LARB2>,
+				 <&mmsys CLK_MM_GALS_IPU2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_ISP>;
+		};
+
 		vdecsys: syscon@16000000 {
 			compatible = "mediatek,mt8183-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb1: larb@16010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_VDEC>, <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VDEC>;
+		};
+
 		vencsys: syscon@17000000 {
 			compatible = "mediatek,mt8183-vencsys", "syscon";
 			reg = <0 0x17000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb4: larb@17010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC_LARB>,
+				 <&vencsys CLK_VENC_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VENC>;
+		};
+
 		ipu_conn: syscon@19000000 {
 			compatible = "mediatek,mt8183-ipu_conn", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
@@ -369,5 +434,25 @@
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb6: larb@1a001000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB6>, <&camsys CLK_CAM_LARB6>,
+				 <&mmsys CLK_MM_GALS_CAM2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+		};
+
+		larb3: larb@1a002000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB3>, <&camsys CLK_CAM_LARB3>,
+				 <&mmsys CLK_MM_GALS_IPU12MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+		};
 	};
 };
-- 
1.9.1
