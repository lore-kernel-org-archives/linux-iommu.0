From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 05/18] ARM: dts: exynos5420: add sysmmu nodes
Date: Fri, 23 Jan 2015 16:51:15 +0100
Message-ID: <1422028288-891-6-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 181 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1b62410..b8f1c9f 100644
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
@@ -556,6 +558,8 @@
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 		power-domains = <&disp_pd>;
+		iommus = <&sysmmu_fimd1_0>, <&sysmmu_fimd1_1>;
+		iommu-names = "m0", "m1";
 	};
 
 	adc: adc@12D10000 {
@@ -743,6 +747,7 @@
 		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 			 <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "hdmi", "sclk_hdmi";
+		iommus = <&sysmmu_tv>;
 		power-domains = <&disp_pd>;
 	};
 
@@ -753,6 +758,7 @@
 		clocks = <&clock CLK_GSCL0>;
 		clock-names = "gscl";
 		power-domains = <&gsc_pd>;
+		iommus = <&sysmmu_gscl0>;
 	};
 
 	gsc_1: video-scaler@13e10000 {
@@ -762,6 +768,7 @@
 		clocks = <&clock CLK_GSCL1>;
 		clock-names = "gscl";
 		power-domains = <&gsc_pd>;
+		iommus = <&sysmmu_gscl1>;
 	};
 
 	pmu_system_controller: system-controller@10040000 {
@@ -925,4 +932,178 @@
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
+		samsung,power-domain = <&disp_pd>;
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
+	sysmmu_jpeg: sysmmu@0x11F10000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11F10000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg2: sysmmu@0x11F20000 {
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
+		samsung,power-domain = <&disp_pd>;
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
+		samsung,power-domain = <&disp_pd>;
+		#iommu-cells = <0>;
+	};
 };
-- 
1.9.2
