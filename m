From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v11 12/27] ARM: dts: Add description of System MMU of Exynos
	SoCs
Date: Fri, 14 Mar 2014 14:06:49 +0900
Message-ID: <20140314140649.dc5958f420770af48e2376d9@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds dts entries for the System MMU devices found on
Exynos4 and Exynos5 SoC series and the System MMU binding
documentation.

CC: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../bindings/iommu/samsung,exynos4210-sysmmu.txt   |   86 +++++++
 arch/arm/boot/dts/exynos4.dtsi                     |  107 ++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |   23 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   77 +++++-
 arch/arm/boot/dts/exynos5250.dtsi                  |  266 +++++++++++++++++++-
 arch/arm/boot/dts/exynos5420.dtsi                  |  205 ++++++++++++++-
 6 files changed, 758 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt

diff --git a/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
new file mode 100644
index 0000000..e4417bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,exynos4210-sysmmu.txt
@@ -0,0 +1,86 @@
+Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
+
+Samsung's Exynos architecture contains System MMUs that enables scattered
+physical memory chunks visible as a contiguous region to DMA-capable peripheral
+devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
+
+System MMU is an IOMMU and supports identical translation table format to
+ARMv7 translation tables with minimum set of page properties including access
+permissions, shareability and security protection. In addition, System MMU has
+another capabilities like L2 TLB or block-fetch buffers to minimize translation
+latency.
+
+System MMUs are in many to one relation with peripheral devices, i.e. single
+peripheral device might have multiple System MMUs (usually one for each bus
+master), but one System MMU can handle transactions from only one peripheral
+device. The relation between a System MMU and the peripheral device needs to be
+defined in device node of the peripheral device.
+
+MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
+MMUs.
+* MFC has one System MMU on its left and right bus.
+* FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
+  for window 1, 2 and 3.
+* M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
+  the other System MMU on the write channel.
+The drivers must consider how to handle those System MMUs. One of the idea is
+to implement child devices or sub-devices which are the client devices of the
+System MMU.
+
+Required properties:
+- compatible: Should be one of:
+		"samsung,sysmmu-v1"
+		"samsung,sysmmu-v2"
+		"samsung,sysmmu-v3.1"
+		"samsung,sysmmu-v3.2"
+		"samsung,sysmmu-v3.3"
+
+- reg: A tuple of base address and size of System MMU registers.
+- interrupt-parent: The phandle of the interrupt controller of System MMU
+- interrupts: An interrupt specifier for interrupt signal of System MMU,
+	      according to the format defined by a particular interrupt
+	      controller.
+- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
+               Please refer to the following documents:
+	       Documentation/devicetree/bindings/clock/clock-bindings.txt
+	       Documentation/devicetree/bindings/clock/exynos4-clock.txt
+	       Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+	       Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+	       Optional "master" if the clock to the System MMU is gated by
+	       another gate clock other than "sysmmu". The System MMU driver
+	       sets "master" the parent of "sysmmu".
+	       Exynos4 SoCs, there needs no "master" clockj.
+	       Exynos5 SoCs, some System MMUs must have "master" clocks.
+- clocks: Required if the System MMU is needed to gate its clock.
+	  Please refer to the documents listed above.
+- samsung,power-domain: Required if the System MMU is needed to gate its power.
+	  Please refer to the following document:
+	  Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+- mmu-masters: A phandle to device nodes representing the master for which
+               the System MMU can provide a translation. Any additional values
+	       after the phandle will be ignored because a System MMU never
+	       have two or more masters. "#stream-id-cells" specified in the
+	       master's node will be also ignored.
+	       If more than one phandle is specified, only the first phandle
+	       will be treated.
+
+Examples:
+	gsc_0: gsc@13e00000 {
+		compatible = "samsung,exynos5-gsc";
+		reg = <0x13e00000 0x1000>;
+		interrupts = <0 85 0>;
+		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock 256>;
+		clock-names = "gscl";
+	};
+
+	sysmmu_gsc0: sysmmu@13E80000 {
+		compatible = "samsung,exynos4210-sysmmu";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 262>, <&clock 256>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_0>;
+	};
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 08452e1..2d5350d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -516,4 +516,111 @@
 		samsung,power-domain = <&pd_lcd0>;
 		status = "disabled";
 	};
