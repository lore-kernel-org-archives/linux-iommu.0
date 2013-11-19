From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv5 9/9] [FOR TEST] ARM: dt: tegra30: add "iommus" binding
Date: Tue, 19 Nov 2013 11:33:13 +0200
Message-ID: <1384853593-32202-10-git-send-email-hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384853593-32202-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

"iommus" binding implies that a device can be attached to IOMMU
devices. An iommu device needs to set #iommus-cells in it. "iommus"
can have multiple iommu device phandles as below if needed.

  iommus = <&smmu arg1 arg2>,
  	   <&gart arg1 arg2>;

Not yet ready for merge. Need to add iommus for other devices.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v5:
Use "iommus=" instead of "mmu-masters".
---
 arch/arm/boot/dts/tegra30.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 2bd55cf..03b7887 100644
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
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(HC)>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +105,7 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(MPE)>;
 		};
 
 		vi {
@@ -110,6 +113,7 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(VI)>;
 		};
 
 		epp {
@@ -117,6 +121,7 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(EPP)>;
 		};
 
 		isp {
@@ -124,6 +129,7 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(ISP)>;
 		};
 
 		gr2d {
@@ -131,6 +137,7 @@
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(G2)>;
 		};
 
 		gr3d {
@@ -139,6 +146,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_GR3D
 				  &tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(NV)
+						TEGRA_SWGROUP_CELLS(NV2)>;
 		};
 
 		dc@54200000 {
@@ -148,6 +157,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(DC)>;
 
 			rgb {
 				status = "disabled";
@@ -161,6 +171,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			iommus = <&smmu TEGRA_SWGROUP_CELLS(DCB)>;
 
 			rgb {
 				status = "disabled";
@@ -317,6 +328,7 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -327,6 +339,7 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -337,6 +350,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -347,6 +361,7 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -357,6 +372,7 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -525,7 +541,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
+	smmu: iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
@@ -533,6 +549,7 @@
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
 		nvidia,ahb = <&ahb>;
+		#iommu-cells = <2>;
 	};
 
 	ahub {
@@ -605,6 +622,7 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -613,6 +631,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -621,6 +640,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
@@ -629,6 +649,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
+		iommus = <&smmu TEGRA_SWGROUP_CELLS(PPCS)>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5
