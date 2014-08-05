From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 15/29] ARM: DTS: Exynos4: add System MMU nodes
Date: Tue, 05 Aug 2014 12:47:43 +0200
Message-ID: <1407235677-26324-16-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds System MMU nodes that are specific to Exynos4210/4x12 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 118 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  23 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |  82 ++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3385b17..a76b4e5 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -174,6 +174,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			samsung,power-domain = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc0>;
 			status = "disabled";
 		};
 
@@ -185,6 +186,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			samsung,power-domain = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc1>;
 			status = "disabled";
 		};
 
@@ -196,6 +198,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			samsung,power-domain = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc2>;
 			status = "disabled";
 		};
 
@@ -207,6 +210,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			samsung,power-domain = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc3>;
 			status = "disabled";
 		};
 
@@ -395,6 +399,9 @@
 		clocks = <&clock CLK_MFC>;
 		clock-names = "mfc";
 		status = "disabled";
+		iommus = <&sysmmu_mfc_l 0x20000000 0x10000000>,
+			 <&sysmmu_mfc_r 0x30000000 0x10000000>;
+		iommu-names = "left", "right";
 	};
 
 	serial_0: serial@13800000 {
@@ -642,6 +649,117 @@
 		clocks = <&clock CLK_SCLK_FIMD0>, <&clock CLK_FIMD0>;
 		clock-names = "sclk_fimd", "fimd";
 		samsung,power-domain = <&pd_lcd0>;
+		iommus = <&sysmmu_fimd0>;
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
+		samsung,power-domain = <&pd_mfc>;
+		#iommu-cells = <2>;
+	};
+
+	sysmmu_mfc_r: sysmmu@13630000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13630000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		samsung,power-domain = <&pd_mfc>;
+		#iommu-cells = <2>;
+	};
+
+	sysmmu_tv: sysmmu@12E20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_TV>, <&clock CLK_MIXER>;
+		samsung,power-domain = <&pd_tv>;
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
+		samsung,power-domain = <&pd_cam>;
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
+		samsung,power-domain = <&pd_cam>;
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
+		samsung,power-domain = <&pd_cam>;
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
+		samsung,power-domain = <&pd_cam>;
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
+		samsung,power-domain = <&pd_cam>;
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
+		samsung,power-domain = <&pd_lcd0>;
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
+		samsung,power-domain = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 807bb5b..9ae48c2 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -142,6 +142,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -175,4 +176,26 @@
 			samsung,lcd-wb;
 		};
 	};
+
+	sysmmu_g2d: sysmmu@12A20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		samsung,power-domain = <&pd_lcd0>;
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
+		samsung,power-domain = <&pd_lcd1>;
+		#iommu-cells = <0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 861bb91..cc97e18 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -148,6 +148,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -197,6 +198,7 @@
 			samsung,power-domain = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite0>;
 			status = "disabled";
 		};
 
@@ -207,6 +209,7 @@
 			samsung,power-domain = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE1>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite1>;
 			status = "disabled";
 		};
 
@@ -235,6 +238,9 @@
 				      "mcuispdiv1", "uart", "aclk200",
 				      "div_aclk200", "aclk400mcuisp",
 				      "div_aclk400mcuisp";
+			iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+				 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+			iommu-names = "isp", "drc", "fd", "mcuctl";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -271,4 +277,80 @@
 		compatible = "samsung,exynos4x12-usb2-phy";
 		samsung,sysreg-phandle = <&sys_reg>;
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
+		samsung,power-domain = <&pd_isp>;
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
+		samsung,power-domain = <&pd_isp>;
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
+		samsung,power-domain = <&pd_isp>;
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
+		samsung,power-domain = <&pd_isp>;
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
+		samsung,power-domain = <&pd_isp>;
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
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_LITE1>, <&clock CLK_FIMC_LITE1>;
+		#iommu-cells = <0>;
+	};
 };
-- 
1.9.2
