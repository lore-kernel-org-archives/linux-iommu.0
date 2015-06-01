From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/6] ARM: dts: exynos4: add sysmmu nodes
Date: Mon, 01 Jun 2015 12:10:46 +0200
Message-ID: <1433153450-3680-3-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds System MMU nodes that are specific to Exynos4210/4x12 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 118 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  23 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |  82 ++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3ae22ee32cab..f716e2b7d0b9 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -189,6 +189,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc0>;
 			status = "disabled";
 		};
 
@@ -200,6 +201,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc1>;
 			status = "disabled";
 		};
 
@@ -211,6 +213,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc2>;
 			status = "disabled";
 		};
 
@@ -222,6 +225,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc3>;
 			status = "disabled";
 		};
 
@@ -416,6 +420,8 @@
 		power-domains = <&pd_mfc>;
 		clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
 		clock-names = "mfc", "sclk_mfc";
+		iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+		iommu-names = "left", "right";
 		status = "disabled";
 	};
 
@@ -680,6 +686,7 @@
 		clocks = <&clock CLK_SCLK_FIMD0>, <&clock CLK_FIMD0>;
 		clock-names = "sclk_fimd", "fimd";
 		power-domains = <&pd_lcd0>;
+		iommus = <&sysmmu_fimd0>;
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
 	};
@@ -717,6 +724,7 @@
 		interrupts = <0 91 0>;
 		reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
 		power-domains = <&pd_tv>;
+		iommus = <&sysmmu_tv>;
 		status = "disabled";
 	};
 
@@ -827,4 +835,114 @@
 		clock-names = "ppmu";
 		status = "disabled";
 	};
+
+	sysmmu_mfc_l: sysmmu@13620000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13620000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		power-domains = <&pd_mfc>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_r: sysmmu@13630000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13630000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		power-domains = <&pd_mfc>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_tv: sysmmu@12E20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_TV>, <&clock CLK_MIXER>;
+		power-domains = <&pd_tv>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc0: sysmmu@11A20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC0>, <&clock CLK_FIMC0>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc1: sysmmu@11A30000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 3>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC1>, <&clock CLK_FIMC1>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc2: sysmmu@11A40000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC2>, <&clock CLK_FIMC2>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc3: sysmmu@11A50000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC3>, <&clock CLK_FIMC3>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg: sysmmu@11A60000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_rotator: sysmmu@12A30000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_ROTATOR>, <&clock CLK_ROTATOR>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd0: sysmmu@11E20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD0>, <&clock CLK_FIMD0>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index a9a55304e31a..10d3c173396e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -173,6 +173,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -222,6 +223,28 @@
 		clock-names = "ppmu";
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu@12A20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd1: sysmmu@12220000 {
+		compatible = "samsung,exynos-sysmmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x12220000 0x1000>;
+		interrupts = <5 3>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD1>, <&clock CLK_FIMD1>;
+		power-domains = <&pd_lcd1>;
+		#iommu-cells = <0>;
+	};
 };
 
 &gic {
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 802116eed11b..b77dac61ffb5 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -115,6 +115,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -131,6 +132,7 @@
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite0>;
 			status = "disabled";
 		};
 
@@ -141,6 +143,7 @@
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE1>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite1>;
 			status = "disabled";
 		};
 
@@ -169,6 +172,9 @@
 				      "mcuispdiv1", "uart", "aclk200",
 				      "div_aclk200", "aclk400mcuisp",
 				      "div_aclk400mcuisp";
+			iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+				 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+			iommu-names = "isp", "drc", "fd", "mcuctl";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -200,6 +206,82 @@
 		clock-names = "biu", "ciu";
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu@10A40000{
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_isp: sysmmu@12260000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 2>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISP>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_drc: sysmmu@12270000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 3>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_DRC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_fd: sysmmu@122A0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x122A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 4>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FD>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu@122B0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x122B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 5>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISPCX>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu@123B0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x123B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 0>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_LITE0>, <&clock CLK_FIMC_LITE0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu@123C0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x123C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 1>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_LITE1>, <&clock CLK_FIMC_LITE1>;
+		#iommu-cells = <0>;
+	};
 };
 
 &combiner {
-- 
1.9.2
