From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add "nvidia,memory-client"
Date: Fri, 5 Jul 2013 13:44:40 +0300
Message-ID: <1373021097-32420-6-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add "nvidia,memory-client" to identify which swgroup ID a device
belongs to.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 4a9594e..4aa5b4a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -23,6 +23,7 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
+		nvidia,memory-client = <TEGRA_SWGROUP_HC>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -34,6 +35,7 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
+			nvidia,memory-client = <TEGRA_SWGROUP_MPE>;
 		};
 
 		vi {
@@ -41,6 +43,7 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
+			nvidia,memory-client = <TEGRA_SWGROUP_VI>;
 		};
 
 		epp {
@@ -48,6 +51,7 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
+			nvidia,memory-client = <TEGRA_SWGROUP_EPP>;
 		};
 
 		isp {
@@ -55,6 +59,7 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
+			nvidia,memory-client = <TEGRA_SWGROUP_ISP>;
 		};
 
 		gr2d {
@@ -62,6 +67,7 @@
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
+			nvidia,memory-client = <TEGRA_SWGROUP_G2>;
 		};
 
 		gr3d {
@@ -69,6 +75,8 @@
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car 24 &tegra_car 98>;
 			clock-names = "3d", "3d2";
+			nvidia,memory-client = <TEGRA_SWGROUP_NV
+						TEGRA_SWGROUP_NV2>;
 		};
 
 		dc@54200000 {
@@ -78,6 +86,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			nvidia,memory-client = <TEGRA_SWGROUP_DC>;
 
 			rgb {
 				status = "disabled";
@@ -91,6 +100,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			nvidia,memory-client = <TEGRA_SWGROUP_DCB>;
 
 			rgb {
 				status = "disabled";
@@ -247,6 +257,7 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -257,6 +268,7 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -267,6 +279,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -277,6 +290,7 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -287,6 +301,7 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -536,6 +551,7 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -544,6 +560,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -552,6 +569,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
@@ -560,6 +578,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
+		nvidia,memory-client = <TEGRA_SWGROUP_PPCS>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
