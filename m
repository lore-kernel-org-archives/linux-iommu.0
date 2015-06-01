From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6/6] ARM: dts: exynos5420: add sysmmu nodes
Date: Mon, 01 Jun 2015 12:10:50 +0200
Message-ID: <1433153450-3680-7-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds System MMU nodes to all defined devices that are specific
to Exynos5420/5800/5422 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 183 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d0be412dfbea..534f27ceb10b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -179,6 +179,8 @@
 		clocks = <&clock CLK_MFC>;
 		clock-names = "mfc";
 		power-domains = <&mfc_pd>;
+		iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+		iommu-names = "left", "right";
 	};
 
 	mmc_0: mmc@12200000 {
@@ -713,6 +715,7 @@
 			 <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "hdmi", "sclk_hdmi";
 		power-domains = <&disp_pd>;
+		iommus = <&sysmmu_tv>;
 	};
 
 	gsc_0: video-scaler@13e00000 {
@@ -722,6 +725,7 @@
 		clocks = <&clock CLK_GSCL0>;
 		clock-names = "gscl";
 		power-domains = <&gsc_pd>;
+		iommus = <&sysmmu_gscl0>;
 	};
 
 	gsc_1: video-scaler@13e10000 {
@@ -731,6 +735,7 @@
 		clocks = <&clock CLK_GSCL1>;
 		clock-names = "gscl";
 		power-domains = <&gsc_pd>;
+		iommus = <&sysmmu_gscl1>;
 	};
 
 	jpeg_0: jpeg@11F50000 {
@@ -739,6 +744,7 @@
 		interrupts = <0 89 0>;
 		clock-names = "jpeg";
 		clocks = <&clock CLK_JPEG>;
+		iommus = <&sysmmu_jpeg0>;
 	};
 
 	jpeg_1: jpeg@11F60000 {
@@ -747,6 +753,7 @@
 		interrupts = <0 168 0>;
 		clock-names = "jpeg";
 		clocks = <&clock CLK_JPEG2>;
+		iommus = <&sysmmu_jpeg1>;
 	};
 
 	pmu_system_controller: system-controller@10040000 {
@@ -941,6 +948,180 @@
 		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
+
+	sysmmu_g2dr: sysmmu@0x10A60000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_g2dw: sysmmu@0x10A70000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x10A70000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_tv: sysmmu@0x14650000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x14650000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MIXER>, <&clock CLK_MIXER>;
+		power-domains = <&disp_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_gscl0: sysmmu@0x13E80000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
+		power-domains = <&gsc_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_gscl1: sysmmu@0x13E90000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13E90000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
+		power-domains = <&gsc_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler0r: sysmmu@0x12880000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12880000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL0>, <&clock CLK_MSCL0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler1r: sysmmu@0x12890000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12890000 0x1000>;
+		interrupts = <0 186 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL1>, <&clock CLK_MSCL1>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler2r: sysmmu@0x128A0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x128A0000 0x1000>;
+		interrupts = <0 188 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL2>, <&clock CLK_MSCL2>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler0w: sysmmu@0x128C0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x128C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <27 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL0>, <&clock CLK_MSCL0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler1w: sysmmu@0x128D0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x128D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL1>, <&clock CLK_MSCL1>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_scaler2w: sysmmu@0x128E0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x128E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <19 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MSCL2>, <&clock CLK_MSCL2>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg0: sysmmu@0x11F10000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11F10000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg1: sysmmu@0x11F20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11F20000 0x1000>;
+		interrupts = <0 169 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG2>, <&clock CLK_JPEG2>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_l: sysmmu@0x11200000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		power-domains = <&mfc_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_r: sysmmu@0x11210000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		power-domains = <&mfc_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd1_0: sysmmu@0x14640000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x14640000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD1M0>, <&clock CLK_FIMD1>;
+		power-domains = <&disp_pd>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd1_1: sysmmu@0x14680000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x14680000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD1M0>, <&clock CLK_FIMD1>;
+		power-domains = <&disp_pd>;
+		#iommu-cells = <0>;
+	};
 };
 
 &dp {
@@ -955,6 +1136,8 @@
 	clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 	clock-names = "sclk_fimd", "fimd";
 	power-domains = <&disp_pd>;
+	iommus = <&sysmmu_fimd1_0>, <&sysmmu_fimd1_1>;
+	iommu-names = "m0", "m1";
 };
 
 &rtc {
-- 
1.9.2
