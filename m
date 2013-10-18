From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 17/19] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
Date: Fri, 18 Oct 2013 13:26:58 +0300
Message-ID: <1382092020-13170-18-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add "nvidia,memory-clients" to identify which swgroup ID a device
belongs to.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index dfd3ca9..4173a2a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/clock/tegra30-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/memory/tegra-swgroup.h>
 
 #include "skeleton.dtsi"
 
@@ -92,6 +93,7 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +105,7 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_MPE>;
 		};
 
 		vi {
@@ -110,6 +113,7 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_VI>;
 		};
 
 		epp {
@@ -117,6 +121,7 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_EPP>;
 		};
 
 		isp {
@@ -124,6 +129,7 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_ISP>;
 		};
 
 		gr2d {
@@ -131,6 +137,7 @@
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_G2>;
 		};
 
 		gr3d {
@@ -138,6 +145,8 @@
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car 24 &tegra_car 98>;
 			clock-names = "3d", "3d2";
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
+						TEGRA_SWGROUP_NV2>;
 		};
 
 		dc@54200000 {
@@ -147,6 +156,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_DC>;
 
 			rgb {
 				status = "disabled";
@@ -160,6 +170,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_DCB>;
 
 			rgb {
 				status = "disabled";
@@ -316,6 +327,7 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -326,6 +338,7 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -336,6 +349,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -346,6 +360,7 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -356,6 +371,7 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -524,7 +540,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
+	smmu: iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
@@ -605,6 +621,7 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -613,6 +630,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -621,6 +639,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -629,6 +648,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