+
+	sysmmu_mfc_l: sysmmu@13620000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x13620000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock 274>;
+		samsung,power-domain = <&pd_mfc>;
+		mmu-masters = <&mfc>;
+	};
+
+	sysmmu_mfc_r: sysmmu@13630000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x13630000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 275>;
+		samsung,power-domain = <&pd_mfc>;
+		mmu-masters = <&mfc>;
+	};
+
+	sysmmu_tv: sysmmu@12E20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock 272>;
+		samsung,power-domain = <&pd_tv>;
+	};
+
+	sysmmu_fimc0: sysmmu@11A20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock 263>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_0>;
+	};
+
+	sysmmu_fimc1: sysmmu@11A30000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 3>;
+		clock-names = "sysmmu";
+		clocks = <&clock 264>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_1>;
+	};
+
+	sysmmu_fimc2: sysmmu@11A40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock 265>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_2>;
+	};
+
+	sysmmu_fimc3: sysmmu@11A50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock 266>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_3>;
+	};
+
+	sysmmu_jpeg: sysmmu@11A60000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 267>;
+		samsung,power-domain = <&pd_cam>;
+	};
+
+	sysmmu_rotator: sysmmu@12A30000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock 281>;
+		samsung,power-domain = <&pd_lcd0>;
+	};
+
+	sysmmu_fimd0: sysmmu@11E20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock 287>;
+		samsung,power-domain = <&pd_lcd0>;
+		mmu-masters = <&fimd>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 48ecd7a..fac6dc6 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -114,7 +114,7 @@
 		status = "disabled";
 	};
 
-	g2d@12800000 {
+	g2d: g2d@12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
 		interrupts = <0 89 0>;
@@ -152,4 +152,25 @@
 			samsung,lcd-wb;
 		};
 	};
+
+	sysmmu_g2d: sysmmu@12A20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu";
+		clocks = <&clock 280>;
+		samsung,power-domain = <&pd_lcd0>;
+		mmu-masters = <&g2d>;
+	};
+
+	sysmmu_fimd1: sysmmu@12220000 {
+		compatible = "samsung,sysmmu-v1";
+		interrupt-parent = <&combiner>;
+		reg = <0x12220000 0x1000>;
+		interrupts = <5 3>;
+		clock-names = "sysmmu";
+		clocks = <&clock 291>;
+		samsung,power-domain = <&pd_lcd1>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 5c412aa..447745b 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -93,7 +93,7 @@
 		interrupts = <0 72 0>;
 	};
 
-	g2d@10800000 {
+	g2d: g2d@10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
 		interrupts = <0 89 0>;
@@ -209,4 +209,79 @@
 		clock-names = "biu", "ciu";
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu@10A40000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu";
+		mmu-masters = <&g2d>;
+	};
+
+	sysmmu_fimc_isp: sysmmu@12260000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 2>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 362>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_drc: sysmmu@12270000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 3>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 363>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_fd: sysmmu@122A0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x122A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 4>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 364>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu@122B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x122B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 5>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 376>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu@123B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x123B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 0>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 366>;
+		mmu-masters = <&fimc_lite_0>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu@123C0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x123C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 1>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock 365>;
+		mmu-masters = <&fimc_lite_1>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 8f6300f..df336ea 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -80,6 +80,16 @@
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
@@ -679,7 +689,7 @@
 				"sclk_hdmiphy", "mout_hdmi";
 	};
 
-	mixer {
+	mixer: mixer {
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
@@ -700,7 +710,7 @@
 		phy-names = "dp";
 	};
 
-	fimd@14400000 {
+	fimd: fimd@14400000 {
 		clocks = <&clock 133>, <&clock 339>;
 		clock-names = "sclk_fimd", "fimd";
 	};
@@ -715,4 +725,256 @@
 		io-channel-ranges;
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu@10A60000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock 361>;
+	};
+
+	sysmmu_mfc_r: sysmmu@11200000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 268>, <&clock 266>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_mfc_l: sysmmu@11210000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 267>, <&clock 266>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_rotator: sysmmu@11D40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock 272>;
+	};
+
+	sysmmu_fimc_isp: sysmmu@13260000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 361>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_drc: sysmmu@13270000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 362>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scc: sysmmu@13280000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13280000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock 364>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scp: sysmmu@13290000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13290000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 365>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_fd: sysmmu@132A0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock 363>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu@132B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock 366>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_odc: sysmmu@132C0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock 367>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis0: sysmmu@132D0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock 368>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis1: sysmmu@132E0000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <9 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock 369>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_3dnr: sysmmu@132F0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132F0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock 370>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu@13C40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 346>, <&clock 345>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu@13C50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 347>, <&clock 345>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_gsc0: sysmmu@13E80000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 262>, <&clock 256>;
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
+		clocks = <&clock 263>, <&clock 257>;
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
+		clocks = <&clock 264>, <&clock 258>;
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
+		clocks = <&clock 265>, <&clock 259>;
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
+		clocks = <&clock 350>;
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
+		clocks = <&clock 349>;
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
+		clocks = <&clock 273>, <&clock 270>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_mdma0: sysmmu@10A40000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 373>, <&clock 372>;
+	};
+
+	sysmmu_mdma1: sysmmu@11D50000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 274>, <&clock 271>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 45e2e65..a736f09 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -470,7 +470,7 @@
 		phy-names = "dp";
 	};
 
