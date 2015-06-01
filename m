From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/6] ARM: dts: exynos3250: add sysmmu nodes
Date: Mon, 01 Jun 2015 12:10:47 +0200
Message-ID: <1433153450-3680-4-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds System MMU nodes to the devices that are specific to
Exynos3250 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 4728c77ed6e4..d7201333e3bc 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -253,9 +253,20 @@
 			assigned-clocks = <&cmu CLK_MOUT_CAM_BLK>, <&cmu CLK_SCLK_JPEG>;
 			assigned-clock-rates = <0>, <150000000>;
 			assigned-clock-parents = <&cmu CLK_DIV_MPLL_PRE>;
+			iommus = <&sysmmu_jpeg>;
 			status = "disabled";
 		};
 
+		sysmmu_jpeg: sysmmu@11A60000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x11a60000 0x1000>;
+			interrupts = <0 156 0>, <0 161 0>;
+			clock-names = "sysmmu", "master";
+			clocks = <&cmu CLK_SMMUJPEG>, <&cmu CLK_JPEG>;
+			power-domains = <&pd_cam>;
+			#iommu-cells = <0>;
+		};
+
 		fimd: fimd@11c00000 {
 			compatible = "samsung,exynos3250-fimd";
 			reg = <0x11c00000 0x30000>;
@@ -264,6 +275,7 @@
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			power-domains = <&pd_lcd0>;
+			iommus = <&sysmmu_fimd0>;
 			samsung,sysreg = <&sys_reg>;
 			status = "disabled";
 		};
@@ -283,6 +295,16 @@
 			status = "disabled";
 		};
 
+		sysmmu_fimd0: sysmmu@11E20000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x11e20000 0x1000>;
+			interrupts = <0 80 0>, <0 81 0>;
+			clock-names = "sysmmu", "master";
+			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
+			power-domains = <&pd_lcd0>;
+			#iommu-cells = <0>;
+		};
+
 		hsotg: hsotg@12480000 {
 			compatible = "snps,dwc2";
 			reg = <0x12480000 0x20000>;
@@ -377,9 +399,20 @@
 			clock-names = "mfc", "sclk_mfc";
 			clocks = <&cmu CLK_MFC>, <&cmu CLK_SCLK_MFC>;
 			power-domains = <&pd_mfc>;
+			iommus = <&sysmmu_mfc>;
 			status = "disabled";
 		};
 
+		sysmmu_mfc: sysmmu@13620000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13620000 0x1000>;
+			interrupts = <0 96 0>, <0 98 0>;
+			clock-names = "sysmmu", "master";
+			clocks = <&cmu CLK_SMMUMFC_L>, <&cmu CLK_MFC>;
+			power-domains = <&pd_mfc>;
+			#iommu-cells = <0>;
+		};
+
 		serial_0: serial@13800000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13800000 0x100>;
-- 
1.9.2
