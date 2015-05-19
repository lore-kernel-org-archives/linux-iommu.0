From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 20/25] ARM: dts: exynos3250: add sysmmu nodes
Date: Tue, 19 May 2015 15:20:40 +0200
Message-ID: <1432041645-11172-21-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds System MMU nodes to the devices that are specific to
Exynos3250 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index e3bfb11c6ef8..36361e0cb802 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -251,6 +251,7 @@
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			power-domains = <&pd_lcd0>;
+			iommus = <&sysmmu_fimd0>;
 			samsung,sysreg = <&sys_reg>;
 			status = "disabled";
 		};
@@ -270,6 +271,16 @@
 			status = "disabled";
 		};
 
+		sysmmu_fimd0: sysmmu@11E20000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x11e20000 0x1000>;
+			interrupts = <0 80 0>, <0 81 0>;
+			clock-names = "sysmmu", "master";
+			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
+			samsung,power-domain = <&pd_lcd0>;
+			#iommu-cells = <0>;
+		};
+
 		hsotg: hsotg@12480000 {
 			compatible = "snps,dwc2";
 			reg = <0x12480000 0x20000>;
@@ -364,9 +375,20 @@
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
+			samsung,power-domain = <&pd_mfc>;
+			#iommu-cells = <0>;
+		};
+
 		serial_0: serial@13800000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13800000 0x100>;
-- 
1.9.2
