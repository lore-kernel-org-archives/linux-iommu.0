From: Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v12 30/31] ARM: dts: add System MMU nodes of exynos5250
Date: Sun, 27 Apr 2014 13:08:02 +0530
Message-ID: <1398584283-22846-31-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |  270 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..eebd397 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -82,6 +82,16 @@
 		reg = <0x10044040 0x20>;
 	};
 
+	pd_isp: isp-power-domain@0x10044020 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10044020 0x20>;
+	};
+
+	pd_disp1: disp1-power-domain@0x100440A0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440A0 0x20>;
+	};
+
 	clock: clock-controller@10010000 {
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
@@ -192,7 +202,7 @@
 		clock-names = "fimg2d";
 	};
 
-	codec@11000000 {
+	mfc: codec@11000000 {
 		compatible = "samsung,mfc-v6";
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
@@ -692,7 +702,7 @@
 				"sclk_hdmiphy", "mout_hdmi";
 	};
 
-	mixer {
+	mixer: mixer {
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
@@ -713,7 +723,7 @@
 		phy-names = "dp";
 	};
 
-	fimd@14400000 {
+	fimd: fimd@14400000 {
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
@@ -736,4 +746,258 @@
 		clocks = <&clock 348>;
 		clock-names = "secss";
 	};
+
+	sysmmu_g2d: sysmmu@10A60000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_2D>;
+	};
+
+	sysmmu_mfc_r: sysmmu@11200000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		mmu-masters = <&mfc>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_mfc_l: sysmmu@11210000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		mmu-masters = <&mfc>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_rotator: sysmmu@11D40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ROTATOR>;
+	};
+
+	sysmmu_fimc_isp: sysmmu@13260000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ISP>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_drc: sysmmu@13270000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DRC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scc: sysmmu@13280000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13280000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scp: sysmmu@13290000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13290000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCP>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_fd: sysmmu@132A0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_FD>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu@132B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_MCU>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_odc: sysmmu@132C0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ODC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis0: sysmmu@132D0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS0>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis1: sysmmu@132E0000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <9 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS1>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_3dnr: sysmmu@132F0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132F0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_3DNR>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu@13C40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE0>, <&clock CLK_CAMIF_TOP>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu@13C50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE1>, <&clock CLK_CAMIF_TOP>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_gsc0: sysmmu@13E80000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_0>;
+	};
+
+	sysmmu_gsc1: sysmmu@13E90000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13E90000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_1>;
+	};
+
+	sysmmu_gsc2: sysmmu@13EA0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13EA0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL2>, <&clock CLK_GSCL2>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_2>;
+	};
+
+	sysmmu_gsc3: sysmmu@13EB0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13EB0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL3>, <&clock CLK_GSCL3>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_3>;
+	};
+
+	sysmmu_fimd1: sysmmu@14640000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x14640000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMD1>;
+		samsung,power-domain = <&pd_disp1>;
+		mmu-masters = <&fimd>;
+	};
+
+	sysmmu_tv: sysmmu@14650000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x14650000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_TV>;
+		samsung,power-domain = <&pd_disp1>;
+		mmu-masters = <&mixer>;
+	};
+
+	sysmmu_jpeg: sysmmu@11F20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11F20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_mdma0: sysmmu@10A40000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MDMA0>, <&clock CLK_MDMA0>;
+	};
+
+	sysmmu_mdma1: sysmmu@11D50000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MDMA1>, <&clock CLK_MDMA1>;
+	};
 };
-- 
1.7.9.5
