From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 12:28:06 +0300
Message-ID: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add "nvidia,memory-clients" to identify which swgroup ID a device
belongs to.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/iommu/nvidia,tegra30-smmu.txt | 11 +++++++++++
 arch/arm/boot/dts/tegra30.dtsi                        | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 6be51f6..2081e27 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -11,6 +11,7 @@ Required properties:
 - nvidia,swgroups: A bit map of supported HardWare Accelerators(HWA).
   Each bit represents one sgroup. The assignments may be found in header
   file <dt-bindings/iommu/tegra-swgid.h>.
+- nvidia,memory-clients: Indicates which swgroups a device belongs to.
 
 Example:
 	iommu {
@@ -23,3 +24,13 @@ Example:
 		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
+
+	host1x {
+		compatible = "nvidia,tegra30-host1x", "simple-bus";
+		nvidia,memory-clients = <SWGID_HC>;
+		....
+		gr3d {
+			compatible = "nvidia,tegra30-gr3d";
+			nvidia,memory-clients = <SWGID_NV SWGID_NV2>;
+			....
+		};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 14ec3f9..3fcee3f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra30-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/iommu/tegra-swgid.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -22,6 +23,7 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
+		nvidia,memory-clients = <SWGID_HC>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -33,6 +35,7 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
+			nvidia,memory-clients = <SWGID_MPE>;
 		};
 
 		vi {
@@ -40,6 +43,7 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
+			nvidia,memory-clients = <SWGID_VI>;
 		};
 
 		epp {
@@ -47,6 +51,7 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
+			nvidia,memory-clients = <SWGID_EPP>;
 		};
 
 		isp {
@@ -54,6 +59,7 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
+			nvidia,memory-clients = <SWGID_ISP>;
 		};
 
 		gr2d {
@@ -61,6 +67,7 @@
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
+			nvidia,memory-clients = <SWGID_G2>;
 		};
 
 		gr3d {
@@ -68,6 +75,7 @@
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car 24 &tegra_car 98>;
 			clock-names = "3d", "3d2";
+			nvidia,memory-clients = <SWGID_NV SWGID_NV2>;
 		};
 
 		dc@54200000 {
@@ -77,6 +85,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			nvidia,memory-clients = <SWGID_DC>;
 
 			rgb {
 				status = "disabled";
@@ -90,6 +99,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			nvidia,memory-clients = <SWGID_DCB>;
 
 			rgb {
 				status = "disabled";
@@ -246,6 +256,7 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -256,6 +267,7 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -266,6 +278,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -276,6 +289,7 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -286,6 +300,7 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
+		nvidia,memory-clients = <14>;
 		status = "disabled";
 	};
 
@@ -535,6 +550,7 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -543,6 +559,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -551,6 +568,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
@@ -559,6 +577,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5