-	fimd@14400000 {
+	fimd: fimd@14400000 {
 		samsung,power-domain = <&disp_pd>;
 		clocks = <&clock 147>, <&clock 421>;
 		clock-names = "sclk_fimd", "fimd";
@@ -641,7 +641,7 @@
 		status = "disabled";
 	};
 
-	mixer@14450000 {
+	mixer: mixer@14450000 {
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
@@ -720,4 +720,205 @@
 		clock-names = "watchdog";
 		samsung,syscon-phandle = <&pmu_system_controller>;
         };
+
+	sysmmu_g2dr: sysmmu@10A60000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 482>, <&clock 481>;
+	};
+
+	sysmmu_g2dw: sysmmu@10A70000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 482>, <&clock 481>;
+	};
+
+	sysmmu_scaler0r: sysmmu@12880000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x12880000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 384>, <&clock 381>;
+	};
+
+	sysmmu_scaler1r: sysmmu@12890000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x12890000 0x1000>;
+		interrupts = <0 186 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 385>, <&clock 382>;
+	};
+
+	sysmmu_scaler2r: sysmmu@128A0000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x128A0000 0x1000>;
+		interrupts = <0 188 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 386>, <&clock 383>;
+	};
+
+	sysmmu_scaler0w: sysmmu@128C0000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x128C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <27 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 384>, <&clock 381>;
+	};
+
+	sysmmu_scaler1w: sysmmu@128D0000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x128D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <22 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 385>, <&clock 382>;
+	};
+
+	sysmmu_scaler2w: sysmmu@128E0000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x128E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <19 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 386>, <&clock 383>;
+	};
+
+	sysmmu_mfc_r: sysmmu@11200000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 402>, <&clock 401>;
+		samsung,power-domain = <&mfc_pd>;
+	};
+
+	sysmmu_mfc_l: sysmmu@11210000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 403>, <&clock 401>;
+		samsung,power-domain = <&mfc_pd>;
+	};
+
+	sysmmu_rotator: sysmmu@11D40000 {
+		compatible = "samsung,sysmmu-v3.1";
+		reg = <0x11D40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 443>, <&clock 441>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu@13C40000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x13C40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 492>, <&clock 496>;
+		samsung,power-domain = <&gsc_pd>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu@13C50000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x13C50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 493>, <&clock 497>;
+		samsung,power-domain = <&gsc_pd>;
+	};
+
+	sysmmu_fimc_lite3: sysmmu@13D50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13D50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 494>, <&clock 495>;
+		samsung,power-domain = <&gsc_pd>;
+	};
+
+	sysmmu_gsc0: sysmmu@13E80000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 461>, <&clock 465>;
+		samsung,power-domain = <&gsc_pd>;
+		mmu-masters = <&gsc_0>;
+	};
+
+	sysmmu_gsc1: sysmmu@13E90000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x13E90000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 462>, <&clock 466>;
+		samsung,power-domain = <&gsc_pd>;
+		mmu-masters = <&gsc_1>;
+	};
+
+	sysmmu_fimd0w04: sysmmu@14640000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x14640000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 422>, <&clock 421>;
+		samsung,power-domain = <&disp_pd>;
+		mmu-masters = <&fimd>;
+	};
+
+	sysmmu_fimd0w123: sysmmu@14680000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x14680000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 423>, <&clock 421>;
+		samsung,power-domain = <&disp_pd>;
+		mmu-masters = <&fimd>;
+	};
+
+	sysmmu_tv: sysmmu@14650000 {
+		compatible = "samsung,sysmmu-v3.3";
+		reg = <0x14650000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 502>, <&clock 431>;
+		samsung,power-domain = <&disp_pd>;
+		mmu-masters = <&mixer>;
+	};
+
+	sysmmu_jpeg: sysmmu@11F10000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11F10000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 453>, <&clock 451>;
+	};
+
+	sysmmu_jpeg2: sysmmu@11F20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11F20000 0x1000>;
+		interrupts = <0 169 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock 453>, <&clock 452>;
+	};
 };
-- 
1.7.9.5
