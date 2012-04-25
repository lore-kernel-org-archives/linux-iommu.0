From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Wed, 25 Apr 2012 11:45:02 +0200
Message-ID: <1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1335347102-14905-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
currently has rudimentary GEM support and can run a console on the
framebuffer as well as X using the xf86-video-modesetting driver. Only
the RGB output is supported.

HDMI support was taken from NVIDIA's Linux kernel tree but it doesn't
quite work. EDID data can be retrieved but the output doesn't properly
activate the connected TV.

The DSI and TVO outputs and the HOST1X driver are just stubs that setup
the corresponding resources but don't do anything useful yet.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 .../devicetree/bindings/gpu/drm/tegra.txt          |  125 +++
 arch/arm/mach-tegra/board-dt-tegra20.c             |   14 +
 arch/arm/mach-tegra/include/mach/iomap.h           |    6 +
 arch/arm/mach-tegra/tegra2_clocks.c                |   19 +-
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/tegra/Kconfig                      |   19 +
 drivers/gpu/drm/tegra/Makefile                     |    7 +
 drivers/gpu/drm/tegra/tegra-dc.c                   |  630 +++++++++++++
 drivers/gpu/drm/tegra/tegra-dc.h                   |  245 +++++
 drivers/gpu/drm/tegra/tegra-drv.c                  |  600 ++++++++++++
 drivers/gpu/drm/tegra/tegra-drv.h                  |  201 ++++
 drivers/gpu/drm/tegra/tegra-dsi.c                  |  145 +++
 drivers/gpu/drm/tegra/tegra-encon.c                |  406 ++++++++
 drivers/gpu/drm/tegra/tegra-fb.c                   |  355 +++++++
 drivers/gpu/drm/tegra/tegra-gem.c                  |  425 +++++++++
 drivers/gpu/drm/tegra/tegra-hdmi.c                 |  994 ++++++++++++++++++++
 drivers/gpu/drm/tegra/tegra-hdmi.h                 |  462 +++++++++
 drivers/gpu/drm/tegra/tegra-host1x.c               |   90 ++
 drivers/gpu/drm/tegra/tegra-rgb.c                  |  148 +++
 drivers/gpu/drm/tegra/tegra-tvo.c                  |  152 +++
 include/drm/tegra_drm.h                            |   40 +
 22 files changed, 5075 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/drm/tegra.txt
 create mode 100644 drivers/gpu/drm/tegra/Kconfig
 create mode 100644 drivers/gpu/drm/tegra/Makefile
 create mode 100644 drivers/gpu/drm/tegra/tegra-dc.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-dc.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-drv.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-drv.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-dsi.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-encon.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-fb.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-gem.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-hdmi.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-hdmi.h
 create mode 100644 drivers/gpu/drm/tegra/tegra-host1x.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-rgb.c
 create mode 100644 drivers/gpu/drm/tegra/tegra-tvo.c
 create mode 100644 include/drm/tegra_drm.h

diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
new file mode 100644
index 0000000..6c23155
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
@@ -0,0 +1,125 @@
+Example:
+
+/memreserve/ 0x0e000000 0x02000000;
+
+...
+
+/ {
+	...
+
+	/* host1x */
+	host1x: host1x@50000000 {
+		compatible = "nvidia,tegra20-host1x";
+		reg = <0x50000000 0x00024000>;
+		interrupts = <0 64 0x04   /* cop syncpt */
+			      0 65 0x04   /* mpcore syncpt */
+			      0 66 0x04   /* cop general */
+			      0 67 0x04>; /* mpcore general */
+	};
+
+	/* video-encoding/decoding */
+	mpe@54040000 {
+		reg = <0x54040000 0x00040000>;
+		interrupts = <0 68 0x04>;
+	};
+
+	/* video input */
+	vi@54080000 {
+		reg = <0x54080000 0x00040000>;
+		interrupts = <0 69 0x04>;
+	};
+
+	/* EPP */
+	epp@540c0000 {
+		reg = <0x540c0000 0x00040000>;
+		interrupts = <0 70 0x04>;
+	};
+
+	/* ISP */
+	isp@54100000 {
+		reg = <0x54100000 0x00040000>;
+		interrupts = <0 71 0x04>;
+	};
+
+	/* 2D engine */
+	gr2d@54140000 {
+		reg = <0x54140000 0x00040000>;
+		interrupts = <0 72 0x04>;
+	};
+
+	/* 3D engine */
+	gr3d@54180000 {
+		reg = <0x54180000 0x00040000>;
+	};
+
+	/* display controllers */
+	disp1: dc@54200000 {
+		compatible = "nvidia,tegra20-dc";
+		reg = <0x54200000 0x00040000>;
+		interrupts = <0 73 0x04>;
+	};
+
+	disp2: dc@54240000 {
+		compatible = "nvidia,tegra20-dc";
+		reg = <0x54240000 0x00040000>;
+		interrupts = <0 74 0x04>;
+	};
+
+	/* outputs */
+	lvds: rgb {
+		compatible = "nvidia,tegra20-rgb";
+	};
+
+	hdmi: hdmi@54280000 {
+		compatible = "nvidia,tegra20-hdmi";
+		reg = <0x54280000 0x00040000>;
+		interrupts = <0 75 0x04>;
+
+		vdd-supply = <&ldo7_reg>;
+		pll-supply = <&ldo8_reg>;
+	};
+
+	tvo: tvo@542c0000 {
+		compatible = "nvidia,tegra20-tvo";
+		reg = <0x542c0000 0x00040000>;
+		interrupts = <0 76 0x04>;
+	};
+
+	dsi: dsi@54300000 {
+		compatible = "nvidia,tegra20-dsi";
+		reg = <0x54300000 0x00040000>;
+	};
+
+	/* graphics host */
+	graphics@54000000 {
+		compatible = "nvidia,tegra20-graphics";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		display-controllers = <&disp1 &disp2>;
+		carveout = <0x0e000000 0x02000000>;
+		host1x = <&host1x>;
+		gart = <&gart>;
+
+		connectors {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			connector@0 {
+				reg = <0>;
+				edid = /incbin/("machine.edid");
+				output = <&lvds>;
+			};
+
+			connector@1 {
+				reg = <1>;
+				output = <&hdmi>;
+				ddc = <&i2c2>;
+
+				hpd-gpio = <&gpio 111 0>; /* PN7 */
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index fac3eb1..c4d0f74 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -64,6 +64,12 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 		       &tegra_ehci2_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB3_BASE, "tegra-ehci.2",
 		       &tegra_ehci3_pdata),
+	OF_DEV_AUXDATA("nvidia,tegra20-host1x", TEGRA_HOST1X_BASE, "tegra-host1x", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-dc", TEGRA_DISPLAY_BASE, "tegra-dc.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-dc", TEGRA_DISPLAY2_BASE, "tegra-dc.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-hdmi", TEGRA_HDMI_BASE, "tegra-hdmi", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-dsi", TEGRA_DSI_BASE, "tegra-dsi", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-tvo", TEGRA_TVO_BASE, "tegra-tvo", NULL),
 	{}
 };
 
@@ -78,6 +84,14 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ "cdev1",      NULL,           0,              true },
 	{ "i2s1",       "pll_a_out0",   11289600,       false},
 	{ "i2s2",       "pll_a_out0",   11289600,       false},
+	{ "host1x",     "pll_c",        144000000,      true },
+	{ "disp1",      "pll_p",        600000000,      true },
+	{ "disp2",      "pll_p",        600000000,      true },
+	{ "pll_d",      "clk_m",        1000000,        false },
+	{ "pll_d_out0", "pll_d",        500000,         false },
+	{ "hdmi",       "pll_d_out0",   12000000,       false },
+	{ "dsi",        "pll_d",        1000000,        false },
+	{ "tvo",        "clk_m",        12000000,       false },
 	{ NULL,		NULL,		0,		0},
 };
 
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 7e76da7..3e80f3f 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -56,6 +56,12 @@
 #define TEGRA_HDMI_BASE			0x54280000
 #define TEGRA_HDMI_SIZE			SZ_256K
 
+#define TEGRA_TVO_BASE			0x542c0000
+#define TEGRA_TVO_SIZE			SZ_256K
+
+#define TEGRA_DSI_BASE			0x54300000
+#define TEGRA_DSI_SIZE			SZ_256K
+
 #define TEGRA_GART_BASE			0x58000000
 #define TEGRA_GART_SIZE			SZ_32M
 
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 0bf0f2d..947c94d 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -2194,17 +2194,17 @@ static struct clk tegra_list_clks[] = {
 	PERIPH_CLK("vi_sensor",	"tegra_camera",		"vi_sensor",	20,	0x1a8,	150000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71 | PERIPH_NO_RESET), /* scales with voltage and process_id */
 	PERIPH_CLK("epp",	"epp",			NULL,	19,	0x16c,	300000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
 	PERIPH_CLK("mpe",	"mpe",			NULL,	60,	0x170,	250000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
-	PERIPH_CLK("host1x",	"host1x",		NULL,	28,	0x180,	166000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
+	PERIPH_CLK("host1x",	"tegra-host1x",		NULL,	28,	0x180,	166000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
 	PERIPH_CLK("cve",	"cve",			NULL,	49,	0x140,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
-	PERIPH_CLK("tvo",	"tvo",			NULL,	49,	0x188,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
-	PERIPH_CLK("hdmi",	"hdmi",			NULL,	51,	0x18c,	600000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
+	PERIPH_CLK("tvo",	"tegra-tvo",		NULL,	49,	0x188,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
+	PERIPH_CLK("hdmi",	"tegra-hdmi",		NULL,	51,	0x18c,	600000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
 	PERIPH_CLK("tvdac",	"tvdac",		NULL,	53,	0x194,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
-	PERIPH_CLK("disp1",	"tegradc.0",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
-	PERIPH_CLK("disp2",	"tegradc.1",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
+	PERIPH_CLK("disp1",	"tegra-dc.0",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
+	PERIPH_CLK("disp2",	"tegra-dc.1",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
 	PERIPH_CLK("usbd",	"fsl-tegra-udc",	NULL,	22,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
 	PERIPH_CLK("usb2",	"tegra-ehci.1",		NULL,	58,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
 	PERIPH_CLK("usb3",	"tegra-ehci.2",		NULL,	59,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
-	PERIPH_CLK("dsi",	"dsi",			NULL,	48,	0,	500000000, mux_plld,			0), /* scales with voltage */
+	PERIPH_CLK("dsi",	"tegra-dsi",		NULL,	48,	0,	500000000, mux_plld,			0), /* scales with voltage */
 	PERIPH_CLK("csi",	"tegra_camera",		"csi",	52,	0,	72000000,  mux_pllp_out3,		0),
 	PERIPH_CLK("isp",	"tegra_camera",		"isp",	23,	0,	150000000, mux_clk_m,			0), /* same frequency as VI */
 	PERIPH_CLK("csus",	"tegra_camera",		"csus",	92,	0,	150000000, mux_clk_m,			PERIPH_NO_RESET),
@@ -2215,8 +2215,8 @@ static struct clk tegra_list_clks[] = {
 	SHARED_CLK("avp.sclk",	"tegra-avp",		"sclk",	&tegra_clk_sclk),
 	SHARED_CLK("avp.emc",	"tegra-avp",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("cpu.emc",	"cpu",			"emc",	&tegra_clk_emc),
-	SHARED_CLK("disp1.emc",	"tegradc.0",		"emc",	&tegra_clk_emc),
-	SHARED_CLK("disp2.emc",	"tegradc.1",		"emc",	&tegra_clk_emc),
+	SHARED_CLK("disp1.emc",	"tegra-dc.0",		"emc",	&tegra_clk_emc),
+	SHARED_CLK("disp2.emc",	"tegra-dc.1",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("hdmi.emc",	"hdmi",			"emc",	&tegra_clk_emc),
 	SHARED_CLK("host.emc",	"tegra_grhost",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("usbd.emc",	"fsl-tegra-udc",	"emc",	&tegra_clk_emc),
@@ -2247,13 +2247,10 @@ static struct clk_duplicate tegra_clk_duplicates[] = {
 	CLK_DUPLICATE("usbd", "utmip-pad", NULL),
 	CLK_DUPLICATE("usbd", "tegra-ehci.0", NULL),
 	CLK_DUPLICATE("usbd", "tegra-otg", NULL),
-	CLK_DUPLICATE("hdmi", "tegradc.0", "hdmi"),
-	CLK_DUPLICATE("hdmi", "tegradc.1", "hdmi"),
 	CLK_DUPLICATE("pwm", "tegra_pwm.0", NULL),
 	CLK_DUPLICATE("pwm", "tegra_pwm.1", NULL),
 	CLK_DUPLICATE("pwm", "tegra_pwm.2", NULL),
 	CLK_DUPLICATE("pwm", "tegra_pwm.3", NULL),
-	CLK_DUPLICATE("host1x", "tegra_grhost", "host1x"),
 	CLK_DUPLICATE("2d", "tegra_grhost", "gr2d"),
 	CLK_DUPLICATE("3d", "tegra_grhost", "gr3d"),
 	CLK_DUPLICATE("epp", "tegra_grhost", "epp"),
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e354bc0..dd543f9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -186,3 +186,5 @@ source "drivers/gpu/drm/vmwgfx/Kconfig"
 source "drivers/gpu/drm/gma500/Kconfig"
 
 source "drivers/gpu/drm/udl/Kconfig"
+
+source "drivers/gpu/drm/tegra/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c20da5b..d417d7e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -42,4 +42,5 @@ obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
+obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-y			+= i2c/
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
new file mode 100644
index 0000000..c11309b
--- /dev/null
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -0,0 +1,19 @@
+config DRM_TEGRA
+	tristate "NVIDIA Tegra DRM"
+	depends on DRM && ARCH_TEGRA
+	select DRM_KMS_ENCON
+	select DRM_KMS_HELPER
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Choose this option if you have an NVIDIA Tegra SoC.
+
+if DRM_TEGRA
+
+config DRM_TEGRA_DEBUG
+	bool "NVIDIA Tegra DRM debug support"
+	help
+	  Say yes here to enable debugging support.
+
+endif
diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makefile
new file mode 100644
index 0000000..5cd2361
--- /dev/null
+++ b/drivers/gpu/drm/tegra/Makefile
@@ -0,0 +1,7 @@
+ccflags-y := -Iinclude/drm
+ccflags-$(CONFIG_DRM_TEGRA_DEBUG) += -DDEBUG
+
+tegra-drm-y := tegra-drv.o tegra-gem.o tegra-fb.o tegra-encon.o
+tegra-drm-y += tegra-rgb.o tegra-hdmi.o tegra-tvo.o tegra-dsi.o
+tegra-drm-y += tegra-dc.o tegra-host1x.o
+obj-$(CONFIG_DRM_TEGRA) += tegra-drm.o
diff --git a/drivers/gpu/drm/tegra/tegra-dc.c b/drivers/gpu/drm/tegra/tegra-dc.c
new file mode 100644
index 0000000..723efdd
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-dc.c
@@ -0,0 +1,630 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <mach/clk.h>
+
+#include "tegra-drv.h"
+#include "tegra-dc.h"
+
+static unsigned long pclk_best_div(unsigned long pclk, unsigned long rate)
+{
+	unsigned long div = DIV_ROUND_CLOSEST(rate * 2, pclk);
+	static const unsigned long max_pclk_khz = ULONG_MAX;
+
+	if (!div)
+		return 0;
+
+	while (rate * 2 / div > max_pclk_khz * 1000)
+		div++;
+
+	if (div < 2)
+		div = 2;
+
+	if (div > 257)
+		div = 257;
+
+	return div;
+}
+
+static unsigned long pclk_round_rate(struct clk *clk, unsigned long pclk,
+				     unsigned long *div)
+{
+	long rate = clk_round_rate(clk, pclk);
+
+	if (rate < 0)
+		rate = clk_get_rate(clk);
+
+	*div = pclk_best_div(pclk, rate);
+
+	return rate;
+}
+
+static void tegra_crtc_save(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_restore(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
+				 uint32_t start, uint32_t size)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, r=%p, g=%p, b=%p, start=%u, size=%u)\n",
+		__func__, crtc, r, g, b, start, size);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_destroy(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static int tegra_crtc_page_flip(struct drm_crtc *crtc,
+				struct drm_framebuffer *fb,
+				struct drm_pending_vblank_event *event)
+{
+	int ret = 0;
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, fb=%p, event=%p)\n", __func__,
+		crtc, fb, event);
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static const struct drm_crtc_funcs tegra_crtc_funcs = {
+	.save = tegra_crtc_save,
+	.restore = tegra_crtc_restore,
+	.gamma_set = tegra_crtc_gamma_set,
+	.set_config = drm_crtc_helper_set_config,
+	.destroy = tegra_crtc_destroy,
+	.page_flip = tegra_crtc_page_flip,
+};
+
+static void tegra_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%d)\n", __func__, crtc,
+		mode);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static bool tegra_crtc_mode_fixup(struct drm_crtc *crtc,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted)
+{
+	bool ret = true;
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%p, adjusted=%p)\n",
+		__func__, crtc, mode, adjusted);
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+struct crtc_win {
+	fixed20_12 x;
+	fixed20_12 y;
+	fixed20_12 w;
+	fixed20_12 h;
+	unsigned int outx;
+	unsigned int outy;
+	unsigned int outw;
+	unsigned int outh;
+	unsigned int stride;
+	unsigned int fmt;
+};
+
+static inline u32 compute_dda_inc(fixed20_12 inf, unsigned int out, bool v,
+				  unsigned int bpp)
+{
+	fixed20_12 outf = dfixed_init(out);
+	u32 dda_inc;
+	int max;
+
+	if (v)
+		max = 15;
+	else {
+		switch (bpp) {
+		case 2:
+			max = 8;
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			/* fallthrough */
+		case 4:
+			max = 4;
+			break;
+		}
+	}
+
+	outf.full = max_t(u32, outf.full - dfixed_const(1), dfixed_const(1));
+	inf.full -= dfixed_const(1);
+
+	dda_inc = dfixed_div(inf, outf);
+	dda_inc = min_t(u32, dda_inc, dfixed_const(max));
+
+	return dda_inc;
+}
+
+static inline u32 compute_initial_dda(fixed20_12 in)
+{
+	return dfixed_frac(in);
+}
+
+static int tegra_crtc_set_timings(struct tegra_crtc *crtc,
+				  struct drm_display_mode *mode)
+{
+	unsigned int h_ref_to_sync = 0;
+	unsigned int v_ref_to_sync = 0;
+	unsigned long value;
+
+	tegra_crtc_writel(crtc, 0x0, DC_DISP_DISP_TIMING_OPTIONS);
+
+	value = (v_ref_to_sync << 16) | h_ref_to_sync;
+	tegra_crtc_writel(crtc, value, DC_DISP_REF_TO_SYNC);
+
+	value = ((mode->vsync_end - mode->vsync_start) << 16) |
+		((mode->hsync_end - mode->hsync_start) <<  0);
+	tegra_crtc_writel(crtc, value, DC_DISP_SYNC_WIDTH);
+
+	value = ((mode->vsync_start - mode->vdisplay) << 16) |
+		((mode->hsync_start - mode->hdisplay) <<  0);
+	tegra_crtc_writel(crtc, value, DC_DISP_BACK_PORCH);
+
+	value = ((mode->vtotal - mode->vsync_end) << 16) |
+		((mode->htotal - mode->hsync_end) <<  0);
+	tegra_crtc_writel(crtc, value, DC_DISP_FRONT_PORCH);
+
+	value = (mode->vdisplay << 16) | mode->hdisplay;
+	tegra_crtc_writel(crtc, value, DC_DISP_ACTIVE);
+
+	return 0;
+}
+
+static int tegra_crtc_mode_set(struct drm_crtc *crtc,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted,
+			       int x, int y, struct drm_framebuffer *old_fb)
+{
+	struct tegra_crtc *priv = to_tegra_crtc(crtc);
+	unsigned long pclk = mode->clock * 1000;
+	struct tegra_framebuffer *fb;
+	unsigned long rate, div;
+	struct crtc_win win;
+	unsigned long value;
+	unsigned int h_dda;
+	unsigned int v_dda;
+	unsigned int bpp;
+	int ret = 0;
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%p, adjusted=%p, x=%d, y=%d, old_fb=%p)\n",
+		__func__, crtc, mode, adjusted, x, y, old_fb);
+
+	fb = to_tegra_fb(crtc->fb);
+
+	rate = pclk_round_rate(priv->clk, pclk, &div);
+	dev_dbg(crtc->dev->dev, "  rate:%lu div:%lu\n", rate, div);
+	clk_set_rate(priv->clk, rate);
+
+	pclk = div ? (rate * 2 / div) : 0;
+	dev_dbg(crtc->dev->dev, "  pclk:%lu\n", pclk);
+
+	/* program display mode */
+	tegra_crtc_set_timings(priv, mode);
+
+	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
+	tegra_crtc_writel(priv, value, DC_DISP_DATA_ENABLE_OPTIONS);
+
+	value = tegra_crtc_readl(priv, DC_COM_PIN_OUTPUT_POLARITY(1));
+	value &= ~LVS_OUTPUT_POLARITY_LOW;
+	value &= ~LHS_OUTPUT_POLARITY_LOW;
+	tegra_crtc_writel(priv, value, DC_COM_PIN_OUTPUT_POLARITY(1));
+
+	value = DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
+		DISP_ORDER_RED_BLUE;
+	tegra_crtc_writel(priv, value, DC_DISP_DISP_INTERFACE_CONTROL);
+
+	tegra_crtc_writel(priv, 0x00010001, DC_DISP_SHIFT_CLOCK_OPTIONS);
+
+	value = SHIFT_CLK_DIVIDER(div - 2) | PIXEL_CLK_DIVIDER_PCD1;
+	tegra_crtc_writel(priv, value, DC_DISP_DISP_CLOCK_CONTROL);
+
+	/* setup window parameters */
+	memset(&win, 0, sizeof(win));
+	win.x.full = dfixed_const(0);
+	win.y.full = dfixed_const(0);
+	win.w.full = dfixed_const(mode->hdisplay);
+	win.h.full = dfixed_const(mode->vdisplay);
+	win.outx = 0;
+	win.outy = 0;
+	win.outw = mode->hdisplay;
+	win.outh = mode->vdisplay;
+
+	switch (crtc->fb->pixel_format) {
+	case DRM_FORMAT_XRGB8888:
+		win.fmt = WIN_COLOR_DEPTH_R8G8B8A8;
+		break;
+
+	case DRM_FORMAT_RGB565:
+		win.fmt = WIN_COLOR_DEPTH_B5G6R5;
+		break;
+
+	default:
+		win.fmt = WIN_COLOR_DEPTH_R8G8B8A8;
+		WARN_ON(1);
+		break;
+	}
+
+	bpp = crtc->fb->bits_per_pixel / 8;
+	win.stride = win.outw * bpp;
+
+	/* program window registers */
+	value = tegra_crtc_readl(priv, DC_CMD_DISPLAY_WINDOW_HEADER);
+	value |= WINDOW_A_SELECT;
+	tegra_crtc_writel(priv, value, DC_CMD_DISPLAY_WINDOW_HEADER);
+
+	tegra_crtc_writel(priv, win.fmt, DC_WIN_COLOR_DEPTH);
+	tegra_crtc_writel(priv, 0, DC_WIN_BYTE_SWAP);
+
+	value = V_POSITION(win.outy) | H_POSITION(win.outx);
+	tegra_crtc_writel(priv, value, DC_WIN_POSITION);
+
+	value = V_SIZE(win.outh) | H_SIZE(win.outw);
+	tegra_crtc_writel(priv, value, DC_WIN_SIZE);
+
+	value = V_PRESCALED_SIZE(dfixed_trunc(win.h)) |
+		H_PRESCALED_SIZE(dfixed_trunc(win.w) * bpp);
+	tegra_crtc_writel(priv, value, DC_WIN_PRESCALED_SIZE);
+
+	h_dda = compute_dda_inc(win.w, win.outw, false, bpp);
+	v_dda = compute_dda_inc(win.h, win.outh, true, bpp);
+
+	value = V_DDA_INC(v_dda) | H_DDA_INC(h_dda);
+	tegra_crtc_writel(priv, value, DC_WIN_DDA_INC);
+
+	h_dda = compute_initial_dda(win.x);
+	v_dda = compute_initial_dda(win.y);
+
+	tegra_crtc_writel(priv, h_dda, DC_WIN_H_INITIAL_DDA);
+	tegra_crtc_writel(priv, v_dda, DC_WIN_V_INITIAL_DDA);
+
+	tegra_crtc_writel(priv, 0, DC_WIN_UV_BUF_STRIDE);
+	tegra_crtc_writel(priv, 0, DC_WIN_BUF_STRIDE);
+
+	dev_dbg(crtc->dev->dev, "%s(): displaying GEM %p @%x\n", __func__,
+		fb->obj, fb->obj->phys.start);
+
+	tegra_crtc_writel(priv, fb->obj->phys.start, DC_WINBUF_START_ADDR);
+	tegra_crtc_writel(priv, win.stride, DC_WIN_LINE_STRIDE);
+	tegra_crtc_writel(priv, dfixed_trunc(win.x) * bpp,
+			  DC_WINBUF_ADDR_H_OFFSET);
+	tegra_crtc_writel(priv, dfixed_trunc(win.y), DC_WINBUF_ADDR_V_OFFSET);
+
+	value = WIN_ENABLE;
+
+	if (bpp < 24)
+		value |= COLOR_EXPAND;
+
+	tegra_crtc_writel(priv, value, DC_WIN_WIN_OPTIONS);
+
+	tegra_crtc_writel(priv, 0xff00, DC_WIN_BLEND_NOKEY);
+	tegra_crtc_writel(priv, 0xff00, DC_WIN_BLEND_1WIN);
+
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_crtc_prepare(struct drm_crtc *crtc)
+{
+	struct tegra_crtc *priv = to_tegra_crtc(crtc);
+	unsigned int syncpt;
+	unsigned long value;
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+
+	/* hardware initialization */
+	clk_prepare_enable(priv->clk);
+	clk_prepare_enable(priv->clk_emc);
+	tegra_periph_reset_deassert(priv->clk);
+	priv->enabled = true;
+	usleep_range(10000, 10000);
+
+	if (priv->pipe)
+		syncpt = SYNCPT_VBLANK1;
+	else
+		syncpt = SYNCPT_VBLANK0;
+
+	/* initialize display controller */
+	tegra_crtc_writel(priv, 0x00000100, DC_CMD_GENERAL_INCR_SYNCPT_CNTRL);
+	tegra_crtc_writel(priv, 0x100 | syncpt, DC_CMD_CONT_SYNCPT_VSYNC);
+
+	value = WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT | WIN_A_OF_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_TYPE);
+
+	value = WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT |
+		WIN_A_OF_INT | WIN_B_OF_INT | WIN_C_OF_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_POLARITY);
+
+	value = PW0_ENABLE | PW1_ENABLE | PW2_ENABLE | PW3_ENABLE |
+		PW4_ENABLE | PM0_ENABLE | PM1_ENABLE;
+	tegra_crtc_writel(priv, value, DC_CMD_DISPLAY_POWER_CONTROL);
+
+	value = tegra_crtc_readl(priv, DC_CMD_DISPLAY_COMMAND);
+	value |= DISP_CTRL_MODE_C_DISPLAY;
+	tegra_crtc_writel(priv, value, DC_CMD_DISPLAY_COMMAND);
+
+	/* initialize timer */
+	value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x20) |
+		WINDOW_B_THRESHOLD(0x20) | WINDOW_C_THRESHOLD(0x20);
+	tegra_crtc_writel(priv, value, DC_DISP_DISP_MEM_HIGH_PRIORITY);
+
+	value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(1) |
+		WINDOW_B_THRESHOLD(1) | WINDOW_C_THRESHOLD(1);
+	tegra_crtc_writel(priv, value, DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER);
+
+	value = VBLANK_INT | WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_MASK);
+
+	value = VBLANK_INT | WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_ENABLE);
+
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_commit(struct drm_crtc *crtc)
+{
+	struct tegra_crtc *priv = to_tegra_crtc(crtc);
+	unsigned long update_mask;
+	unsigned long value;
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+
+	update_mask = GENERAL_ACT_REQ | WIN_A_ACT_REQ;
+
+	tegra_crtc_writel(priv, update_mask << 8, DC_CMD_STATE_CONTROL);
+
+	value = tegra_crtc_readl(priv, DC_CMD_INT_ENABLE);
+	value |= FRAME_END_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_ENABLE);
+
+	value = tegra_crtc_readl(priv, DC_CMD_INT_MASK);
+	value |= FRAME_END_INT;
+	tegra_crtc_writel(priv, value, DC_CMD_INT_MASK);
+
+	tegra_crtc_writel(priv, update_mask, DC_CMD_STATE_CONTROL);
+
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_load_lut(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_disable(struct drm_crtc *crtc)
+{
+	struct tegra_crtc *priv = to_tegra_crtc(crtc);
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+
+	if (priv->enabled) {
+		tegra_periph_reset_assert(priv->clk);
+		clk_disable_unprepare(priv->clk_emc);
+		clk_disable_unprepare(priv->clk);
+	}
+
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static const struct drm_crtc_helper_funcs tegra_crtc_helper_funcs = {
+	.dpms = tegra_crtc_dpms,
+	.mode_fixup = tegra_crtc_mode_fixup,
+	.mode_set = tegra_crtc_mode_set,
+	.prepare = tegra_crtc_prepare,
+	.commit = tegra_crtc_commit,
+	.load_lut = tegra_crtc_load_lut,
+	.disable = tegra_crtc_disable,
+};
+
+static int tegra_crtc_init(struct tegra_crtc *crtc)
+{
+	int err = 0;
+	dev_dbg(crtc->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev, "< %s() = %d\n", __func__, err);
+	return err;
+};
+
+static int tegra_crtc_exit(struct tegra_crtc *crtc)
+{
+	int err = 0;
+	dev_dbg(crtc->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static irqreturn_t tegra_drm_irq(int irq, void *data)
+{
+	struct tegra_crtc *crtc = data;
+	unsigned long underflow;
+	unsigned long status;
+
+	/*
+	dev_dbg(crtc->dev, "> %s(irq=%d, data=%p)\n", __func__, irq, data);
+	*/
+
+	status = tegra_crtc_readl(crtc, DC_CMD_INT_STATUS);
+	tegra_crtc_writel(crtc, status, DC_CMD_INT_STATUS);
+
+	/*
+	dev_dbg(crtc->dev, "  status: %#lx\n", status);
+	*/
+
+	if (status & FRAME_END_INT) {
+		/*
+		dev_dbg(crtc->dev, "%s(): frame end\n", __func__);
+		*/
+	}
+
+	if (status & VBLANK_INT) {
+		/*
+		dev_dbg(crtc->dev, "%s(): V-blank\n", __func__);
+		*/
+		drm_handle_vblank(crtc->base.dev, crtc->pipe);
+	}
+
+	underflow = WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT;
+
+	if (status & underflow) {
+		/*
+		dev_dbg(crtc->dev, "%s(): underflow\n", __func__);
+		*/
+	}
+
+	/*
+	dev_dbg(crtc->dev, "< %s()\n", __func__);
+	*/
+	return IRQ_HANDLED;
+}
+
+static int __devinit tegra_dc_probe(struct platform_device *pdev)
+{
+	struct tegra_crtc *crtc;
+	struct resource *regs;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	crtc = devm_kzalloc(&pdev->dev, sizeof(*crtc), GFP_KERNEL);
+	if (!crtc) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	crtc->dev = &pdev->dev;
+	crtc->pipe = pdev->id;
+
+	crtc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(crtc->clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	crtc->clk_emc = clk_get(&pdev->dev, "emc");
+	if (IS_ERR_OR_NULL(crtc->clk_emc)) {
+		dev_err(&pdev->dev, "failed to get EMC clock\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "failed to get registers\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	crtc->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!crtc->regs) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	crtc->irq = platform_get_irq(pdev, 0);
+	if (crtc->irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
+		err = -ENXIO;
+		goto out;
+	}
+
+	err = devm_request_irq(&pdev->dev, crtc->irq, tegra_drm_irq, 0,
+			       dev_name(&pdev->dev), crtc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "devm_request_irq(): %d\n", err);
+		goto out;
+	}
+
+	err = tegra_crtc_init(crtc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "tegra_crtc_init(): %d\n", err);
+		goto out;
+	}
+
+	err = tegra_drm_crtc_add(crtc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "tegra_drm_register_crtc(): %d\n", err);
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, crtc);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_dc_remove(struct platform_device *pdev)
+{
+	struct tegra_crtc *crtc = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = tegra_drm_crtc_del(crtc);
+	if (err < 0)
+		goto out;
+
+	err = tegra_crtc_exit(crtc);
+	if (err < 0)
+		goto out;
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+int tegra_drm_crtc_attach(struct drm_device *drm, struct tegra_crtc *crtc)
+{
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, crtc=%p)\n", __func__, drm, crtc);
+
+	drm_crtc_init(drm, &crtc->base, &tegra_crtc_funcs);
+	drm_mode_crtc_set_gamma_size(&crtc->base, 256);
+	drm_crtc_helper_add(&crtc->base, &tegra_crtc_helper_funcs);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_dc_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-dc", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_dc_driver = {
+	.driver = {
+		.name = "tegra-dc",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_dc_of_match),
+	},
+	.probe = tegra_dc_probe,
+	.remove = __devexit_p(tegra_dc_remove),
+};
diff --git a/drivers/gpu/drm/tegra/tegra-dc.h b/drivers/gpu/drm/tegra/tegra-dc.h
new file mode 100644
index 0000000..fbf2f3b
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-dc.h
@@ -0,0 +1,245 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef TEGRA_DC_H
+#define TEGRA_DC_H 1
+
+#define DC_CMD_GENERAL_INCR_SYNCPT 0x000
+#define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL 0x001
+#define DC_CMD_GENERAL_INCR_SYNCPT_ERROR 0x002
+#define DC_CMD_CONT_SYNCPT_VSYNC 0x028
+#define DC_CMD_DISPLAY_COMMAND 0x032
+#define DISP_CTRL_MODE_STOP (0 << 5)
+#define DISP_CTRL_MODE_C_DISPLAY (1 << 5)
+#define DISP_CTRL_MODE_NC_DISPLAY (2 << 5)
+#define DC_CMD_DISPLAY_POWER_CONTROL 0x036
+#define PW0_ENABLE (1 <<  0)
+#define PW1_ENABLE (1 <<  2)
+#define PW2_ENABLE (1 <<  4)
+#define PW3_ENABLE (1 <<  6)
+#define PW4_ENABLE (1 <<  8)
+#define PM0_ENABLE (1 << 16)
+#define PM1_ENABLE (1 << 18)
+
+#define DC_CMD_INT_STATUS 0x037
+#define DC_CMD_INT_MASK 0x038
+#define DC_CMD_INT_ENABLE 0x039
+#define DC_CMD_INT_TYPE 0x03a
+#define DC_CMD_INT_POLARITY 0x03b
+#define CTXSW_INT     (1 << 0)
+#define FRAME_END_INT (1 << 1)
+#define VBLANK_INT    (1 << 2)
+#define WIN_A_UF_INT  (1 << 8)
+#define WIN_B_UF_INT  (1 << 9)
+#define WIN_C_UF_INT  (1 << 10)
+#define WIN_A_OF_INT  (1 << 14)
+#define WIN_B_OF_INT  (1 << 15)
+#define WIN_C_OF_INT  (1 << 16)
+
+#define DC_CMD_STATE_CONTROL 0x041
+#define GENERAL_ACT_REQ (1 <<  0)
+#define WIN_A_ACT_REQ   (1 <<  1)
+#define WIN_B_ACT_REQ   (1 <<  2)
+#define WIN_C_ACT_REQ   (1 <<  3)
+#define GENERAL_UPDATE  (1 <<  8)
+#define WIN_A_UPDATE    (1 <<  9)
+#define WIN_B_UPDATE    (1 << 10)
+#define WIN_C_UPDATE    (1 << 11)
+#define NC_HOST_TRIG    (1 << 24)
+
+#define DC_CMD_DISPLAY_WINDOW_HEADER 0x042
+#define WINDOW_A_SELECT (1 << 4)
+#define WINDOW_B_SELECT (1 << 5)
+#define WINDOW_C_SELECT (1 << 6)
+
+#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
+#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
+#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
+#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
+#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
+#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
+
+#define DC_DISP_DISP_SIGNAL_OPTIONS0 0x400
+#define H_PULSE_0_ENABLE (1 <<  8)
+#define H_PULSE_1_ENABLE (1 << 10)
+#define H_PULSE_2_ENABLE (1 << 12)
+
+#define DC_DISP_DISP_WIN_OPTIONS 0x402
+#define HDMI_ENABLE (1 << 30)
+
+#define DC_DISP_DISP_MEM_HIGH_PRIORITY 0x403
+#define CURSOR_THRESHOLD(x)   (((x) & 0x03) << 24)
+#define WINDOW_A_THRESHOLD(x) (((x) & 0x7f) << 16)
+#define WINDOW_B_THRESHOLD(x) (((x) & 0x7f) <<  8)
+#define WINDOW_C_THRESHOLD(x) (((x) & 0xff) <<  0)
+
+#define DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER 0x404
+#define CURSOR_DELAY(x)   (((x) & 0x3f) << 24)
+#define WINDOW_A_DELAY(x) (((x) & 0x3f) << 16)
+#define WINDOW_B_DELAY(x) (((x) & 0x3f) <<  8)
+#define WINDOW_C_DELAY(x) (((x) & 0x3f) <<  0)
+
+#define DC_DISP_DISP_TIMING_OPTIONS 0x405
+#define VSYNC_H_POSITION(x) ((x) & 0xfff)
+
+#define DC_DISP_REF_TO_SYNC 0x406
+#define DC_DISP_SYNC_WIDTH 0x407
+#define DC_DISP_BACK_PORCH 0x408
+#define DC_DISP_ACTIVE 0x409
+#define DC_DISP_FRONT_PORCH 0x40a
+
+#define DC_DISP_H_PULSE2_POSITION_A 0x416
+#define DC_DISP_H_PULSE2_CONTROL 0x41a
+
+#define PULSE_MODE_NORMAL    (0 << 3)
+#define PULSE_MODE_ONE_CLOCK (1 << 3)
+#define PULSE_POLARITY_HIGH  (0 << 4)
+#define PULSE_POLARITY_LOW   (1 << 4)
+#define PULSE_QUAL_ALWAYS    (0 << 6)
+#define PULSE_QUAL_VACTIVE   (2 << 6)
+#define PULSE_QUAL_VACTIVE1  (3 << 6)
+#define PULSE_LAST_START_A   (0 << 8)
+#define PULSE_LAST_END_A     (1 << 8)
+#define PULSE_LAST_START_B   (2 << 8)
+#define PULSE_LAST_END_B     (3 << 8)
+#define PULSE_LAST_START_C   (4 << 8)
+#define PULSE_LAST_END_C     (5 << 8)
+#define PULSE_LAST_START_D   (6 << 8)
+#define PULSE_LAST_END_D     (7 << 8)
+
+#define PULSE_START(x) (((x) & 0xfff) <<  0)
+#define PULSE_END(x)   (((x) & 0xfff) << 16)
+
+#define DC_DISP_DISP_INTERFACE_CONTROL 0x42f
+#define DISP_DATA_FORMAT_DF1P1C    (0 << 0)
+#define DISP_DATA_FORMAT_DF1P2C24B (1 << 0)
+#define DISP_DATA_FORMAT_DF1P2C18B (2 << 0)
+#define DISP_DATA_FORMAT_DF1P2C16B (3 << 0)
+#define DISP_DATA_FORMAT_DF2S      (4 << 0)
+#define DISP_DATA_FORMAT_DF3S      (5 << 0)
+#define DISP_DATA_FORMAT_DFSPI     (6 << 0)
+#define DISP_DATA_FORMAT_DF1P3C24B (7 << 0)
+#define DISP_DATA_FORMAT_DF1P3C18B (8 << 0)
+#define DISP_ALIGNMENT_MSB         (0 << 8)
+#define DISP_ALIGNMENT_LSB         (1 << 8)
+#define DISP_ORDER_RED_BLUE        (0 << 9)
+#define DISP_ORDER_BLUE_RED        (1 << 9)
+
+#define DC_DISP_DISP_COLOR_CONTROL 0x430
+#define BASE_COLOR_SIZE666     (0 << 0)
+#define BASE_COLOR_SIZE111     (1 << 0)
+#define BASE_COLOR_SIZE222     (2 << 0)
+#define BASE_COLOR_SIZE333     (3 << 0)
+#define BASE_COLOR_SIZE444     (4 << 0)
+#define BASE_COLOR_SIZE555     (5 << 0)
+#define BASE_COLOR_SIZE565     (6 << 0)
+#define BASE_COLOR_SIZE332     (7 << 0)
+#define BASE_COLOR_SIZE888     (8 << 0)
+#define DITHER_CONTROL_DISABLE (0 << 8)
+#define DITHER_CONTROL_ORDERED (2 << 8)
+#define DITHER_CONTROL_ERRDIFF (3 << 8)
+
+#define DC_DISP_SHIFT_CLOCK_OPTIONS 0x431
+
+#define DC_DISP_DATA_ENABLE_OPTIONS 0x432
+#define DE_SELECT_ACTIVE_BLANK  (0 << 0)
+#define DE_SELECT_ACTIVE        (1 << 0)
+#define DE_SELECT_ACTIVE_IS     (2 << 0)
+#define DE_CONTROL_ONECLK       (0 << 2)
+#define DE_CONTROL_NORMAL       (1 << 2)
+#define DE_CONTROL_EARLY_EXT    (2 << 2)
+#define DE_CONTROL_EARLY        (3 << 2)
+#define DE_CONTROL_ACTIVE_BLANK (4 << 2)
+
+#define DC_DISP_DISP_CLOCK_CONTROL 0x42e
+#define PIXEL_CLK_DIVIDER_PCD1  (0 << 8)
+#define PIXEL_CLK_DIVIDER_PCD1H (1 << 8)
+#define PIXEL_CLK_DIVIDER_PCD2  (2 << 8)
+#define PIXEL_CLK_DIVIDER_PCD3  (3 << 8)
+#define PIXEL_CLK_DIVIDER_PCD4  (4 << 8)
+#define PIXEL_CLK_DIVIDER_PCD6  (5 << 8)
+#define PIXEL_CLK_DIVIDER_PCD8  (6 << 8)
+#define PIXEL_CLK_DIVIDER_PCD9  (7 << 8)
+#define PIXEL_CLK_DIVIDER_PCD12 (8 << 8)
+#define PIXEL_CLK_DIVIDER_PCD16 (9 << 8)
+#define PIXEL_CLK_DIVIDER_PCD18 (10 << 8)
+#define PIXEL_CLK_DIVIDER_PCD24 (11 << 8)
+#define PIXEL_CLK_DIVIDER_PCD13 (12 << 8)
+#define SHIFT_CLK_DIVIDER(x)    ((x) & 0xff)
+
+#define DC_WIN_WIN_OPTIONS 0x700
+#define COLOR_EXPAND (1 <<  6)
+#define WIN_ENABLE   (1 << 30)
+
+#define DC_WIN_BYTE_SWAP 0x701
+#define BYTE_SWAP_NOSWAP  (0 << 0)
+#define BYTE_SWAP_SWAP2   (1 << 0)
+#define BYTE_SWAP_SWAP4   (2 << 0)
+#define BYTE_SWAP_SWAP4HW (3 << 0)
+
+#define DC_WIN_BUFFER_CONTROL 0x702
+#define BUFFER_CONTROL_HOST  (0 << 0)
+#define BUFFER_CONTROL_VI    (1 << 0)
+#define BUFFER_CONTROL_EPP   (2 << 0)
+#define BUFFER_CONTROL_MPEGE (3 << 0)
+#define BUFFER_CONTROL_SB2D  (4 << 0)
+
+#define DC_WIN_COLOR_DEPTH 0x703
+#define WIN_COLOR_DEPTH_P1              0
+#define WIN_COLOR_DEPTH_P2              1
+#define WIN_COLOR_DEPTH_P4              2
+#define WIN_COLOR_DEPTH_P8              3
+#define WIN_COLOR_DEPTH_B4G4R4A4        4
+#define WIN_COLOR_DEPTH_B5G5R5A         5
+#define WIN_COLOR_DEPTH_B5G6R5          6
+#define WIN_COLOR_DEPTH_AB5G5R5         7
+#define WIN_COLOR_DEPTH_B8G8R8A8       12
+#define WIN_COLOR_DEPTH_R8G8B8A8       13
+#define WIN_COLOR_DEPTH_B6x2G6x2R6x2A8 14
+#define WIN_COLOR_DEPTH_R6x2G6x2B6x2A8 15
+#define WIN_COLOR_DEPTH_YCbCr422       16
+#define WIN_COLOR_DEPTH_YUV422         17
+#define WIN_COLOR_DEPTH_YCbCr420P      18
+#define WIN_COLOR_DEPTH_YUV420P        19
+#define WIN_COLOR_DEPTH_YCbCr422P      20
+#define WIN_COLOR_DEPTH_YUV422P        21
+#define WIN_COLOR_DEPTH_YCbCr422R      22
+#define WIN_COLOR_DEPTH_YUV422R        23
+#define WIN_COLOR_DEPTH_YCbCr422RA     24
+#define WIN_COLOR_DEPTH_YUV422RA       25
+
+#define DC_WIN_POSITION 0x704
+#define H_POSITION(x) (((x) & 0x1fff) <<  0)
+#define V_POSITION(x) (((x) & 0x1fff) << 16)
+
+#define DC_WIN_SIZE 0x705
+#define H_SIZE(x) (((x) & 0x1fff) <<  0)
+#define V_SIZE(x) (((x) & 0x1fff) << 16)
+
+#define DC_WIN_PRESCALED_SIZE 0x706
+#define H_PRESCALED_SIZE(x) (((x) & 0x7fff) <<  0)
+#define V_PRESCALED_SIZE(x) (((x) & 0x1fff) << 16)
+
+#define DC_WIN_H_INITIAL_DDA 0x707
+#define DC_WIN_V_INITIAL_DDA 0x708
+#define DC_WIN_DDA_INC 0x709
+#define H_DDA_INC(x) (((x) & 0xffff) <<  0)
+#define V_DDA_INC(x) (((x) & 0xffff) << 16)
+
+#define DC_WIN_LINE_STRIDE 0x70a
+#define DC_WIN_BUF_STRIDE 0x70b
+#define DC_WIN_UV_BUF_STRIDE 0x70c
+
+#define DC_WIN_BLEND_NOKEY 0x70f
+#define DC_WIN_BLEND_1WIN 0x710
+
+#define DC_WINBUF_START_ADDR 0x800
+#define DC_WINBUF_ADDR_H_OFFSET 0x806
+#define DC_WINBUF_ADDR_V_OFFSET 0x808
+
+#endif /* TEGRA_DC_H */
diff --git a/drivers/gpu/drm/tegra/tegra-drv.c b/drivers/gpu/drm/tegra/tegra-drv.c
new file mode 100644
index 0000000..10aadd9
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-drv.c
@@ -0,0 +1,600 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <mach/clk.h>
+#include <mach/iomap.h>
+
+#include "tegra-drv.h"
+
+#define DRIVER_NAME "tegra"
+#define DRIVER_DESC "NVIDIA Tegra graphics"
+#define DRIVER_DATE "20120330"
+#define DRIVER_MAJOR 0
+#define DRIVER_MINOR 0
+#define DRIVER_PATCHLEVEL 0
+
+static DEFINE_MUTEX(crtcs_lock);
+static LIST_HEAD(crtcs);
+
+static DEFINE_MUTEX(outputs_lock);
+static LIST_HEAD(outputs);
+
+int tegra_drm_crtc_add(struct tegra_crtc *crtc)
+{
+	int err = 0;
+
+	pr_debug("> %s(crtc=%p)\n", __func__, crtc);
+	pr_debug("  crtc: %p\n", crtc->dev->of_node);
+
+	mutex_lock(&crtcs_lock);
+	list_add_tail(&crtc->list, &crtcs);
+	mutex_unlock(&crtcs_lock);
+
+	pr_debug("< %s() = %d\n", __func__, err);
+	return err;
+}
+
+int tegra_drm_crtc_del(struct tegra_crtc *crtc)
+{
+	int err = 0;
+
+	pr_debug("> %s(crtc=%p)\n", __func__, crtc);
+
+	mutex_lock(&crtcs_lock);
+	list_del_init(&crtc->list);
+	mutex_unlock(&crtcs_lock);
+
+	pr_debug("< %s() = %d\n", __func__, err);
+	return err;
+}
+
+struct tegra_crtc *tegra_drm_crtc_get(struct device *dev, int index)
+{
+	struct tegra_crtc *ret = NULL;
+
+	pr_debug("> %s(dev=%p, index=%d)\n", __func__, dev, index);
+
+	if (dev->of_node) {
+		struct device_node *node =
+			of_parse_phandle(dev->of_node, "display-controllers",
+					 index);
+		struct tegra_crtc *crtc;
+
+		pr_debug("  crtc: %p\n", node);
+
+		list_for_each_entry(crtc, &crtcs, list) {
+			pr_debug("    %p\n", crtc->dev->of_node);
+			if (crtc->dev->of_node == node) {
+				ret = crtc;
+				goto out;
+			}
+		}
+	}
+
+	/* TODO: add non-DT support */
+
+out:
+	pr_debug("< %s() = %p\n", __func__, ret);
+	return ret;
+}
+
+int tegra_drm_output_add(struct tegra_output *output)
+{
+	int err = 0;
+
+	pr_debug("> %s(output=%p)\n", __func__, output);
+	pr_debug("  output: %p\n", output->dev->of_node);
+
+	mutex_lock(&outputs_lock);
+	INIT_LIST_HEAD(&output->list);
+	list_add_tail(&output->list, &outputs);
+	mutex_unlock(&outputs_lock);
+
+	pr_debug("< %s() = %d\n", __func__, err);
+	return err;
+}
+
+int tegra_drm_output_del(struct tegra_output *output)
+{
+	int err = 0;
+
+	pr_debug("> %s(output=%p)\n", __func__, output);
+
+	mutex_lock(&outputs_lock);
+	list_del_init(&output->list);
+	mutex_unlock(&outputs_lock);
+
+	pr_debug("< %s() = %d\n", __func__, err);
+	return err;
+}
+
+struct tegra_output *tegra_drm_output_get(struct tegra_encon *encon)
+{
+	struct tegra_output *ret = NULL;
+
+	pr_debug("> %s(encon=%p)\n", __func__, encon);
+
+	if (encon->of_node) {
+		struct tegra_output *output;
+		struct device_node *node;
+
+		node = of_parse_phandle(encon->of_node, "output", 0);
+		if (!node)
+			goto out;
+
+		list_for_each_entry(output, &outputs, list) {
+			if (output->dev->of_node == node) {
+				ret = output;
+				goto out;
+			}
+		}
+
+		of_node_put(node);
+	}
+
+	/* TODO: add non-DT support */
+
+out:
+	pr_debug("< %s() = %p\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_drm_parse_dt(struct platform_device *pdev,
+			      struct tegra_drm_platform_data **ppdata)
+{
+	struct tegra_drm_platform_data *pdata;
+	const struct property *prop;
+	struct device_node *host1x;
+	struct device_node *gart;
+	size_t size;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p, ppdata=%p)\n", __func__, pdev,
+		ppdata);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	prop = of_find_property(pdev->dev.of_node, "carveout", &size);
+	if (prop) {
+		const __be32 *values = prop->value;
+
+		dev_dbg(&pdev->dev, "carveout: %zu bytes\n", size);
+		dev_dbg(&pdev->dev, "  value: %p\n", prop->value);
+
+		if (size < 8) {
+			dev_err(&pdev->dev, "failed to parse \"carveout\" property\n");
+			err = -EOVERFLOW;
+			goto out;
+		}
+
+		pdata->carveout.start = be32_to_cpup(values++);
+		pdata->carveout.end = be32_to_cpup(values++);
+		pdata->carveout.name = "carveout";
+		pdata->carveout.flags = IORESOURCE_MEM;
+
+		dev_dbg(&pdev->dev, "carveout: %zx-%zx\n",
+			pdata->carveout.start,
+			pdata->carveout.end);
+	}
+
+	gart = of_parse_phandle(pdev->dev.of_node, "gart", 0);
+	if (gart) {
+		err = of_address_to_resource(gart, 1, &pdata->aperture);
+		if (err < 0) {
+			dev_err(&pdev->dev, "of_address_to_resource(): %d\n",
+				err);
+			goto out;
+		}
+
+		of_node_put(gart);
+	}
+
+	/* not used for now */
+	host1x = of_parse_phandle(pdev->dev.of_node, "host1x", 0);
+	dev_dbg(&pdev->dev, "host1x: %p\n", host1x);
+	of_node_put(host1x);
+
+	*ppdata = pdata;
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_create_connectors(struct drm_device *drm)
+{
+	struct platform_device *pdev = drm->platformdev;
+	struct device_node *child;
+	struct device_node *node;
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+
+	node = of_find_node_by_name(pdev->dev.of_node, "connectors");
+	if (!node) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	for_each_child_of_node(node, child) {
+		err = tegra_drm_encon_create(drm, child);
+		if (err < 0) {
+			dev_err(&pdev->dev, "tegra_encon_create(): %d\n", err);
+			continue;
+		}
+
+		dev_dbg(&pdev->dev, "encoder/connector created\n");
+	}
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
+{
+	struct platform_device *pdev = drm->platformdev;
+	struct tegra_drm_platform_data *pdata;
+	struct tegra_drm_private *priv;
+	unsigned int i;
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, flags=%lx)\n", __func__, drm, flags);
+	pdata = pdev->dev.platform_data;
+
+	/* parse platform data */
+	if (!pdata && pdev->dev.of_node) {
+		err = tegra_drm_parse_dt(pdev, &pdata);
+		if (err < 0)
+			goto out;
+	}
+
+	priv = devm_kzalloc(drm->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	priv->carveout = pdata->carveout;
+	priv->aperture = pdata->aperture;
+
+	drm->dev_private = priv;
+
+	if (iommu_present(drm->dev->bus)) {
+		priv->gart = iommu_domain_alloc(drm->dev->bus);
+		if (!priv->gart) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = iommu_attach_device(priv->gart, drm->dev);
+		if (err < 0) {
+			dev_err(drm->dev, "iommu_domain_attach_device(): %d\n",
+				err);
+			goto out;
+		}
+	}
+
+	drm_mode_config_init(drm);
+
+	err = tegra_drm_create_connectors(drm);
+	if (err < 0) {
+		dev_err(drm->dev, "tegra_drm_create_connectors(): %d\n", err);
+		goto out;
+	}
+
+	for (i = 0; /*i < 2*/; i++) {
+		struct tegra_crtc *crtc = tegra_drm_crtc_get(&pdev->dev, i);
+
+		if (!crtc)
+			break;
+
+		dev_dbg(&pdev->dev, "CRTC#%u: %p\n", i, crtc);
+
+		err = tegra_drm_crtc_attach(drm, crtc);
+		if (err < 0) {
+			dev_err(&pdev->dev, "tegra_drm_crtc_attach(): %d\n",
+				err);
+			continue;
+		}
+
+		priv->num_crtcs++;
+	}
+
+	err = tegra_drm_fb_init(drm);
+	if (err < 0) {
+		dev_err(&pdev->dev, "tegra_drm_fb_init(): %d\n", err);
+		goto out;
+	}
+
+	drm_kms_helper_poll_init(drm);
+
+	platform_set_drvdata(pdev, drm);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_unload(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+
+	tegra_drm_fb_exit(drm);
+
+	dev_dbg(drm->dev, "  calling drm_kms_helper_poll_fini()...\n");
+	drm_kms_helper_poll_fini(drm);
+	dev_dbg(drm->dev, "  done\n");
+
+	dev_dbg(drm->dev, "  calling drm_mode_config_cleanup()...\n");
+	drm_mode_config_cleanup(drm);
+	dev_dbg(drm->dev, "  done\n");
+
+	if (priv->gart) {
+		iommu_detach_device(priv->gart, drm->dev);
+		iommu_domain_free(priv->gart);
+	}
+
+	devm_kfree(drm->dev, priv);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_open(struct drm_device *drm, struct drm_file *filp)
+{
+	int err = 0;
+	dev_dbg(drm->dev, "> %s(drm=%p, filp=%p)\n", __func__, drm, filp);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static void tegra_drm_lastclose(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	int err;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+
+	err = drm_fb_helper_restore_fbdev_mode(&priv->fb_helper);
+	dev_dbg(drm->dev, "  drm_fb_helper_restore_fbdev_mode(): %d\n", err);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static int tegra_drm_suspend(struct drm_device *drm, pm_message_t state)
+{
+	int err = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p, state=[%d])\n", __func__, drm,
+		state.event);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_resume(struct drm_device *drm)
+{
+	int err = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_drm_enable_vblank(struct drm_device *drm, int crtc)
+{
+	int err = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p, crtc=%d)\n", __func__, drm, crtc);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static void tegra_drm_disable_vblank(struct drm_device *drm, int crtc)
+{
+	dev_dbg(drm->dev, "> %s(drm=%p, crtc=%d)\n", __func__, drm, crtc);
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static struct drm_ioctl_desc tegra_drm_ioctls[] = {
+};
+
+static const struct file_operations tegra_drm_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_open,
+	.release = drm_release,
+	.unlocked_ioctl = drm_ioctl,
+	.mmap = tegra_drm_gem_mmap,
+	.poll = drm_poll,
+	.fasync = drm_fasync,
+	.read = drm_read,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = tegra_compat_ioctl,
+#endif
+	.llseek = noop_llseek,
+};
+
+static int tegra_debugfs_init(struct drm_minor *minor)
+{
+	int err = 0;
+	dev_dbg(minor->dev->dev, "> %s(minor=%p)\n", __func__, minor);
+	dev_dbg(minor->dev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static void tegra_debugfs_cleanup(struct drm_minor *minor)
+{
+	dev_dbg(minor->dev->dev, "> %s(minor=%p)\n", __func__, minor);
+	dev_dbg(minor->dev->dev, "< %s()\n", __func__);
+}
+
+static struct drm_driver drm_driver = {
+	.driver_features = DRIVER_BUS_PLATFORM | DRIVER_MODESET | DRIVER_GEM,
+	.load = tegra_drm_load,
+	.unload = tegra_drm_unload,
+	.open = tegra_drm_open,
+	.lastclose = tegra_drm_lastclose,
+
+	.suspend = tegra_drm_suspend,
+	.resume = tegra_drm_resume,
+
+	.enable_vblank = tegra_drm_enable_vblank,
+	.disable_vblank = tegra_drm_disable_vblank,
+	.reclaim_buffers = drm_core_reclaim_buffers,
+
+#ifdef CONFIG_DEBUG_FS
+	.debugfs_init = tegra_debugfs_init,
+	.debugfs_cleanup = tegra_debugfs_cleanup,
+#endif
+
+	.gem_init_object = tegra_gem_init_object,
+	.gem_free_object = tegra_gem_free_object,
+	.gem_vm_ops = &tegra_gem_vm_ops,
+
+	.dumb_create = tegra_gem_dumb_create,
+	.dumb_map_offset = tegra_gem_dumb_map_offset,
+	.dumb_destroy = tegra_gem_dumb_destroy,
+
+	.ioctls = tegra_drm_ioctls,
+	.num_ioctls = ARRAY_SIZE(tegra_drm_ioctls),
+	.fops = &tegra_drm_fops,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.date = DRIVER_DATE,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+};
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_drm_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-graphics", },
+	{ },
+};
+/*
+MODULE_DEVICE_TABLE(of, tegra_drm_of_match);
+*/
+#endif
+
+static int __devinit tegra_drm_probe(struct platform_device *pdev)
+{
+	int err;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = drm_platform_init(&drm_driver, pdev);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to initialize DRM driver: %d\n",
+			err);
+		goto out;
+	}
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_drm_remove(struct platform_device *pdev)
+{
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	drm_platform_exit(&drm_driver, pdev);
+
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static struct platform_driver tegra_drm_driver = {
+	.driver = {
+		.name = "tegra-drm",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_drm_of_match),
+	},
+	.probe = tegra_drm_probe,
+	.remove = __devexit_p(tegra_drm_remove),
+};
+
+static int __init tegra_drm_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&tegra_host1x_driver);
+	if (err < 0)
+		return err;
+
+	err = platform_driver_register(&tegra_rgb_driver);
+	if (err < 0)
+		goto unregister_host1x;
+
+	err = platform_driver_register(&tegra_hdmi_driver);
+	if (err < 0)
+		goto unregister_rgb;
+
+	err = platform_driver_register(&tegra_tvo_driver);
+	if (err < 0)
+		goto unregister_hdmi;
+
+	err = platform_driver_register(&tegra_dsi_driver);
+	if (err < 0)
+		goto unregister_tvo;
+
+	err = platform_driver_register(&tegra_dc_driver);
+	if (err < 0)
+		goto unregister_dsi;
+
+	err = platform_driver_register(&tegra_drm_driver);
+	if (err < 0)
+		goto unregister_dc;
+
+	return 0;
+
+unregister_dc:
+	platform_driver_unregister(&tegra_dc_driver);
+unregister_dsi:
+	platform_driver_unregister(&tegra_dsi_driver);
+unregister_tvo:
+	platform_driver_unregister(&tegra_tvo_driver);
+unregister_hdmi:
+	platform_driver_unregister(&tegra_hdmi_driver);
+unregister_rgb:
+	platform_driver_unregister(&tegra_rgb_driver);
+unregister_host1x:
+	platform_driver_unregister(&tegra_host1x_driver);
+	return err;
+}
+module_init(tegra_drm_init);
+
+static void __exit tegra_drm_exit(void)
+{
+	platform_driver_unregister(&tegra_drm_driver);
+	platform_driver_unregister(&tegra_dc_driver);
+	platform_driver_unregister(&tegra_dsi_driver);
+	platform_driver_unregister(&tegra_tvo_driver);
+	platform_driver_unregister(&tegra_hdmi_driver);
+	platform_driver_unregister(&tegra_rgb_driver);
+	platform_driver_unregister(&tegra_host1x_driver);
+}
+module_exit(tegra_drm_exit);
+
+MODULE_AUTHOR("Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+/*
+MODULE_ALIAS("platform:tegra-drm");
+*/
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tegra/tegra-drv.h b/drivers/gpu/drm/tegra/tegra-drv.h
new file mode 100644
index 0000000..c1150b3
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-drv.h
@@ -0,0 +1,201 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef TEGRA_DRV_H
+#define TEGRA_DRV_H
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fixed.h>
+
+#include <drm/tegra_drm.h>
+
+/* synchronization points */
+#define SYNCPT_VBLANK0 26
+#define SYNCPT_VBLANK1 27
+
+struct tegra_crtc_ops;
+
+struct tegra_crtc {
+	struct device *dev;
+
+	struct drm_crtc base;
+	int pipe;
+
+	struct clk *clk_emc;
+	struct clk *clk;
+	bool enabled;
+
+	void __iomem *regs;
+	int irq;
+
+	const struct tegra_crtc_ops *ops;
+
+	struct list_head list;
+};
+
+static inline struct tegra_crtc *to_tegra_crtc(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct tegra_crtc, base);
+}
+
+struct tegra_crtc_ops {
+	int (*enable)(struct tegra_crtc *crtc);
+	int (*disable)(struct tegra_crtc *crtc);
+};
+
+static inline int tegra_crtc_enable(struct tegra_crtc *crtc)
+{
+	if (crtc && crtc->ops && crtc->ops->enable)
+		return crtc->ops->enable(crtc);
+
+	return crtc ? -ENOSYS : -EINVAL;
+}
+
+struct tegra_output;
+
+struct tegra_output_ops {
+	int (*enable)(struct tegra_output *output);
+	int (*disable)(struct tegra_output *output);
+};
+
+struct tegra_output {
+	struct device *dev;
+	enum tegra_drm_output_type type;
+	const struct tegra_output_ops *ops;
+	struct tegra_crtc *crtc;
+	struct list_head list;
+};
+
+static inline int tegra_output_enable(struct tegra_output *output)
+{
+	if (output && output->ops && output->ops->enable)
+		return output->ops->enable(output);
+
+	return output ? -ENOSYS : -EINVAL;
+}
+
+static inline void tegra_crtc_writel(struct tegra_crtc *crtc,
+				     unsigned long value, unsigned long reg)
+{
+	writel(value, crtc->regs + (reg << 2));
+}
+
+static inline unsigned long tegra_crtc_readl(struct tegra_crtc *crtc,
+					     unsigned long reg)
+{
+	return readl(crtc->regs + (reg << 2));
+}
+
+struct tegra_encon {
+	struct device_node *of_node;
+
+	struct i2c_adapter *ddc;
+	const struct edid *edid;
+	int hpd_gpio;
+
+	struct tegra_output *output;
+
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static inline struct tegra_encon *connector_to_encon(
+		struct drm_connector *connector)
+{
+	return container_of(connector, struct tegra_encon, connector);
+}
+
+static inline struct tegra_encon *encoder_to_encon(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct tegra_encon, encoder);
+}
+
+struct tegra_framebuffer {
+	struct drm_framebuffer base;
+	struct tegra_gem_object *obj;
+};
+
+static inline struct tegra_framebuffer *to_tegra_fb(struct drm_framebuffer *fb)
+{
+	return container_of(fb, struct tegra_framebuffer, base);
+}
+
+struct tegra_drm_private {
+	struct tegra_crtc crtc[2];
+	struct drm_encoder_connector *encon[2];
+	struct drm_fb_helper fb_helper;
+	struct tegra_framebuffer fb;
+
+	unsigned int num_crtcs;
+
+	struct iommu_domain *gart;
+	struct resource aperture;
+	struct resource carveout;
+};
+
+struct tegra_gem_object {
+	struct drm_gem_object base;
+	struct resource phys;
+	struct page **pages;
+	void *virt;
+};
+
+static inline struct tegra_gem_object *to_tegra_gem(struct drm_gem_object *obj)
+{
+	return container_of(obj, struct tegra_gem_object, base);
+}
+
+/* from tegra-drv.c */
+extern int tegra_drm_crtc_add(struct tegra_crtc *crtc);
+extern int tegra_drm_crtc_del(struct tegra_crtc *crtc);
+extern struct tegra_crtc *tegra_drm_crtc_get(struct device *dev, int index);
+
+extern int tegra_drm_output_add(struct tegra_output *output);
+extern int tegra_drm_output_del(struct tegra_output *output);
+extern struct tegra_output *tegra_drm_output_get(struct tegra_encon *encon);
+
+extern int tegra_drm_encon_create(struct drm_device *drm,
+				  struct device_node *node);
+
+/* from tegra-dc.c */
+extern int tegra_drm_crtc_attach(struct drm_device *drm,
+				 struct tegra_crtc *crtc);
+
+/* from tegra-gem.c */
+extern struct tegra_gem_object *tegra_gem_alloc(struct drm_device *drm,
+						size_t size);
+extern int tegra_gem_handle_create(struct drm_device *drm,
+				   struct drm_file *file, size_t size,
+				   unsigned long flags, uint32_t *handle);
+extern int tegra_gem_dumb_create(struct drm_file *file, struct drm_device *drm,
+				 struct drm_mode_create_dumb *args);
+extern int tegra_gem_dumb_map_offset(struct drm_file *file,
+				     struct drm_device *drm, uint32_t handle,
+				     uint64_t *offset);
+extern int tegra_gem_dumb_destroy(struct drm_file *file,
+				  struct drm_device *drm, uint32_t handle);
+extern int tegra_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+extern int tegra_gem_init_object(struct drm_gem_object *obj);
+extern void tegra_gem_free_object(struct drm_gem_object *obj);
+extern struct vm_operations_struct tegra_gem_vm_ops;
+
+/* from tegra-fb.c */
+extern int tegra_drm_fb_init(struct drm_device *drm);
+extern void tegra_drm_fb_exit(struct drm_device *drm);
+
+extern struct platform_driver tegra_host1x_driver;
+extern struct platform_driver tegra_rgb_driver;
+extern struct platform_driver tegra_hdmi_driver;
+extern struct platform_driver tegra_tvo_driver;
+extern struct platform_driver tegra_dsi_driver;
+extern struct platform_driver tegra_dc_driver;
+
+#endif /* TEGRA_DRV_H */
diff --git a/drivers/gpu/drm/tegra/tegra-dsi.c b/drivers/gpu/drm/tegra/tegra-dsi.c
new file mode 100644
index 0000000..774888b9
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-dsi.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "tegra-drv.h"
+
+struct tegra_dsi {
+	struct tegra_output base;
+
+	void __iomem *regs;
+	struct clk *clk;
+};
+
+static inline struct tegra_dsi *to_dsi(struct tegra_output *output)
+{
+	return container_of(output, struct tegra_dsi, base);
+}
+
+static int tegra_output_dsi_enable(struct tegra_output *output)
+{
+	struct tegra_dsi *dsi = to_dsi(output);
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	err = clk_prepare_enable(dsi->clk);
+	if (err < 0)
+		goto out;
+
+out:
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_output_dsi_disable(struct tegra_output *output)
+{
+	struct tegra_dsi *dsi = to_dsi(output);
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	clk_disable_unprepare(dsi->clk);
+
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static const struct tegra_output_ops dsi_ops = {
+	.enable = tegra_output_dsi_enable,
+	.disable = tegra_output_dsi_disable,
+};
+
+static int __devinit tegra_dsi_probe(struct platform_device *pdev)
+{
+	struct tegra_dsi *dsi;
+	struct resource *regs;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	dsi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(dsi->clk)) {
+		err = -EPROBE_DEFER;
+		goto out;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		err = -ENXIO;
+		goto put_clk;
+	}
+
+	dsi->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!dsi->regs) {
+		err = -EADDRNOTAVAIL;
+		goto put_clk;
+	}
+
+	dsi->base.type = TEGRA_DRM_OUTPUT_DSI;
+	dsi->base.dev = &pdev->dev;
+	dsi->base.ops = &dsi_ops;
+
+	err = tegra_drm_output_add(&dsi->base);
+	if (err < 0)
+		goto put_clk;
+
+	platform_set_drvdata(pdev, dsi);
+	goto out;
+
+put_clk:
+	clk_put(dsi->clk);
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_dsi_remove(struct platform_device *pdev)
+{
+	struct tegra_dsi *dsi = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = tegra_drm_output_del(&dsi->base);
+	if (err < 0)
+		goto out;
+
+	clk_put(dsi->clk);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_dsi_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-dsi", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_dsi_driver = {
+	.driver = {
+		.name = "tegra-dsi",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_dsi_of_match),
+	},
+	.probe = tegra_dsi_probe,
+	.remove = __devexit_p(tegra_dsi_remove),
+};
diff --git a/drivers/gpu/drm/tegra/tegra-encon.c b/drivers/gpu/drm/tegra/tegra-encon.c
new file mode 100644
index 0000000..7b13022
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-encon.c
@@ -0,0 +1,406 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of_i2c.h>
+
+#include "tegra-drv.h"
+
+static int tegra_connector_get_modes(struct drm_connector *connector)
+{
+	struct tegra_encon *encon = connector_to_encon(connector);
+	struct edid *edid = NULL;
+	int ret = 0;
+
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+
+	if (encon->edid) {
+		edid = kmemdup(encon->edid, sizeof(*edid), GFP_KERNEL);
+		dev_dbg(&connector->kdev, "DT: %p (%zu bytes)\n",
+			encon->edid, sizeof(*edid));
+	} else if (encon->ddc) {
+		dev_dbg(&connector->kdev, "probing DDC...\n");
+		edid = drm_get_edid(connector, encon->ddc);
+	}
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	dev_dbg(&connector->kdev, "EDID: %p\n", edid);
+
+	if (edid) {
+		ret = drm_add_edid_modes(connector, edid);
+		kfree(edid);
+	}
+
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_connector_mode_valid(struct drm_connector *connector,
+				      struct drm_display_mode *mode)
+{
+	int ret = MODE_OK;
+	dev_dbg(&connector->kdev, "> %s(connector=%p, mode=%p)\n", __func__,
+		connector, mode);
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static struct drm_encoder *tegra_connector_best_encoder(
+		struct drm_connector *connector)
+{
+	struct tegra_encon *encon = connector_to_encon(connector);
+	struct drm_encoder *ret = &encon->encoder;
+	dev_dbg(&encon->connector.kdev, "> %s(connector=%p)\n", __func__,
+		connector);
+	dev_dbg(&encon->connector.kdev, "< %s() = %p\n", __func__, ret);
+	return ret;
+}
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = tegra_connector_get_modes,
+	.mode_valid = tegra_connector_mode_valid,
+	.best_encoder = tegra_connector_best_encoder,
+};
+
+static void tegra_connector_dpms(struct drm_connector *connector, int mode)
+{
+	dev_dbg(&connector->kdev, "> %s(connector=%p, mode=%d)\n", __func__,
+		connector, mode);
+	dev_dbg(&connector->kdev, "< %s()\n", __func__);
+}
+
+static void tegra_connector_save(struct drm_connector *connector)
+{
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+	dev_dbg(&connector->kdev, "< %s()\n", __func__);
+}
+
+static void tegra_connector_restore(struct drm_connector *connector)
+{
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+	dev_dbg(&connector->kdev, "< %s()\n", __func__);
+}
+
+static void tegra_connector_reset(struct drm_connector *connector)
+{
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+	dev_dbg(&connector->kdev, "< %s()\n", __func__);
+}
+
+static enum drm_connector_status tegra_connector_detect(
+					struct drm_connector *connector,
+					bool force)
+{
+	enum drm_connector_status status = connector_status_unknown;
+
+	dev_dbg(&connector->kdev, "> %s(connector=%p, force=%d)\n", __func__,
+		connector, force);
+
+	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
+		status = connector_status_connected;
+
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, status);
+	return status;
+}
+
+static int tegra_connector_fill_modes(struct drm_connector *connector,
+				      uint32_t max_width, uint32_t max_height)
+{
+	int ret = 0;
+
+	dev_dbg(&connector->kdev, "> %s(connector=%p, max_width=%u, max_height=%u)\n",
+		__func__, connector, max_width, max_height);
+
+	ret = drm_helper_probe_single_connector_modes(connector, max_width,
+						      max_height);
+
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_connector_set_property(struct drm_connector *connector,
+					struct drm_property *property,
+					uint64_t value)
+{
+	int ret = 0;
+	dev_dbg(&connector->kdev, "> %s(connector=%p, property=%p, value=%llx)\n",
+		__func__, connector, property, value);
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_connector_destroy(struct drm_connector *connector)
+{
+	pr_debug("> %s(connector=%p)\n", __func__, connector);
+	drm_sysfs_connector_remove(connector);
+	drm_connector_cleanup(connector);
+	pr_debug("< %s()\n", __func__);
+}
+
+static void tegra_connector_force(struct drm_connector *connector)
+{
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+	dev_dbg(&connector->kdev, "< %s()\n", __func__);
+}
+
+static const struct drm_connector_funcs connector_funcs = {
+	.dpms = tegra_connector_dpms,
+	.save = tegra_connector_save,
+	.restore = tegra_connector_restore,
+	.reset = tegra_connector_reset,
+
+	.detect = tegra_connector_detect,
+	.fill_modes = tegra_connector_fill_modes,
+	.set_property = tegra_connector_set_property,
+	.destroy = tegra_connector_destroy,
+	.force = tegra_connector_force,
+};
+
+static void tegra_encoder_reset(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_encoder_destroy(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static const struct drm_encoder_funcs encoder_funcs = {
+	.reset = tegra_encoder_reset,
+	.destroy = tegra_encoder_destroy,
+};
+
+static void tegra_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%d)\n", __func__,
+		encoder, mode);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_encoder_save(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_encoder_restore(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static bool tegra_encoder_mode_fixup(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adjusted)
+{
+	bool ret = true;
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%p, adjusted=%p)\n",
+		__func__, encoder, mode, adjusted);
+	dev_dbg(encoder->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_encoder_prepare(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_encoder_commit(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_encoder_mode_set(struct drm_encoder *encoder,
+				   struct drm_display_mode *mode,
+				   struct drm_display_mode *adjusted)
+{
+	struct tegra_encon *encon = encoder_to_encon(encoder);
+	struct tegra_crtc *crtc;
+	int err;
+
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%p, adjusted=%p)\n",
+		__func__, encoder, mode, adjusted);
+
+	if (!encon->output) {
+		dev_warn(encoder->dev->dev, "no output associated with encoder\n");
+		goto out;
+	}
+
+	crtc = to_tegra_crtc(encoder->crtc);
+	encon->output->crtc = crtc;
+
+	err = tegra_output_enable(encon->output);
+	if (err < 0) {
+		dev_err(encoder->dev->dev, "tegra_output_enable(): %d\n", err);
+		goto out;
+	}
+
+out:
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static struct drm_crtc *tegra_encoder_get_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *ret = encoder->crtc;
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s() = %p\n", __func__, ret);
+	return ret;
+}
+
+static enum drm_connector_status tegra_encoder_detect(
+						struct drm_encoder *encoder,
+						struct drm_connector *connector)
+{
+	enum drm_connector_status status = connector_status_unknown;
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, connector=%p)\n", __func__,
+		encoder, connector);
+	dev_dbg(encoder->dev->dev, "< %s() = %d\n", __func__, status);
+	return status;
+}
+
+static void tegra_encoder_disable(struct drm_encoder *encoder)
+{
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static irqreturn_t hpd_irq(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_HANDLED;
+	pr_debug("> %s(irq=%d, data=%p)\n", __func__, irq, data);
+	pr_debug("< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.dpms = tegra_encoder_dpms,
+	.save = tegra_encoder_save,
+	.restore = tegra_encoder_restore,
+	.mode_fixup = tegra_encoder_mode_fixup,
+	.prepare = tegra_encoder_prepare,
+	.commit = tegra_encoder_commit,
+	.mode_set = tegra_encoder_mode_set,
+	.get_crtc = tegra_encoder_get_crtc,
+	.detect = tegra_encoder_detect,
+	.disable = tegra_encoder_disable,
+};
+
+int tegra_drm_encon_create(struct drm_device *drm, struct device_node *node)
+{
+	struct tegra_encon *encon;
+	enum of_gpio_flags flags;
+	int connector;
+	int encoder;
+	size_t size;
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, node=%p)\n", __func__, drm, node);
+
+	encon = devm_kzalloc(drm->dev, sizeof(*encon), GFP_KERNEL);
+	if (!encon) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	encon->of_node = node;
+
+	encon->output = tegra_drm_output_get(encon);
+	if (!encon->output) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	encon->edid = of_get_property(encon->of_node, "edid", &size);
+	if (!encon->edid) {
+		struct device_node *ddc;
+
+		ddc = of_parse_phandle(encon->of_node, "ddc", 0);
+		if (!ddc) {
+			dev_err(drm->dev, "\"ddc\" property not found\n");
+			err = -ENODEV;
+			goto out;
+		}
+
+		encon->ddc = of_i2c_get_adapter(ddc);
+		if (!encon->ddc) {
+			of_node_put(ddc);
+			err = -ENODEV;
+			goto out;
+		}
+
+		of_node_put(ddc);
+	}
+
+	err = of_get_named_gpio_flags(encon->of_node, "hpd-gpio", 0, &flags);
+	if (err < 0) {
+		encon->hpd_gpio = -1;
+		err = 0;
+	}
+
+	switch (encon->output->type) {
+	case TEGRA_DRM_OUTPUT_RGB:
+		connector = DRM_MODE_CONNECTOR_LVDS;
+		encoder = DRM_MODE_ENCODER_LVDS;
+		break;
+
+	case TEGRA_DRM_OUTPUT_HDMI:
+		connector = DRM_MODE_CONNECTOR_HDMIA;
+		encoder = DRM_MODE_ENCODER_TMDS;
+		break;
+
+	default:
+		connector = DRM_MODE_CONNECTOR_Unknown;
+		encoder = DRM_MODE_ENCODER_NONE;
+		break;
+	}
+
+	drm_connector_init(drm, &encon->connector, &connector_funcs, connector);
+	drm_connector_helper_add(&encon->connector, &connector_helper_funcs);
+
+	drm_encoder_init(drm, &encon->encoder, &encoder_funcs, encoder);
+	drm_encoder_helper_add(&encon->encoder, &encoder_helper_funcs);
+
+	drm_mode_connector_attach_encoder(&encon->connector, &encon->encoder);
+	drm_sysfs_connector_add(&encon->connector);
+
+	encon->encoder.possible_crtcs = 0x3;
+
+	if (encon->hpd_gpio >= 0) {
+		unsigned long flags;
+		unsigned int irq;
+
+		err = gpio_to_irq(encon->hpd_gpio);
+		if (err < 0) {
+			dev_err(drm->dev, "gpio_to_irq(): %d\n", err);
+			goto out;
+		}
+
+		irq = err;
+
+		flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+			IRQF_SHARED;
+
+		err = devm_request_irq(drm->dev, irq, hpd_irq, flags, "hpd",
+				       encon);
+		if (err < 0) {
+			dev_err(drm->dev, "failed to request IRQ#%u: %d\n",
+				irq, err);
+			goto out;
+		}
+	}
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
diff --git a/drivers/gpu/drm/tegra/tegra-fb.c b/drivers/gpu/drm/tegra/tegra-fb.c
new file mode 100644
index 0000000..bb3b469
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-fb.c
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "tegra-drv.h"
+
+static int tegra_drmfb_create_handle(struct drm_framebuffer *fb,
+				     struct drm_file *filp,
+				     unsigned int *handle)
+{
+	struct tegra_framebuffer *privfb = to_tegra_fb(fb);
+	struct drm_device *drm = fb->dev;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(fb=%p, filp=%p, handle=%p)\n", __func__, fb,
+		filp, handle);
+
+	ret = drm_gem_handle_create(filp, &privfb->obj->base, handle);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_drmfb_destroy(struct drm_framebuffer *fb)
+{
+	struct tegra_framebuffer *priv = to_tegra_fb(fb);
+	struct drm_gem_object *obj = &priv->obj->base;
+	struct drm_device *drm = fb->dev;
+
+	dev_dbg(drm->dev, "> %s(fb=%p)\n", __func__, fb);
+
+	drm_framebuffer_cleanup(fb);
+	drm_gem_object_unreference_unlocked(obj);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static const struct drm_framebuffer_funcs tegra_drmfb_funcs = {
+	.create_handle = tegra_drmfb_create_handle,
+	.destroy = tegra_drmfb_destroy,
+};
+
+static int tegra_fb_init(struct drm_device *drm, struct tegra_framebuffer *fb,
+			 struct drm_mode_fb_cmd2 *mode)
+{
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, fb=%p, mode=%p)\n", __func__, drm, fb,
+		mode);
+
+	/* TODO: add sanity checks */
+
+	ret = drm_framebuffer_init(drm, &fb->base, &tegra_drmfb_funcs);
+	if (ret < 0) {
+		DRM_ERROR("framebuffer init failed %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_helper_mode_fill_fb_struct(&fb->base, mode);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static struct drm_framebuffer *tegra_drm_fb_create(struct drm_device *drm,
+						   struct drm_file *filp,
+						   struct drm_mode_fb_cmd2 *cmd)
+{
+	struct drm_framebuffer *drmfb = NULL;
+	struct tegra_framebuffer *fb = NULL;
+	struct drm_gem_object *obj;
+	u32 bpp, depth;
+	int err;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, filp=%p, cmd=%p)\n", __func__, drm,
+		filp, cmd);
+
+	drm_fb_get_bpp_depth(cmd->pixel_format, &depth, &bpp);
+
+	obj = drm_gem_object_lookup(drm, filp, cmd->handles[0]);
+	if (!obj) {
+		drmfb = ERR_PTR(-ENOENT);
+		goto out;
+	}
+
+	fb = devm_kzalloc(drm->dev, sizeof(*fb), GFP_KERNEL);
+	if (!fb) {
+		drmfb = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	err = tegra_fb_init(drm, fb, cmd);
+	if (err < 0) {
+		devm_kfree(drm->dev, fb);
+		drmfb = ERR_PTR(err);
+		goto out;
+	}
+
+	fb->obj = to_tegra_gem(obj);
+	drmfb = &fb->base;
+
+out:
+	dev_dbg(drm->dev, "< %s() = %p\n", __func__, drmfb);
+	return drmfb;
+}
+
+static void tegra_drm_fb_output_poll_changed(struct drm_device *drm)
+{
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+struct drm_mode_config_funcs tegra_drm_mode_funcs = {
+	.fb_create = tegra_drm_fb_create,
+	.output_poll_changed = tegra_drm_fb_output_poll_changed,
+};
+
+static void tegra_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
+			       u16 blue, int regno)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, red=%u, green=%u, blue=%u, regno=%d)\n",
+		__func__, crtc, red, green, blue, regno);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
+			       u16 *blue, int regno)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, red=%p, green=%p, blue=%p, regno=%d)\n",
+		__func__, crtc, red, green, blue, regno);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static struct fb_ops tegra_fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_check_var = drm_fb_helper_check_var,
+	.fb_set_par = drm_fb_helper_set_par,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_pan_display = drm_fb_helper_pan_display,
+	.fb_blank = drm_fb_helper_blank,
+	.fb_setcmap = drm_fb_helper_setcmap,
+	.fb_debug_enter = drm_fb_helper_debug_enter,
+	.fb_debug_leave = drm_fb_helper_debug_leave,
+};
+
+static int tegra_fb_create(struct drm_fb_helper *helper,
+			   struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *drm = helper->dev;
+	struct tegra_drm_private *priv = drm->dev_private;
+	struct drm_framebuffer *drmfb;
+	struct drm_mode_fb_cmd2 mode;
+	struct tegra_gem_object *obj;
+	struct fb_info *info;
+	size_t size;
+	int ret = 0;
+	u32 depth;
+	u32 bpp;
+
+	dev_dbg(drm->dev, "> %s(helper=%p, sizes=%p)\n", __func__, helper,
+		sizes);
+	dev_dbg(drm->dev, "  sizes:\n");
+	dev_dbg(drm->dev, "    fb: %ux%u\n", sizes->fb_width, sizes->fb_height);
+	dev_dbg(drm->dev, "    surface: %ux%u (bpp:%u, depth=%u)\n",
+			sizes->surface_width, sizes->surface_height,
+			sizes->surface_bpp, sizes->surface_depth);
+
+	mode.width = sizes->surface_width;
+	mode.height = sizes->surface_height;
+
+	depth = sizes->surface_depth;
+	bpp = sizes->surface_bpp;
+
+	if (bpp == 24)
+		bpp = 32;
+
+	mode.pitches[0] = mode.width * DIV_ROUND_UP(bpp, 8);
+	size = mode.pitches[0] * mode.height;
+	size = ALIGN(size, PAGE_SIZE);
+
+	info = framebuffer_alloc(0, drm->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	info->par = helper;
+
+	dev_dbg(drm->dev, "  bpp:%u depth:%u\n", bpp, depth);
+
+	mode.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
+
+	ret = tegra_fb_init(drm, &priv->fb, &mode);
+	if (ret < 0)
+		goto out;
+
+	strcpy(info->fix.id, "tegra-drm-fb");
+
+	drmfb = &priv->fb.base;
+	priv->fb_helper.fb = drmfb;
+	priv->fb_helper.fbdev = info;
+
+	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
+	info->fbops = &tegra_fb_ops;
+
+	obj = tegra_gem_alloc(drm, size);
+	if (!obj) {
+		dev_err(drm->dev, "tegra_gem_alloc_object() failed\n");
+		return -ENOMEM;
+	}
+
+	dev_dbg(drm->dev, "  GEM object: %p\n", obj);
+
+	info->screen_base = obj->virt;
+	priv->fb.obj = obj;
+
+	memset(info->screen_base, 0, size);
+
+	info->fix.smem_start = priv->fb.obj->phys.start;
+	info->fix.smem_len = size;
+
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	info->screen_size = size;
+
+	drm_fb_helper_fill_fix(info, drmfb->pitches[0], drmfb->depth);
+	drm_fb_helper_fill_var(info, &priv->fb_helper, sizes->fb_width,
+			       sizes->fb_height);
+
+	dev_info(drm->dev, "allocated %ux%u\n", drmfb->width, drmfb->height);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_fb_probe(struct drm_fb_helper *helper,
+			  struct drm_fb_helper_surface_size *sizes)
+{
+	int ret = 0;
+
+	dev_dbg(helper->dev->dev, "> %s(helper=%p, sizes=%p)\n", __func__,
+		helper, sizes);
+
+	if (!helper->fb) {
+		ret = tegra_fb_create(helper, sizes);
+		if (ret == 0)
+			ret = 1;
+	}
+
+	dev_dbg(helper->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static struct drm_fb_helper_funcs tegra_fb_helper_funcs = {
+	.gamma_set = tegra_fb_gamma_set,
+	.gamma_get = tegra_fb_gamma_get,
+	.fb_probe = tegra_fb_probe,
+};
+
+int tegra_drm_fb_init(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+	dev_dbg(drm->dev, "  crtcs:%u connectors:%u\n", priv->num_crtcs,
+		drm->mode_config.num_connector);
+
+	drm->mode_config.min_width = 0;
+	drm->mode_config.min_height = 0;
+
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
+
+	drm->mode_config.funcs = &tegra_drm_mode_funcs;
+
+	drm->mode_config.fb_base = 0xdeadbeef;
+
+	priv->fb_helper.funcs = &tegra_fb_helper_funcs;
+
+	ret = drm_fb_helper_init(drm, &priv->fb_helper, priv->num_crtcs,
+				 drm->mode_config.num_connector);
+	if (ret < 0)
+		goto out;
+
+	ret = drm_fb_helper_single_add_all_connectors(&priv->fb_helper);
+	if (ret < 0)
+		goto out;
+
+	ret = drm_fb_helper_initial_config(&priv->fb_helper, 32);
+	if (ret < 0)
+		goto out;
+
+#ifndef CONFIG_FRAMEBUFFER_CONSOLE
+	ret = drm_fb_helper_restore_fbdev_mode(&priv->fb_helper);
+	dev_dbg(drm->dev, "drm_fb_helper_restore_fbdev_mode(): %d\n", ret);
+	if (ret < 0)
+		goto out;
+#endif
+
+	ret = 0;
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+void tegra_drm_fb_exit(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	struct drm_fb_helper *fb_helper = &priv->fb_helper;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+	dev_dbg(drm->dev, "  fbdev: %p\n", fb_helper->fb);
+
+	if (fb_helper->fbdev) {
+		struct fb_info *info = fb_helper->fbdev;
+		int err;
+
+		dev_dbg(drm->dev, "  unregistering framebuffer...\n");
+
+		err = unregister_framebuffer(info);
+		if (err < 0)
+			dev_dbg(drm->dev, "unregister_framebuffer(): %d\n",
+				err);
+
+		dev_dbg(drm->dev, "  done\n");
+
+		if (info->cmap.len) {
+			dev_dbg(drm->dev, "  deallocating cmap...\n");
+			fb_dealloc_cmap(&info->cmap);
+			dev_dbg(drm->dev, "  done\n");
+		}
+
+		dev_dbg(drm->dev, "  releasing framebuffer...\n");
+		framebuffer_release(info);
+		dev_dbg(drm->dev, "  done\n");
+	}
+
+	dev_dbg(drm->dev, "  finalizing DRM FB helper...\n");
+	drm_fb_helper_fini(fb_helper);
+	dev_dbg(drm->dev, "  done\n");
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
diff --git a/drivers/gpu/drm/tegra/tegra-gem.c b/drivers/gpu/drm/tegra/tegra-gem.c
new file mode 100644
index 0000000..92b403c
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-gem.c
@@ -0,0 +1,425 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/iommu.h>
+#include <linux/shmem_fs.h>
+
+#include "tegra-drv.h"
+
+static int tegra_gem_get_pages(struct drm_device *drm,
+			       struct tegra_gem_object *obj, gfp_t gfp)
+{
+	struct address_space *mapping;
+	unsigned int num_pages;
+	struct inode *inode;
+	struct page *page;
+	unsigned int i;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p, gfp=%x)\n", __func__, drm,
+		obj, gfp);
+
+	if (obj->pages)
+		goto out;
+
+	num_pages = obj->base.size / PAGE_SIZE;
+
+	obj->pages = drm_malloc_ab(num_pages, sizeof(page));
+	if (!obj->pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	inode = obj->base.filp->f_path.dentry->d_inode;
+	mapping = inode->i_mapping;
+	gfp |= mapping_gfp_mask(mapping);
+
+	for (i = 0; i < num_pages; i++) {
+		page = shmem_read_mapping_page_gfp(mapping, i, gfp);
+		if (IS_ERR(page))
+			goto err_pages;
+
+		obj->pages[i] = page;
+	}
+
+	ret = 0;
+	goto out;
+
+err_pages:
+	while (i--)
+		page_cache_release(obj->pages[i]);
+
+	ret = PTR_ERR(page);
+	drm_free_large(obj->pages);
+	obj->pages = NULL;
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_gem_put_pages(struct drm_device *drm,
+				struct tegra_gem_object *obj)
+{
+	unsigned int num = obj->base.size / PAGE_SIZE;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	while (num--)
+		page_cache_release(obj->pages[num]);
+
+	drm_free_large(obj->pages);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static int tegra_gem_map(struct drm_device *drm, struct tegra_gem_object *obj)
+{
+	unsigned int num_pages = obj->base.size / PAGE_SIZE;
+	int ret = -ENOSYS;
+	pgprot_t prot;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	ret = tegra_gem_get_pages(drm, obj, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	dev_dbg(drm->dev, "  num_pages: %u\n", num_pages);
+
+	prot = pgprot_writecombine(pgprot_kernel);
+
+	obj->virt = vmap(obj->pages, num_pages, 0, prot);
+	if (!obj->virt) {
+		tegra_gem_put_pages(drm, obj);
+		ret = -ENOMEM;
+	}
+
+	dev_dbg(drm->dev, "  virt: %p\n", obj->virt);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_gem_unmap(struct drm_device *drm,
+			    struct tegra_gem_object *obj)
+{
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	vunmap(obj->virt);
+	tegra_gem_put_pages(drm, obj);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static int tegra_gem_gart_map(struct drm_device *drm,
+			      struct tegra_gem_object *obj)
+{
+	unsigned int num_pages = obj->base.size / PAGE_SIZE;
+	struct tegra_drm_private *priv = drm->dev_private;
+	resource_size_t min = priv->aperture.start;
+	resource_size_t max = priv->aperture.end;
+	resource_size_t size = obj->base.size;
+	phys_addr_t iova;
+	unsigned int i;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	if (!priv->gart) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = allocate_resource(&priv->aperture, &obj->phys, size, min, max,
+				PAGE_SIZE, NULL, NULL);
+	if (ret < 0)
+		goto out;
+
+	dev_dbg(drm->dev, "  allocation: %#x-%#x\n", obj->phys.start,
+		obj->phys.end);
+	iova = obj->phys.start;
+
+	for (i = 0; i < num_pages; i++) {
+		struct page *page = obj->pages[i];
+		phys_addr_t phys;
+		int err;
+
+		phys = page_to_phys(page);
+
+		err = iommu_map(priv->gart, iova, phys, PAGE_SIZE, 0);
+		if (err < 0)
+			dev_err(drm->dev, "iommu_map(): %d\n", err);
+
+		iova += PAGE_SIZE;
+	}
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_gem_gart_unmap(struct drm_device *drm,
+				 struct tegra_gem_object *obj)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	unsigned int num = obj->base.size / PAGE_SIZE;
+	phys_addr_t iova = obj->phys.start;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	while (num--) {
+		iommu_unmap(priv->gart, iova, PAGE_SIZE);
+		iova += PAGE_SIZE;
+	}
+
+	release_resource(&obj->phys);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+struct tegra_gem_object *tegra_gem_alloc(struct drm_device *drm, size_t size)
+{
+	struct tegra_gem_object *obj;
+	int err;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, size=%zu)\n", __func__, drm, size);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		goto out;
+
+	err = drm_gem_object_init(drm, &obj->base, size);
+	if (err < 0) {
+		kfree(obj);
+		goto out;
+	}
+
+	err = tegra_gem_map(drm, obj);
+	if (err < 0) {
+		dev_err(drm->dev, "tegra_gem_vmap(): %d\n", err);
+		kfree(obj);
+		obj = NULL;
+		goto out;
+	}
+
+	err = tegra_gem_gart_map(drm, obj);
+	if (err < 0) {
+		dev_err(drm->dev, "tegra_gem_gart_map(): %d\n", err);
+		tegra_gem_unmap(drm, obj);
+		kfree(obj);
+		obj = NULL;
+		goto out;
+	}
+
+	dev_dbg(drm->dev, "%s(): GEM allocated: %p @%#x/%p\n", __func__,
+		obj, obj->phys.start, obj->virt);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %p\n", __func__, obj);
+	return obj;
+}
+
+static void tegra_gem_free(struct drm_device *drm,
+			   struct tegra_gem_object *obj)
+{
+	dev_dbg(drm->dev, "> %s(drm=%p, obj=%p)\n", __func__, drm, obj);
+
+	tegra_gem_gart_unmap(drm, obj);
+	tegra_gem_unmap(drm, obj);
+	drm_gem_object_release(&obj->base);
+	kfree(obj);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+int tegra_gem_handle_create(struct drm_device *drm, struct drm_file *file,
+			    size_t size, unsigned long flags, u32 *handle)
+{
+	struct tegra_gem_object *obj;
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, file=%p, size=%zu, flags=%#lx, handle=%p)\n",
+		__func__, drm, file, size, flags, handle);
+
+	obj = tegra_gem_alloc(drm, size);
+	if (!obj) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = drm_gem_handle_create(file, &obj->base, handle);
+	if (err < 0) {
+		tegra_gem_free(drm, obj);
+		goto out;
+	}
+
+	drm_gem_object_unreference(&obj->base);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static inline unsigned int align_pitch(unsigned int pitch, unsigned int width,
+				       unsigned int bpp)
+{
+	return max(pitch, width * DIV_ROUND_UP(bpp, 8));
+}
+
+int tegra_gem_dumb_create(struct drm_file *file, struct drm_device *drm,
+			  struct drm_mode_create_dumb *args)
+{
+	int err;
+
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, args=%p)\n", __func__, file,
+		drm, args);
+
+	args->pitch = align_pitch(args->pitch, args->width, args->bpp);
+	args->size = PAGE_ALIGN(args->pitch * args->height);
+
+	err = tegra_gem_handle_create(drm, file, args->size, 0, &args->handle);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+int tegra_gem_dumb_map_offset(struct drm_file *file, struct drm_device *drm,
+			      uint32_t handle, uint64_t *offset)
+{
+	struct tegra_gem_object *gem;
+	struct drm_gem_object *obj;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, handle=%x, offset=%p)\n",
+		__func__, file, drm, handle, offset);
+
+	mutex_lock(&drm->struct_mutex);
+
+	obj = drm_gem_object_lookup(drm, file, handle);
+	if (!obj) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	gem = to_tegra_gem(obj);
+
+	ret = tegra_gem_get_pages(drm, gem, GFP_KERNEL);
+	if (ret < 0)
+		goto unref;
+
+	if (!obj->map_list.map) {
+		ret = drm_gem_create_mmap_offset(obj);
+		if (ret < 0)
+			goto unref;
+	}
+
+	*offset = (u64)obj->map_list.hash.key << PAGE_SHIFT;
+
+unref:
+	drm_gem_object_unreference(obj);
+out:
+	mutex_unlock(&drm->struct_mutex);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+int tegra_gem_dumb_destroy(struct drm_file *file, struct drm_device *drm,
+			   uint32_t handle)
+{
+	int err = 0;
+
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, handle=%x)\n", __func__,
+		file, drm, handle);
+
+	err = drm_gem_handle_delete(file, handle);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+int tegra_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int ret = 0;
+
+	pr_debug("> %s(filp=%p, vma=%p)\n", __func__, filp, vma);
+
+	ret = drm_gem_mmap(filp, vma);
+	if (ret < 0)
+		goto out;
+
+	vma->vm_flags &= ~VM_PFNMAP;
+	vma->vm_flags |= VM_MIXEDMAP;
+
+out:
+	pr_debug("< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+int tegra_gem_init_object(struct drm_gem_object *obj)
+{
+	int ret = -ENOSYS;
+	dev_dbg(obj->dev->dev, "> %s(obj=%p)\n", __func__, obj);
+	dev_dbg(obj->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+void tegra_gem_free_object(struct drm_gem_object *obj)
+{
+	struct tegra_gem_object *gem = to_tegra_gem(obj);
+	struct drm_device *drm = obj->dev;
+
+	dev_dbg(drm->dev, "> %s(obj=%p)\n", __func__, obj);
+	dev_dbg(drm->dev, "  map_list: %p\n", obj->map_list.map);
+
+	if (obj->map_list.map)
+		drm_gem_free_mmap_offset(obj);
+
+	tegra_gem_free(obj->dev, gem);
+
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static int tegra_gem_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct drm_gem_object *obj = vma->vm_private_data;
+	struct tegra_gem_object *gem = to_tegra_gem(obj);
+	pgoff_t page_offset;
+	struct page *page;
+	int ret;
+
+	if (!gem->pages)
+		return VM_FAULT_SIGBUS;
+
+	page_offset = ((unsigned long)vmf->virtual_address - vma->vm_start)
+		>> PAGE_SHIFT;
+	page = gem->pages[page_offset];
+
+	ret = vm_insert_page(vma, (unsigned long)vmf->virtual_address, page);
+
+	switch (ret) {
+	case -EAGAIN:
+		set_need_resched();
+		/* fallthrough */
+	case 0:
+	case -ERESTARTSYS:
+	case -EINTR:
+		return VM_FAULT_NOPAGE;
+
+	case -ENOMEM:
+		return VM_FAULT_OOM;
+	}
+
+	return VM_FAULT_SIGBUS;
+}
+
+struct vm_operations_struct tegra_gem_vm_ops = {
+	.fault = tegra_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
diff --git a/drivers/gpu/drm/tegra/tegra-hdmi.c b/drivers/gpu/drm/tegra/tegra-hdmi.c
new file mode 100644
index 0000000..8a70adb
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-hdmi.c
@@ -0,0 +1,994 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+#include <mach/clk.h>
+
+#include "tegra-hdmi.h"
+#include "tegra-drv.h"
+#include "tegra-dc.h"
+
+struct tegra_hdmi {
+	struct tegra_output base;
+	struct device *dev;
+
+	struct regulator *vdd;
+	struct regulator *pll;
+
+	void __iomem *regs;
+	unsigned int irq;
+	struct clk *clk;
+
+	unsigned int audio_source;
+	unsigned int audio_freq;
+	bool stereo;
+	bool dvi;
+};
+
+#define HDMI_AUDIOCLK_FREQ 216000000
+#define HDMI_REKEY_DEFAULT 56
+
+/* FIXME: get this from the display mode? */
+#define TEGRA_DC_MODE_FLAG_NEG_H_SYNC (1 << 0)
+#define TEGRA_DC_MODE_FLAG_NEG_V_SYNC (1 << 1)
+
+enum {
+	AUTO = 0,
+	SPDIF,
+	HDA,
+};
+
+static inline struct tegra_hdmi *to_hdmi(struct tegra_output *output)
+{
+	return container_of(output, struct tegra_hdmi, base);
+}
+
+static inline unsigned long tegra_hdmi_readl(struct tegra_hdmi *hdmi,
+					     unsigned long reg)
+{
+	return readl(hdmi->regs + (reg << 2));
+}
+
+static inline void tegra_hdmi_writel(struct tegra_hdmi *hdmi, unsigned long val,
+				     unsigned long reg)
+{
+	writel(val, hdmi->regs + (reg << 2));
+}
+
+struct tegra_hdmi_audio_config {
+	unsigned int pclk;
+	unsigned int n;
+	unsigned int cts;
+	unsigned int aval;
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_32k[] = {
+	{  25200000, 4096,  25200, 24000 },
+	{  27000000, 4096,  27000, 24000 },
+	{  74250000, 4096,  74250, 24000 },
+	{ 148500000, 4096, 148500, 24000 },
+	{         0,    0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_44_1k[] = {
+	{  25200000, 5880,  26250, 25000 },
+	{  27000000, 5880,  28125, 25000 },
+	{  74250000, 4704,  61875, 20000 },
+	{ 148500000, 4704, 123750, 20000 },
+	{         0,    0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_48k[] = {
+	{  25200000, 6144,  25200, 24000 },
+	{  27000000, 6144,  27000, 24000 },
+	{  74250000, 6144,  74250, 24000 },
+	{ 148500000, 6144, 148500, 24000 },
+	{         0,    0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_88_2k[] = {
+	{  25200000, 11760,  26250, 25000 },
+	{  27000000, 11760,  28125, 25000 },
+	{  74250000,  9408,  61875, 20000 },
+	{ 148500000,  9408, 123750, 20000 },
+	{         0,     0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_96k[] = {
+	{  25200000, 12288,  25200, 24000 },
+	{  27000000, 12288,  27000, 24000 },
+	{  74250000, 12288,  74250, 24000 },
+	{ 148500000, 12288, 148500, 24000 },
+	{         0,     0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_176_4k[] = {
+	{  25200000, 23520,  26250, 25000 },
+	{  27000000, 23520,  28125, 25000 },
+	{  74250000, 18816,  61875, 20000 },
+	{ 148500000, 18816, 123750, 20000 },
+	{         0,     0,      0,     0 },
+};
+
+static const struct tegra_hdmi_audio_config tegra_hdmi_audio_192k[] = {
+	{  25200000, 24576,  25200, 24000 },
+	{  27000000, 24576,  27000, 24000 },
+	{  74250000, 24576,  74250, 24000 },
+	{ 148500000, 24576, 148500, 24000 },
+	{         0,     0,      0,     0 },
+};
+
+struct tmds_config {
+	unsigned int pclk;
+	u32 pll0;
+	u32 pll1;
+	u32 pe_current;
+	u32 drive_current;
+};
+
+static const struct tmds_config tegra2_tmds_config[] = {
+	{ /* 480p modes */
+		.pclk = 27000000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(0) |
+			SOR_PLL_TX_REG_LOAD(3),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE,
+		.pe_current = PE_CURRENT0(PE_CURRENT_0_0_mA) |
+			PE_CURRENT1(PE_CURRENT_0_0_mA) |
+			PE_CURRENT2(PE_CURRENT_0_0_mA) |
+			PE_CURRENT3(PE_CURRENT_0_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_7_125_mA),
+	}, { /* 720p modes */
+		.pclk = 74250000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(1) |
+			SOR_PLL_TX_REG_LOAD(3),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_6_0_mA) |
+			PE_CURRENT1(PE_CURRENT_6_0_mA) |
+			PE_CURRENT2(PE_CURRENT_6_0_mA) |
+			PE_CURRENT3(PE_CURRENT_6_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_7_125_mA),
+	}, { /* 1080p modes */
+		.pclk = UINT_MAX,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(1) |
+			SOR_PLL_TX_REG_LOAD(3),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_6_0_mA) |
+			PE_CURRENT1(PE_CURRENT_6_0_mA) |
+			PE_CURRENT2(PE_CURRENT_6_0_mA) |
+			PE_CURRENT3(PE_CURRENT_6_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_7_125_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_7_125_mA),
+	},
+};
+
+static const struct tmds_config tegra3_tmds_config[] = {
+	{ /* 480p modes */
+		.pclk = 27000000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(0) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE,
+		.pe_current = PE_CURRENT0(PE_CURRENT_0_0_mA) |
+			PE_CURRENT1(PE_CURRENT_0_0_mA) |
+			PE_CURRENT2(PE_CURRENT_0_0_mA) |
+			PE_CURRENT3(PE_CURRENT_0_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	}, { /* 720p modes */
+		.pclk = 74250000,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(1) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_5_0_mA) |
+			PE_CURRENT1(PE_CURRENT_5_0_mA) |
+			PE_CURRENT2(PE_CURRENT_5_0_mA) |
+			PE_CURRENT3(PE_CURRENT_5_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	}, { /* 1080p modes */
+		.pclk = UINT_MAX,
+		.pll0 = SOR_PLL_BG_V17_S(3) | SOR_PLL_ICHPMP(1) |
+			SOR_PLL_RESISTORSEL | SOR_PLL_VCOCAP(3) |
+			SOR_PLL_TX_REG_LOAD(0),
+		.pll1 = SOR_PLL_TMDS_TERM_ENABLE | SOR_PLL_PE_EN,
+		.pe_current = PE_CURRENT0(PE_CURRENT_5_0_mA) |
+			PE_CURRENT1(PE_CURRENT_5_0_mA) |
+			PE_CURRENT2(PE_CURRENT_5_0_mA) |
+			PE_CURRENT3(PE_CURRENT_5_0_mA),
+		.drive_current = DRIVE_CURRENT_LANE0(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE1(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE2(DRIVE_CURRENT_5_250_mA) |
+			DRIVE_CURRENT_LANE3(DRIVE_CURRENT_5_250_mA),
+	},
+};
+
+static const struct tegra_hdmi_audio_config *tegra_hdmi_get_audio_config(
+							unsigned audio_freq,
+							unsigned pclk)
+{
+	const struct tegra_hdmi_audio_config *table;
+
+	switch (audio_freq) {
+	case 32000:
+		table = tegra_hdmi_audio_32k;
+		break;
+
+	case 44100:
+		table = tegra_hdmi_audio_44_1k;
+		break;
+
+	case 48000:
+		table = tegra_hdmi_audio_48k;
+		break;
+
+	case 88200:
+		table = tegra_hdmi_audio_88_2k;
+		break;
+
+	case 96000:
+		table = tegra_hdmi_audio_96k;
+		break;
+
+	case 176400:
+		table = tegra_hdmi_audio_176_4k;
+		break;
+
+	case 192000:
+		table = tegra_hdmi_audio_192k;
+		break;
+
+	default:
+		return NULL;
+	}
+
+	while (table->pclk) {
+		if (table->pclk == pclk)
+			return table;
+
+		table++;
+	}
+
+	return NULL;
+}
+
+static void tegra_hdmi_setup_audio_fs_tables(struct tegra_hdmi *hdmi)
+{
+	const unsigned int freqs[] = {
+		32000, 44100, 48000, 88200, 96000, 176400, 192000
+	};
+	unsigned int i;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p)\n", __func__, hdmi);
+
+	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
+		unsigned int f = freqs[i];
+		unsigned int eight_half;
+		unsigned long value;
+		unsigned int delta;
+
+		if (f > 96000)
+			delta = 2;
+		else if (f > 480000)
+			delta = 6;
+		else
+			delta = 9;
+
+		eight_half = (8 * HDMI_AUDIOCLK_FREQ) / (f * 128);
+		value = AUDIO_FS_LOW(eight_half - delta) |
+			AUDIO_FS_HIGH(eight_half + delta);
+		tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_AUDIO_FS(i));
+	}
+
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static int tegra_hdmi_setup_audio(struct tegra_hdmi *hdmi)
+{
+	struct device_node *node = hdmi->dev->of_node;
+	const struct tegra_hdmi_audio_config *config;
+	/* FIXME: hard-coded for 1080p */
+	unsigned int pclk = KHZ2PICOS(74250);
+	unsigned int offset = 0;
+	unsigned long value;
+	int err = 0;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p)\n", __func__, hdmi);
+
+	switch (hdmi->audio_source) {
+	case HDA:
+		value = AUDIO_CNTRL0_SOURCE_SELECT_HDAL;
+		break;
+
+	case SPDIF:
+		value = AUDIO_CNTRL0_SOURCE_SELECT_SPDIF;
+		break;
+
+	default:
+		value = AUDIO_CNTRL0_SOURCE_SELECT_AUTO;
+		break;
+	}
+
+	if (of_device_is_compatible(node, "nvidia,tegra30-hdmi")) {
+		value |= AUDIO_CNTRL0_ERROR_TOLERANCE(6) |
+			 AUDIO_CNTRL0_FRAMES_PER_BLOCK(0xc0);
+		tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_AUDIO_CNTRL0);
+	} else {
+		value |= AUDIO_CNTRL0_INJECT_NULLSMPL;
+		tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_AUDIO_CNTRL0);
+
+		value = AUDIO_CNTRL0_ERROR_TOLERANCE(6) |
+			AUDIO_CNTRL0_FRAMES_PER_BLOCK(0xc0);
+		tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_AUDIO_CNTRL0);
+	}
+
+	config = tegra_hdmi_get_audio_config(hdmi->audio_freq, pclk);
+	if (!config) {
+		dev_err(hdmi->dev, "cannot set audio to %u at %u pclk\n",
+			hdmi->audio_freq, pclk);
+		return -EINVAL;
+	}
+
+	tegra_hdmi_writel(hdmi, 0, HDMI_NV_PDISP_HDMI_ACR_CTRL);
+
+	value = AUDIO_N_RESETF | AUDIO_N_GENERATE_ALTERNATE |
+		AUDIO_N_VALUE(config->n - 1);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_AUDIO_N);
+
+	tegra_hdmi_writel(hdmi, ACR_SUBPACK_N(config->n) | ACR_ENABLE,
+			  HDMI_NV_PDISP_HDMI_ACR_0441_SUBPACK_HIGH);
+
+	value = ACR_SUBPACK_CTS(config->cts);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_ACR_0441_SUBPACK_LOW);
+
+	value = SPARE_HW_CTS | SPARE_FORCE_SW_CTS | SPARE_CTS_RESET_VAL(1);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_SPARE);
+
+	value = tegra_hdmi_readl(hdmi, HDMI_NV_PDISP_AUDIO_N);
+	value &= ~AUDIO_N_RESETF;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_AUDIO_N);
+
+	if (of_device_is_compatible(node, "nvidia,tegra30-hdmi")) {
+		switch (hdmi->audio_freq) {
+		case 32000:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_0320_0;
+			break;
+
+		case 44100:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_0441_0;
+			break;
+
+		case 48000:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_0480_0;
+			break;
+
+		case 88200:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_0882_0;
+			break;
+
+		case 96000:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_0960_0;
+			break;
+
+		case 176400:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_1764_0;
+			break;
+
+		case 192000:
+			offset = HDMI_NV_PDISP_SOR_AUDIO_AVAL_1920_0;
+			break;
+		}
+
+		tegra_hdmi_writel(hdmi, config->aval, offset);
+	}
+
+	tegra_hdmi_setup_audio_fs_tables(hdmi);
+
+	dev_dbg(hdmi->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static void tegra_hdmi_write_infopack(struct tegra_hdmi *hdmi,
+				      unsigned int offset, u8 type,
+				      u8 version, void *data, size_t size)
+{
+	unsigned long value;
+	u8 *ptr = data;
+	u32 subpack[2];
+	size_t i;
+	u8 csum;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p, offset=%x, type=%02x, version=%02x, data=%p, size=%zu)\n",
+		__func__, hdmi, offset, type, version, data, size);
+
+	/* first byte of data is the checksum */
+	csum = type + version + size - 1;
+
+	for (i = 1; i < size; i++)
+		csum += ptr[i];
+
+	ptr[0] = 0x100 - csum;
+
+	value = INFOFRAME_HEADER_TYPE(type) |
+		INFOFRAME_HEADER_VERSION(version) |
+		INFOFRAME_HEADER_LEN(size - 1);
+	tegra_hdmi_writel(hdmi, value, offset);
+
+	/* The audio inforame only has one set of subpack registers.  The hdmi
+	 * block pads the rest of the data as per the spec so we have to fixup
+	 * the length before filling in the subpacks.
+	 */
+	if (offset == HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_HEADER)
+		size = 6;
+
+	/* each subpack 7 bytes devided into:
+	 *   subpack_low - bytes 0 - 3
+	 *   subpack_high - bytes 4 - 6 (with byte 7 padded to 0x00)
+	 */
+	for (i = 0; i < size; i++) {
+		size_t index = i % 7;
+
+		if (index == 0)
+			memset(subpack, 0x0, sizeof(subpack));
+
+		((u8 *)subpack)[index] = ptr[i];
+
+		if (index == 6 || (i + 1 == size)) {
+			unsigned int reg = offset + 1 + (i / 7) * 2;
+
+			tegra_hdmi_writel(hdmi, subpack[0], reg);
+			tegra_hdmi_writel(hdmi, subpack[1], reg + 1);
+		}
+	}
+
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static void tegra_hdmi_setup_avi_infoframe(struct tegra_hdmi *hdmi)
+{
+	struct hdmi_avi_infoframe frame;
+
+	/* FIXME: hard-coded for 1080p */
+	unsigned int h_front_porch = 88;
+	unsigned int hactive = 1920;
+	unsigned int vactive = 1080;
+	unsigned int hsize = 16;
+	unsigned int vsize = 9;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p)\n", __func__, hdmi);
+
+	if (hdmi->dvi) {
+		tegra_hdmi_writel(hdmi, 0,
+				  HDMI_NV_PDISP_HDMI_AVI_INFOFRAME_CTRL);
+		goto out;
+	}
+
+	memset(&frame, 0, sizeof(frame));
+	frame.r = HDMI_AVI_R_SAME;
+
+	switch (vactive) {
+	case 480:
+		if (hactive == 640) {
+			frame.m = HDMI_AVI_M_4_3;
+			frame.vic = 1;
+		} else {
+			frame.m = HDMI_AVI_M_16_9;
+			frame.vic = 3;
+		}
+		break;
+
+	case 576:
+		if (((hsize * 10) / vsize) > 14) {
+			frame.m = HDMI_AVI_M_16_9;
+			frame.vic = 18;
+		} else {
+			frame.m = HDMI_AVI_M_4_3;
+			frame.vic = 17;
+		}
+		break;
+
+	case 720:
+	case 1470: /* stereo mode */
+		frame.m = HDMI_AVI_M_16_9;
+
+		if (h_front_porch == 110)
+			frame.vic = 4;
+		else
+			frame.vic = 19;
+		break;
+
+	case 1080:
+	case 2205: /* stereo mode */
+		frame.m = HDMI_AVI_M_16_9;
+
+		switch (h_front_porch) {
+		case 88:
+			frame.vic = 16;
+			break;
+
+		case 528:
+			frame.vic = 31;
+			break;
+
+		default:
+			frame.vic = 32;
+			break;
+		}
+		break;
+
+	default:
+		frame.m = HDMI_AVI_M_16_9;
+		frame.vic = 0;
+		break;
+	}
+
+	tegra_hdmi_write_infopack(hdmi, HDMI_NV_PDISP_HDMI_AVI_INFOFRAME_HEADER,
+				  HDMI_INFOFRAME_TYPE_AVI, HDMI_AVI_VERSION,
+				  &frame, sizeof(frame));
+
+	tegra_hdmi_writel(hdmi, INFOFRAME_CTRL_ENABLE,
+			  HDMI_NV_PDISP_HDMI_AVI_INFOFRAME_CTRL);
+
+out:
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static void tegra_hdmi_setup_audio_infoframe(struct tegra_hdmi *hdmi)
+{
+	struct hdmi_audio_infoframe frame;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p)\n", __func__, hdmi);
+
+	if (hdmi->dvi) {
+		tegra_hdmi_writel(hdmi, 0,
+				  HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_CTRL);
+		goto out;
+	}
+
+	memset(&frame, 0, sizeof(frame));
+	frame.cc = HDMI_AUDIO_CC_2;
+
+	tegra_hdmi_write_infopack(hdmi,
+				  HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_HEADER,
+				  HDMI_INFOFRAME_TYPE_AUDIO,
+				  HDMI_AUDIO_VERSION,
+				  &frame, sizeof(frame));
+
+	tegra_hdmi_writel(hdmi, INFOFRAME_CTRL_ENABLE,
+			  HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_CTRL);
+
+out:
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static void tegra_hdmi_setup_stereo_infoframe(struct tegra_hdmi *hdmi)
+{
+	struct hdmi_stereo_infoframe frame;
+	unsigned long value;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p)\n", __func__, hdmi);
+
+	if (!hdmi->stereo) {
+		value = tegra_hdmi_readl(hdmi, HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+		value &= ~GENERIC_CTRL_ENABLE;
+		tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+		goto out;
+	}
+
+	memset(&frame, 0, sizeof(frame));
+	frame.regid0 = 0x03;
+	frame.regid1 = 0x0c;
+	frame.regid2 = 0x00;
+	frame.hdmi_video_format = 2;
+
+	/* TODO: 74 MHz limit? */
+	if (1) {
+		frame._3d_structure = 0;
+	} else {
+		frame._3d_structure = 8;
+		frame._3d_ext_data = 0;
+	}
+
+	tegra_hdmi_write_infopack(hdmi, HDMI_NV_PDISP_HDMI_GENERIC_HEADER,
+				  HDMI_INFOFRAME_TYPE_VENDOR,
+				  HDMI_VENDOR_VERSION, &frame, 6);
+
+	value = tegra_hdmi_readl(hdmi, HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+	value |= GENERIC_CTRL_ENABLE;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+
+out:
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static void tegra_hdmi_setup_tmds(struct tegra_hdmi *hdmi,
+				  const struct tmds_config *tmds)
+{
+	unsigned long value;
+
+	dev_dbg(hdmi->dev, "> %s(hdmi=%p, tmds=%p)\n", __func__, hdmi, tmds);
+
+	tegra_hdmi_writel(hdmi, tmds->pll0, HDMI_NV_PDISP_SOR_PLL0);
+	tegra_hdmi_writel(hdmi, tmds->pll1, HDMI_NV_PDISP_SOR_PLL1);
+	tegra_hdmi_writel(hdmi, tmds->pe_current, HDMI_NV_PDISP_PE_CURRENT);
+
+	value = tmds->drive_current | DRIVE_CURRENT_FUSE_OVERRIDE;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_LANE_DRIVE_CURRENT);
+
+	dev_dbg(hdmi->dev, "< %s()\n", __func__);
+}
+
+static int tegra_output_hdmi_enable(struct tegra_output *output)
+{
+	struct tegra_hdmi *hdmi = to_hdmi(output);
+	struct device_node *node = hdmi->dev->of_node;
+	struct tegra_crtc *crtc = output->crtc;
+	const struct tmds_config *tmds;
+	unsigned int num_tmds;
+	/* FIXME: hard-coded for 1080p */
+	unsigned int pclk = KHZ2PICOS(74250);
+	unsigned int h_back_porch = 138;
+	unsigned int h_front_porch = 88;
+	unsigned int h_sync_width = 44;
+	unsigned int h_ref_to_sync = 0;
+	unsigned int pulse_start;
+	unsigned long flags = 0;
+	unsigned long value;
+	int retries = 1000;
+	unsigned int div82;
+	unsigned int rekey;
+	unsigned int i;
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	err = regulator_enable(hdmi->vdd);
+	if (err < 0)
+		goto out;
+
+	err = regulator_enable(hdmi->pll);
+	if (err < 0)
+		goto out;
+
+	err = clk_prepare_enable(hdmi->clk);
+	if (err < 0)
+		goto out;
+
+	tegra_periph_reset_assert(hdmi->clk);
+	usleep_range(1000, 1000);
+	tegra_periph_reset_deassert(hdmi->clk);
+
+	tegra_crtc_writel(crtc, VSYNC_H_POSITION(1),
+			  DC_DISP_DISP_TIMING_OPTIONS);
+	tegra_crtc_writel(crtc, DITHER_CONTROL_DISABLE | BASE_COLOR_SIZE888,
+			  DC_DISP_DISP_COLOR_CONTROL);
+
+	/* video_preamble uses h_pulse2 */
+	pulse_start = h_ref_to_sync + h_sync_width + h_back_porch - 10;
+
+	tegra_crtc_writel(crtc, H_PULSE_2_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
+
+	value = PULSE_MODE_NORMAL | PULSE_POLARITY_HIGH | PULSE_QUAL_VACTIVE |
+		PULSE_LAST_END_A;
+	tegra_crtc_writel(crtc, value, DC_DISP_H_PULSE2_CONTROL);
+
+	value = PULSE_START(pulse_start) | PULSE_END(pulse_start + 8);
+	tegra_crtc_writel(crtc, value, DC_DISP_H_PULSE2_POSITION_A);
+
+	value = VSYNC_WINDOW_END(0x210) | VSYNC_WINDOW_START(0x200) |
+		VSYNC_WINDOW_ENABLE;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_VSYNC_WINDOW);
+
+	value = (crtc->pipe ? HDMI_SRC_DISPLAYB : HDMI_SRC_DISPLAYA) |
+		ARM_VIDEO_RANGE_LIMITED;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_INPUT_CONTROL);
+
+	div82 = clk_get_rate(hdmi->clk) / 1000000 * 4;
+	value = SOR_REFCLK_DIV_INT(div82 >> 2) | SOR_REFCLK_DIV_FRAC(div82);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_REFCLK);
+
+	if (!hdmi->dvi) {
+		err = tegra_hdmi_setup_audio(hdmi);
+		if (err < 0)
+			hdmi->dvi = true;
+	}
+
+	if (of_device_is_compatible(node, "nvidia,tegra20-hdmi")) {
+		/*
+		 * TODO: add ELD support
+		 */
+	}
+
+	rekey = HDMI_REKEY_DEFAULT;
+	value = HDMI_CTRL_REKEY(rekey);
+	value |= HDMI_CTRL_MAX_AC_PACKET((h_sync_width + h_back_porch +
+					  h_front_porch - rekey - 18) / 32);
+
+	if (!hdmi->dvi)
+		value |= HDMI_CTRL_ENABLE;
+
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_HDMI_CTRL);
+
+	if (hdmi->dvi)
+		tegra_hdmi_writel(hdmi, 0x0,
+				  HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+	else
+		tegra_hdmi_writel(hdmi, GENERIC_CTRL_AUDIO,
+				  HDMI_NV_PDISP_HDMI_GENERIC_CTRL);
+
+	tegra_hdmi_setup_avi_infoframe(hdmi);
+	tegra_hdmi_setup_audio_infoframe(hdmi);
+	tegra_hdmi_setup_stereo_infoframe(hdmi);
+
+	/* TMDS CONFIG */
+	if (of_device_is_compatible(node, "nvidia,tegra30-hdmi")) {
+		num_tmds = ARRAY_SIZE(tegra3_tmds_config);
+		tmds = tegra3_tmds_config;
+	} else {
+		num_tmds = ARRAY_SIZE(tegra2_tmds_config);
+		tmds = tegra2_tmds_config;
+	}
+
+	for (i = 0; i < num_tmds; i++) {
+		if (pclk <= tmds[i].pclk) {
+			tegra_hdmi_setup_tmds(hdmi, &tmds[i]);
+			break;
+		}
+	}
+
+	tegra_hdmi_writel(hdmi,
+			  SOR_SEQ_CTL_PU_PC(0) |
+			  SOR_SEQ_PU_PC_ALT(0) |
+			  SOR_SEQ_PD_PC(8) |
+			  SOR_SEQ_PD_PC_ALT(8),
+			  HDMI_NV_PDISP_SOR_SEQ_CTL);
+
+	value = SOR_SEQ_INST_WAIT_TIME(1) |
+		SOR_SEQ_INST_WAIT_UNITS_VSYNC |
+		SOR_SEQ_INST_HALT |
+		SOR_SEQ_INST_PIN_A_LOW |
+		SOR_SEQ_INST_PIN_B_LOW |
+		SOR_SEQ_INST_DRIVE_PWM_OUT_LO;
+
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_SEQ_INST0);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_SEQ_INST8);
+
+	value = 0x1c800;
+	value &= ~SOR_CSTM_ROTCLK(~0);
+	value |= SOR_CSTM_ROTCLK(2);
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_CSTM);
+
+	tegra_crtc_writel(crtc, DISP_CTRL_MODE_STOP, DC_CMD_DISPLAY_COMMAND);
+	tegra_crtc_writel(crtc, GENERAL_ACT_REQ << 8, DC_CMD_STATE_CONTROL);
+	tegra_crtc_writel(crtc, GENERAL_ACT_REQ, DC_CMD_STATE_CONTROL);
+
+	/* start SOR */
+	tegra_hdmi_writel(hdmi,
+			  SOR_PWR_NORMAL_STATE_PU |
+			  SOR_PWR_NORMAL_START_NORMAL |
+			  SOR_PWR_SAFE_STATE_PD |
+			  SOR_PWR_SETTING_NEW_TRIGGER,
+			  HDMI_NV_PDISP_SOR_PWR);
+	tegra_hdmi_writel(hdmi,
+			  SOR_PWR_NORMAL_STATE_PU |
+			  SOR_PWR_NORMAL_START_NORMAL |
+			  SOR_PWR_SAFE_STATE_PD |
+			  SOR_PWR_SETTING_NEW_DONE,
+			  HDMI_NV_PDISP_SOR_PWR);
+
+	do {
+		BUG_ON(--retries < 0);
+		value = tegra_hdmi_readl(hdmi, HDMI_NV_PDISP_SOR_PWR);
+	} while (value & SOR_PWR_SETTING_NEW_PENDING);
+
+	value = SOR_STATE_ASY_CRCMODE_COMPLETE |
+		SOR_STATE_ASY_OWNER_HEAD0 |
+		SOR_STATE_ASY_SUBOWNER_BOTH |
+		SOR_STATE_ASY_PROTOCOL_SINGLE_TMDS_A |
+		SOR_STATE_ASY_DEPOL_POS;
+
+	if (flags & TEGRA_DC_MODE_FLAG_NEG_H_SYNC)
+		value |= SOR_STATE_ASY_HSYNCPOL_NEG;
+	else
+		value |= SOR_STATE_ASY_HSYNCPOL_POS;
+
+	if (flags & TEGRA_DC_MODE_FLAG_NEG_V_SYNC)
+		value |= SOR_STATE_ASY_VSYNCPOL_NEG;
+	else
+		value |= SOR_STATE_ASY_VSYNCPOL_POS;
+
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_STATE2);
+
+	value = SOR_STATE_ASY_HEAD_OPMODE_AWAKE | SOR_STATE_ASY_ORMODE_NORMAL;
+	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_SOR_STATE1);
+
+	tegra_hdmi_writel(hdmi, 0, HDMI_NV_PDISP_SOR_STATE0);
+	tegra_hdmi_writel(hdmi, SOR_STATE_UPDATE, HDMI_NV_PDISP_SOR_STATE0);
+	tegra_hdmi_writel(hdmi, value | SOR_STATE_ATTACHED,
+			  HDMI_NV_PDISP_SOR_STATE1);
+	tegra_hdmi_writel(hdmi, 0, HDMI_NV_PDISP_SOR_STATE0);
+
+	tegra_crtc_writel(crtc, HDMI_ENABLE, DC_DISP_DISP_WIN_OPTIONS);
+
+	value = PW0_ENABLE | PW1_ENABLE | PW2_ENABLE | PW3_ENABLE |
+		PW4_ENABLE | PM0_ENABLE | PM1_ENABLE;
+	tegra_crtc_writel(crtc, value, DC_CMD_DISPLAY_POWER_CONTROL);
+
+	value = DISP_CTRL_MODE_C_DISPLAY;
+	tegra_crtc_writel(crtc, value, DC_CMD_DISPLAY_COMMAND);
+
+	tegra_crtc_writel(crtc, GENERAL_ACT_REQ << 8, DC_CMD_STATE_CONTROL);
+	tegra_crtc_writel(crtc, GENERAL_ACT_REQ, DC_CMD_STATE_CONTROL);
+
+	/* TODO: add HDCP support */
+
+	err = 0;
+
+out:
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_output_hdmi_disable(struct tegra_output *output)
+{
+	struct tegra_hdmi *hdmi = to_hdmi(output);
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	tegra_periph_reset_assert(hdmi->clk);
+	clk_disable_unprepare(hdmi->clk);
+	regulator_disable(hdmi->pll);
+	regulator_disable(hdmi->vdd);
+
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static const struct tegra_output_ops hdmi_ops = {
+	.enable = tegra_output_hdmi_enable,
+	.disable = tegra_output_hdmi_disable,
+};
+
+static int __devinit tegra_hdmi_probe(struct platform_device *pdev)
+{
+	struct tegra_hdmi *hdmi;
+	struct resource *regs;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	hdmi->dev = &pdev->dev;
+	hdmi->audio_source = AUTO;
+	hdmi->audio_freq = 44100;
+	hdmi->stereo = false;
+	hdmi->dvi = false;
+
+	hdmi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(hdmi->clk)) {
+		err = PTR_ERR(hdmi->clk);
+		dev_err(&pdev->dev, "failed to get clock: %d\n", err);
+		goto out;
+	}
+
+	hdmi->vdd = regulator_get(&pdev->dev, "vdd");
+	if (IS_ERR_OR_NULL(hdmi->vdd)) {
+		err = PTR_ERR(hdmi->vdd);
+		dev_err(&pdev->dev, "failed to get VDD regulator: %d\n", err);
+		goto put_clk;
+	}
+
+	hdmi->pll = regulator_get(&pdev->dev, "pll");
+	if (IS_ERR_OR_NULL(hdmi->pll)) {
+		err = PTR_ERR(hdmi->pll);
+		dev_err(&pdev->dev, "failed to get PLL regulator: %d\n", err);
+		goto put_vdd;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		err = -ENXIO;
+		goto put_pll;
+	}
+
+	hdmi->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!hdmi->regs) {
+		err = -EADDRNOTAVAIL;
+		goto put_pll;
+	}
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0)
+		goto put_pll;
+
+	hdmi->irq = err;
+
+	hdmi->base.type = TEGRA_DRM_OUTPUT_HDMI;
+	hdmi->base.dev = &pdev->dev;
+	hdmi->base.ops = &hdmi_ops;
+
+	err = tegra_drm_output_add(&hdmi->base);
+	if (err < 0)
+		goto put_pll;
+
+	platform_set_drvdata(pdev, hdmi);
+	goto out;
+
+put_pll:
+	regulator_put(hdmi->pll);
+put_vdd:
+	regulator_put(hdmi->vdd);
+put_clk:
+	clk_put(hdmi->clk);
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_hdmi_remove(struct platform_device *pdev)
+{
+	struct tegra_hdmi *hdmi = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = tegra_drm_output_del(&hdmi->base);
+	if (err < 0)
+		goto out;
+
+	regulator_put(hdmi->vdd);
+	regulator_put(hdmi->pll);
+	clk_put(hdmi->clk);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_hdmi_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-hdmi", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_hdmi_driver = {
+	.driver = {
+		.name = "tegra-hdmi",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_hdmi_of_match),
+	},
+	.probe = tegra_hdmi_probe,
+	.remove = __devexit_p(tegra_hdmi_remove),
+};
diff --git a/drivers/gpu/drm/tegra/tegra-hdmi.h b/drivers/gpu/drm/tegra/tegra-hdmi.h
new file mode 100644
index 0000000..1b89ba3
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-hdmi.h
@@ -0,0 +1,462 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef TEGRA_HDMI_H
+#define TEGRA_HDMI_H 1
+
+#define HDMI_INFOFRAME_TYPE_VENDOR   0x81
+#define HDMI_INFOFRAME_TYPE_AVI      0x82
+#define HDMI_INFOFRAME_TYPE_SPD      0x83
+#define HDMI_INFOFRAME_TYPE_AUDIO    0x84
+#define HDMI_INFOFRAME_TYPE_MPEG_SRC 0x85
+#define HDMI_INFOFRAME_TYPE_NTSC_VBI 0x86
+
+/* all fields little endian */
+struct hdmi_avi_infoframe {
+	/* PB0 */
+	u8 csum;
+
+	/* PB1 */
+	unsigned s:2; /* scan information */
+	unsigned b:2; /* bar info data valid */
+	unsigned a:1; /* active info present */
+	unsigned y:2; /* RGB or YCbCr */
+	unsigned res1:1;
+
+	/* PB2 */
+	unsigned r:4; /* active format aspect ratio */
+	unsigned m:2; /* picture aspect ratio */
+	unsigned c:2; /* colorimetry */
+
+	/* PB3 */
+	unsigned sc:2;  /* scan information */
+	unsigned q:2;   /* quantization range */
+	unsigned ec:3;  /* extended colorimetry */
+	unsigned itc:1; /* it content */
+
+	/* PB4 */
+	unsigned vic:7; /* video format id code */
+	unsigned res4:1;
+
+	/* PB5 */
+	unsigned pr:4; /* pixel repetition factor */
+	unsigned cn:2; /* it content type*/
+	unsigned yq:2; /* ycc quantization range */
+
+	/* PB6-7 */
+	u16 top_bar_end_line;
+
+	/* PB8-9 */
+	u16 bot_bar_start_line;
+
+	/* PB10-11 */
+	u16 left_bar_end_pixel;
+
+	/* PB12-13 */
+	u16 right_bar_start_pixel;
+} __packed;
+
+#define HDMI_AVI_VERSION 0x02
+
+#define HDMI_AVI_Y_RGB       0x0
+#define HDMI_AVI_Y_YCBCR_422 0x1
+#define HDMI_AVI_Y_YCBCR_444 0x2
+
+#define HDMI_AVI_B_VERT  0x1
+#define HDMI_AVI_B_HORIZ 0x2
+
+#define HDMI_AVI_S_NONE      0x0
+#define HDMI_AVI_S_OVERSCAN  0x1
+#define HDMI_AVI_S_UNDERSCAN 0x2
+
+#define HDMI_AVI_C_NONE     0x0
+#define HDMI_AVI_C_SMPTE    0x1
+#define HDMI_AVI_C_ITU_R    0x2
+#define HDMI_AVI_C_EXTENDED 0x4
+
+#define HDMI_AVI_M_4_3  0x1
+#define HDMI_AVI_M_16_9 0x2
+
+#define HDMI_AVI_R_SAME        0x8
+#define HDMI_AVI_R_4_3_CENTER  0x9
+#define HDMI_AVI_R_16_9_CENTER 0xa
+#define HDMI_AVI_R_14_9_CENTER 0xb
+
+/* all fields little endian */
+struct hdmi_audio_infoframe {
+	/* PB0 */
+	u8 csum;
+
+	/* PB1 */
+	unsigned cc:3; /* channel count */
+	unsigned res1:1;
+	unsigned ct:4; /* coding type */
+
+	/* PB2 */
+	unsigned ss:2; /* sample size */
+	unsigned sf:3; /* sample frequency */
+	unsigned res2:3;
+
+	/* PB3 */
+	unsigned cxt:5; /* coding extention type */
+	unsigned res3:3;
+
+	/* PB4 */
+	u8 ca; /* channel/speaker allocation */
+
+	/* PB5 */
+	unsigned res5:3;
+	unsigned lsv:4; /* level shift value */
+	unsigned dm_inh:1; /* downmix inhibit */
+
+	/* PB6-10 reserved */
+	u8 res6;
+	u8 res7;
+	u8 res8;
+	u8 res9;
+	u8 res10;
+} __packed;
+
+#define HDMI_AUDIO_VERSION 0x01
+
+#define HDMI_AUDIO_CC_STREAM 0x0 /* specified by audio stream */
+#define HDMI_AUDIO_CC_2      0x1
+#define HDMI_AUDIO_CC_3      0x2
+#define HDMI_AUDIO_CC_4      0x3
+#define HDMI_AUDIO_CC_5      0x4
+#define HDMI_AUDIO_CC_6      0x5
+#define HDMI_AUDIO_CC_7      0x6
+#define HDMI_AUDIO_CC_8      0x7
+
+#define HDMI_AUDIO_CT_STREAM  0x0 /* specified by audio stream */
+#define HDMI_AUDIO_CT_PCM     0x1
+#define HDMI_AUDIO_CT_AC3     0x2
+#define HDMI_AUDIO_CT_MPEG1   0x3
+#define HDMI_AUDIO_CT_MP3     0x4
+#define HDMI_AUDIO_CT_MPEG2   0x5
+#define HDMI_AUDIO_CT_AAC_LC  0x6
+#define HDMI_AUDIO_CT_DTS     0x7
+#define HDMI_AUDIO_CT_ATRAC   0x8
+#define HDMI_AUDIO_CT_DSD     0x9
+#define HDMI_AUDIO_CT_E_AC3   0xa
+#define HDMI_AUDIO_CT_DTS_HD  0xb
+#define HDMI_AUDIO_CT_MLP     0xc
+#define HDMI_AUDIO_CT_DST     0xd
+#define HDMI_AUDIO_CT_WMA_PRO 0xe
+#define HDMI_AUDIO_CT_CXT     0xf
+
+#define HDMI_AUDIO_SF_STREAM 0x0 /* specified by audio stream */
+#define HDMI_AUIDO_SF_32K    0x1
+#define HDMI_AUDIO_SF_44_1K  0x2
+#define HDMI_AUDIO_SF_48K    0x3
+#define HDMI_AUDIO_SF_88_2K  0x4
+#define HDMI_AUDIO_SF_96K    0x5
+#define HDMI_AUDIO_SF_176_4K 0x6
+#define HDMI_AUDIO_SF_192K   0x7
+
+#define HDMI_AUDIO_SS_STREAM 0x0 /* specified by audio stream */
+#define HDMI_AUDIO_SS_16BIT  0x1
+#define HDMI_AUDIO_SS_20BIT  0x2
+#define HDMI_AUDIO_SS_24BIT  0x3
+
+#define HDMI_AUDIO_CXT_CT            0x0 /* refer to coding in CT */
+#define HDMI_AUDIO_CXT_HE_AAC        0x1
+#define HDMI_AUDIO_CXT_HE_AAC_V2     0x2
+#define HDMI_AUDIO_CXT_MPEG_SURROUND 0x3
+
+/* all fields little endian */
+struct hdmi_stereo_infoframe {
+	/* PB0 */
+	u8 csum;
+
+	/* PB1 */
+	u8 regid0;
+
+	/* PB2 */
+	u8 regid1;
+
+	/* PB3 */
+	u8 regid2;
+
+	/* PB4 */
+	unsigned res1:5;
+	unsigned hdmi_video_format:3;
+
+	/* PB5 */
+	unsigned res2:4;
+	unsigned _3d_structure:4;
+
+	/* PB6*/
+	unsigned res3:4;
+	unsigned _3d_ext_data:4;
+} __packed;
+
+#define HDMI_VENDOR_VERSION 0x01
+
+/* register definitions */
+#define HDMI_CTXSW 0x00
+
+#define HDMI_NV_PDISP_SOR_STATE0 0x01
+#define SOR_STATE_UPDATE (1 << 0)
+
+#define HDMI_NV_PDISP_SOR_STATE1 0x02
+#define SOR_STATE_ASY_HEAD_OPMODE_AWAKE (2 << 0)
+#define SOR_STATE_ASY_ORMODE_NORMAL     (1 << 2)
+#define SOR_STATE_ATTACHED              (1 << 3)
+
+#define HDMI_NV_PDISP_SOR_STATE2 0x03
+#define SOR_STATE_ASY_OWNER_NONE         (0 <<  0)
+#define SOR_STATE_ASY_OWNER_HEAD0        (1 <<  1)
+#define SOR_STATE_ASY_SUBOWNER_NONE      (0 <<  4)
+#define SOR_STATE_ASY_SUBOWNER_SUBHEAD0  (1 <<  4)
+#define SOR_STATE_ASY_SUBOWNER_SUBHEAD1  (2 <<  4)
+#define SOR_STATE_ASY_SUBOWNER_BOTH      (3 <<  4)
+#define SOR_STATE_ASY_CRCMODE_ACTIVE     (0 <<  6)
+#define SOR_STATE_ASY_CRCMODE_COMPLETE   (1 <<  6)
+#define SOR_STATE_ASY_CRCMODE_NON_ACTIVE (2 <<  6)
+#define SOR_STATE_ASY_PROTOCOL_SINGLE_TMDS_A (1 << 8)
+#define SOR_STATE_ASY_PROTOCOL_CUSTOM        (15 << 8)
+#define SOR_STATE_ASY_HSYNCPOL_POS       (0 << 12)
+#define SOR_STATE_ASY_HSYNCPOL_NEG       (1 << 12)
+#define SOR_STATE_ASY_VSYNCPOL_POS       (0 << 13)
+#define SOR_STATE_ASY_VSYNCPOL_NEG       (1 << 13)
+#define SOR_STATE_ASY_DEPOL_POS          (0 << 14)
+#define SOR_STATE_ASY_DEPOL_NEG          (1 << 14)
+
+#define HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_CTRL 0x1e
+#define HDMI_NV_PDISP_HDMI_AUDIO_INFOFRAME_HEADER 0x20
+#define HDMI_NV_PDISP_HDMI_AVI_INFOFRAME_CTRL 0x23
+#define HDMI_NV_PDISP_HDMI_AVI_INFOFRAME_HEADER 0x25
+
+#define INFOFRAME_CTRL_ENABLE (1 << 0)
+
+#define INFOFRAME_HEADER_TYPE(x)    (((x) & 0xff) <<  0)
+#define INFOFRAME_HEADER_VERSION(x) (((x) & 0xff) <<  8)
+#define INFOFRAME_HEADER_LEN(x)     (((x) & 0x0f) << 16)
+
+#define HDMI_NV_PDISP_HDMI_GENERIC_CTRL 0x2a
+#define GENERIC_CTRL_ENABLE (1 <<  0)
+#define GENERIC_CTRL_OTHER  (1 <<  4)
+#define GENERIC_CTRL_SINGLE (1 <<  8)
+#define GENERIC_CTRL_HBLANK (1 << 12)
+#define GENERIC_CTRL_AUDIO  (1 << 16)
+
+#define HDMI_NV_PDISP_HDMI_GENERIC_HEADER 0x2c
+
+#define HDMI_NV_PDISP_HDMI_ACR_CTRL 0x35
+#define HDMI_NV_PDISP_HDMI_ACR_0441_SUBPACK_LOW 0x38
+#define HDMI_NV_PDISP_HDMI_ACR_0441_SUBPACK_HIGH 0x39
+
+#define ACR_SUBPACK_CTS(x) (((x) & 0xffffff) << 8)
+#define ACR_SUBPACK_N(x)   (((x) & 0xffffff) << 0)
+#define ACR_ENABLE         (1 << 31)
+
+#define HDMI_NV_PDISP_HDMI_CTRL 0x44
+#define HDMI_CTRL_REKEY(x)         (((x) & 0x7f) <<  0)
+#define HDMI_CTRL_MAX_AC_PACKET(x) (((x) & 0x1f) << 16)
+#define HDMI_CTRL_ENABLE           (1 << 30)
+
+#define HDMI_NV_PDISP_HDMI_VSYNC_WINDOW 0x46
+#define VSYNC_WINDOW_END(x)   (((x) & 0x3ff) <<  0)
+#define VSYNC_WINDOW_START(x) (((x) & 0x3ff) << 16)
+#define VSYNC_WINDOW_ENABLE   (1 << 31)
+
+#define HDMI_NV_PDISP_HDMI_SPARE 0x4f
+#define SPARE_HW_CTS           (1 << 0)
+#define SPARE_FORCE_SW_CTS     (1 << 1)
+#define SPARE_CTS_RESET_VAL(x) (((x) & 0x7) << 16)
+
+#define HDMI_NV_PDISP_SOR_PWR 0x55
+#define SOR_PWR_NORMAL_STATE_PD     (0 <<  0)
+#define SOR_PWR_NORMAL_STATE_PU     (1 <<  0)
+#define SOR_PWR_NORMAL_START_NORMAL (0 <<  1)
+#define SOR_PWR_NORMAL_START_ALT    (1 <<  1)
+#define SOR_PWR_SAFE_STATE_PD       (0 << 16)
+#define SOR_PWR_SAFE_STATE_PU       (1 << 16)
+#define SOR_PWR_SETTING_NEW_DONE    (0 << 31)
+#define SOR_PWR_SETTING_NEW_PENDING (1 << 31)
+#define SOR_PWR_SETTING_NEW_TRIGGER (1 << 31)
+
+#define HDMI_NV_PDISP_SOR_PLL0 0x57
+#define SOR_PLL_PWR            (1 << 0)
+#define SOR_PLL_PDBG           (1 << 1)
+#define SOR_PLL_VCAPD          (1 << 2)
+#define SOR_PLL_PDPORT         (1 << 3)
+#define SOR_PLL_RESISTORSEL    (1 << 4)
+#define SOR_PLL_PULLDOWN       (1 << 5)
+#define SOR_PLL_VCOCAP(x)      (((x) & 0xf) <<  8)
+#define SOR_PLL_BG_V17_S(x)    (((x) & 0xf) << 12)
+#define SOR_PLL_FILTER(x)      (((x) & 0xf) << 16)
+#define SOR_PLL_ICHPMP(x)      (((x) & 0xf) << 24)
+#define SOR_PLL_TX_REG_LOAD(x) (((x) & 0xf) << 28)
+
+#define HDMI_NV_PDISP_SOR_PLL1 0x58
+#define SOR_PLL_TMDS_TERM_ENABLE (1 << 8)
+#define SOR_PLL_TMDS_TERMADJ(x)  (((x) & 0xf) <<  9)
+#define SOR_PLL_LOADADJ(x)       (((x) & 0xf) << 20)
+#define SOR_PLL_PE_EN            (1 << 28)
+#define SOR_PLL_HALF_FULL_PE     (1 << 29)
+#define SOR_PLL_S_D_PIN_PE       (1 << 30)
+
+#define HDMI_NV_PDISP_SOR_CSTM 0x5a
+#define SOR_CSTM_ROTCLK(x) (((x) & 0xf) << 24)
+
+#define HDMI_NV_PDISP_SOR_SEQ_CTL 0x5f
+#define SOR_SEQ_CTL_PU_PC(x) (((x) & 0xf) <<  0)
+#define SOR_SEQ_PU_PC_ALT(x) (((x) & 0xf) <<  4)
+#define SOR_SEQ_PD_PC(x)     (((x) & 0xf) <<  8)
+#define SOR_SEQ_PD_PC_ALT(x) (((x) & 0xf) << 12)
+#define SOR_SEQ_PC(x)        (((x) & 0xf) << 16)
+#define SOR_SEQ_STATUS       (1 << 28)
+#define SOR_SEQ_SWITCH       (1 << 30)
+
+#define HDMI_NV_PDISP_SOR_SEQ_INST0 0x60
+#define HDMI_NV_PDISP_SOR_SEQ_INST8 0x68
+
+#define SOR_SEQ_INST_WAIT_TIME(x)     (((x) & 0x3ff) << 0)
+#define SOR_SEQ_INST_WAIT_UNITS_VSYNC (2 << 12)
+#define SOR_SEQ_INST_HALT             (1 << 15)
+#define SOR_SEQ_INST_PIN_A_LOW        (0 << 21)
+#define SOR_SEQ_INST_PIN_A_HIGH       (1 << 21)
+#define SOR_SEQ_INST_PIN_B_LOW        (0 << 22)
+#define SOR_SEQ_INST_PIN_B_HIGH       (1 << 22)
+#define SOR_SEQ_INST_DRIVE_PWM_OUT_LO (1 << 23)
+
+#define HDMI_NV_PDISP_SOR_LANE_DRIVE_CURRENT 0x7e
+#define DRIVE_CURRENT_LANE0(x)      (((x) & 0x3f) <<  0)
+#define DRIVE_CURRENT_LANE1(x)      (((x) & 0x3f) <<  8)
+#define DRIVE_CURRENT_LANE2(x)      (((x) & 0x3f) << 16)
+#define DRIVE_CURRENT_LANE3(x)      (((x) & 0x3f) << 24)
+#define DRIVE_CURRENT_FUSE_OVERRIDE (1 << 31)
+
+#define DRIVE_CURRENT_1_500_mA  0x00
+#define DRIVE_CURRENT_1_875_mA  0x01
+#define DRIVE_CURRENT_2_250_mA  0x02
+#define DRIVE_CURRENT_2_625_mA  0x03
+#define DRIVE_CURRENT_3_000_mA  0x04
+#define DRIVE_CURRENT_3_375_mA  0x05
+#define DRIVE_CURRENT_3_750_mA  0x06
+#define DRIVE_CURRENT_4_125_mA  0x07
+#define DRIVE_CURRENT_4_500_mA  0x08
+#define DRIVE_CURRENT_4_875_mA  0x09
+#define DRIVE_CURRENT_5_250_mA  0x0a
+#define DRIVE_CURRENT_5_625_mA  0x0b
+#define DRIVE_CURRENT_6_000_mA  0x0c
+#define DRIVE_CURRENT_6_375_mA  0x0d
+#define DRIVE_CURRENT_6_750_mA  0x0e
+#define DRIVE_CURRENT_7_125_mA  0x0f
+#define DRIVE_CURRENT_7_500_mA  0x10
+#define DRIVE_CURRENT_7_875_mA  0x11
+#define DRIVE_CURRENT_8_250_mA  0x12
+#define DRIVE_CURRENT_8_625_mA  0x13
+#define DRIVE_CURRENT_9_000_mA  0x14
+#define DRIVE_CURRENT_9_375_mA  0x15
+#define DRIVE_CURRENT_9_750_mA  0x16
+#define DRIVE_CURRENT_10_125_mA 0x17
+#define DRIVE_CURRENT_10_500_mA 0x18
+#define DRIVE_CURRENT_10_875_mA 0x19
+#define DRIVE_CURRENT_11_250_mA 0x1a
+#define DRIVE_CURRENT_11_625_mA 0x1b
+#define DRIVE_CURRENT_12_000_mA 0x1c
+#define DRIVE_CURRENT_12_375_mA 0x1d
+#define DRIVE_CURRENT_12_750_mA 0x1e
+#define DRIVE_CURRENT_13_125_mA 0x1f
+#define DRIVE_CURRENT_13_500_mA 0x20
+#define DRIVE_CURRENT_13_875_mA 0x21
+#define DRIVE_CURRENT_14_250_mA 0x22
+#define DRIVE_CURRENT_14_625_mA 0x23
+#define DRIVE_CURRENT_15_000_mA 0x24
+#define DRIVE_CURRENT_15_375_mA 0x25
+#define DRIVE_CURRENT_15_750_mA 0x26
+#define DRIVE_CURRENT_16_125_mA 0x27
+#define DRIVE_CURRENT_16_500_mA 0x28
+#define DRIVE_CURRENT_16_875_mA 0x29
+#define DRIVE_CURRENT_17_250_mA 0x2a
+#define DRIVE_CURRENT_17_625_mA 0x2b
+#define DRIVE_CURRENT_18_000_mA 0x2c
+#define DRIVE_CURRENT_18_375_mA 0x2d
+#define DRIVE_CURRENT_18_750_mA 0x2e
+#define DRIVE_CURRENT_19_125_mA 0x2f
+#define DRIVE_CURRENT_19_500_mA 0x30
+#define DRIVE_CURRENT_19_875_mA 0x31
+#define DRIVE_CURRENT_20_250_mA 0x32
+#define DRIVE_CURRENT_20_625_mA 0x33
+#define DRIVE_CURRENT_21_000_mA 0x34
+#define DRIVE_CURRENT_21_375_mA 0x35
+#define DRIVE_CURRENT_21_750_mA 0x36
+#define DRIVE_CURRENT_22_125_mA 0x37
+#define DRIVE_CURRENT_22_500_mA 0x38
+#define DRIVE_CURRENT_22_875_mA 0x39
+#define DRIVE_CURRENT_23_250_mA 0x3a
+#define DRIVE_CURRENT_23_625_mA 0x3b
+#define DRIVE_CURRENT_24_000_mA 0x3c
+#define DRIVE_CURRENT_24_375_mA 0x3d
+#define DRIVE_CURRENT_24_750_mA 0x3e
+
+#define HDMI_NV_PDISP_AUDIO_FS(x) (0x82 + (x))
+#define AUDIO_FS_LOW(x)  (((x) & 0xfff) <<  0)
+#define AUDIO_FS_HIGH(x) (((x) & 0xfff) << 16)
+
+#define HDMI_NV_PDISP_AUDIO_CNTRL0 0x8b
+#define AUDIO_CNTRL0_ERROR_TOLERANCE(x)  (((x) & 0xff) << 0)
+#define AUDIO_CNTRL0_SOURCE_SELECT_AUTO  (0 << 20)
+#define AUDIO_CNTRL0_SOURCE_SELECT_SPDIF (1 << 20)
+#define AUDIO_CNTRL0_SOURCE_SELECT_HDAL  (2 << 20)
+#define AUDIO_CNTRL0_FRAMES_PER_BLOCK(x) (((x) & 0xff) << 24)
+
+#define HDMI_NV_PDISP_AUDIO_N 0x8c
+#define AUDIO_N_VALUE(x)           (((x) & 0xfffff) << 0)
+#define AUDIO_N_RESETF             (1 << 20)
+#define AUDIO_N_GENERATE_NORMAL    (0 << 24)
+#define AUDIO_N_GENERATE_ALTERNATE (1 << 24)
+
+#define HDMI_NV_PDISP_SOR_REFCLK 0x95
+#define SOR_REFCLK_DIV_INT(x)  (((x) & 0xff) << 8)
+#define SOR_REFCLK_DIV_FRAC(x) (((x) & 0x03) << 6)
+
+#define HDMI_NV_PDISP_INPUT_CONTROL 0x97
+#define HDMI_SRC_DISPLAYA       (0 << 0)
+#define HDMI_SRC_DISPLAYB       (1 << 0)
+#define ARM_VIDEO_RANGE_FULL    (0 << 1)
+#define ARM_VIDEO_RANGE_LIMITED (1 << 1)
+
+#define HDMI_NV_PDISP_PE_CURRENT 0x99
+#define PE_CURRENT0(x) (((x) & 0xf) << 0)
+#define PE_CURRENT1(x) (((x) & 0xf) << 8)
+#define PE_CURRENT2(x) (((x) & 0xf) << 16)
+#define PE_CURRENT3(x) (((x) & 0xf) << 24)
+
+#define PE_CURRENT_0_0_mA 0x0
+#define PE_CURRENT_0_5_mA 0x1
+#define PE_CURRENT_1_0_mA 0x2
+#define PE_CURRENT_1_5_mA 0x3
+#define PE_CURRENT_2_0_mA 0x4
+#define PE_CURRENT_2_5_mA 0x5
+#define PE_CURRENT_3_0_mA 0x6
+#define PE_CURRENT_3_5_mA 0x7
+#define PE_CURRENT_4_0_mA 0x8
+#define PE_CURRENT_4_5_mA 0x9
+#define PE_CURRENT_5_0_mA 0xa
+#define PE_CURRENT_5_5_mA 0xb
+#define PE_CURRENT_6_0_mA 0xc
+#define PE_CURRENT_6_5_mA 0xd
+#define PE_CURRENT_7_0_mA 0xe
+#define PE_CURRENT_7_5_mA 0xf
+
+#define HDMI_NV_PDISP_SOR_AUDIO_CNTRL0 0xac
+#define AUDIO_CNTRL0_INJECT_NULLSMPL (1 << 29)
+
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_0320_0 0xbf
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_0441_0 0xc0
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_0882_0 0xc1
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_1764_0 0xc2
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_0480_0 0xc3
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_0960_0 0xc4
+#define HDMI_NV_PDISP_SOR_AUDIO_AVAL_1920_0 0xc5
+
+#endif /* TEGRA_HDMI_H */
diff --git a/drivers/gpu/drm/tegra/tegra-host1x.c b/drivers/gpu/drm/tegra/tegra-host1x.c
new file mode 100644
index 0000000..fe8f2ac
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-host1x.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct tegra_host1x {
+	void __iomem *regs;
+	struct clk *clk;
+};
+
+static int __devinit tegra_host1x_probe(struct platform_device *pdev)
+{
+	struct tegra_host1x *host1x;
+	struct resource *regs;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	host1x = devm_kzalloc(&pdev->dev, sizeof(*host1x), GFP_KERNEL);
+	if (!host1x) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	host1x->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(host1x->clk)) {
+		err = -EPROBE_DEFER;
+		goto out;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		err = -ENXIO;
+		goto put_clk;
+	}
+
+	host1x->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!host1x->regs) {
+		err = -EADDRNOTAVAIL;
+		goto put_clk;
+	}
+
+	platform_set_drvdata(pdev, host1x);
+	goto out;
+
+put_clk:
+	clk_put(host1x->clk);
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_host1x_remove(struct platform_device *pdev)
+{
+	struct tegra_host1x *host1x = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	clk_put(host1x->clk);
+
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_host1x_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-host1x", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_host1x_driver = {
+	.driver = {
+		.name = "tegra-host1x",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_host1x_of_match),
+	},
+	.probe = tegra_host1x_probe,
+	.remove = __devexit_p(tegra_host1x_remove),
+};
diff --git a/drivers/gpu/drm/tegra/tegra-rgb.c b/drivers/gpu/drm/tegra/tegra-rgb.c
new file mode 100644
index 0000000..7d37920
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-rgb.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "tegra-drv.h"
+#include "tegra-dc.h"
+
+#define PIN_REG_COUNT 4
+#define PIN_OUTPUT_SEL_COUNT 7
+
+static const u32 rgb_enable_tab[PIN_REG_COUNT] = {
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+};
+
+static const u32 rgb_polarity_tab[PIN_REG_COUNT] = {
+	0x00000000,
+	0x01000000,
+	0x00000000,
+	0x00000000,
+};
+
+static const u32 rgb_data_tab[PIN_REG_COUNT] = {
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+};
+
+static const u32 rgb_sel_tab[PIN_OUTPUT_SEL_COUNT] = {
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00210222,
+	0x00002200,
+	0x00020000,
+};
+
+static int tegra_output_rgb_enable(struct tegra_output *output)
+{
+	unsigned int i;
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+	dev_dbg(output->dev, "  crtc: %p\n", output->crtc);
+
+	/* enable RGB output */
+	for (i = 0; i < PIN_REG_COUNT; i++) {
+		tegra_crtc_writel(output->crtc, rgb_enable_tab[i],
+				  DC_COM_PIN_OUTPUT_ENABLE(i));
+		tegra_crtc_writel(output->crtc, rgb_polarity_tab[i],
+				  DC_COM_PIN_OUTPUT_POLARITY(i));
+		tegra_crtc_writel(output->crtc, rgb_data_tab[i],
+				  DC_COM_PIN_OUTPUT_DATA(i));
+	}
+
+	for (i = 0; i < PIN_OUTPUT_SEL_COUNT; i++)
+		tegra_crtc_writel(output->crtc, rgb_sel_tab[i],
+				  DC_COM_PIN_OUTPUT_SELECT(i));
+
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_output_rgb_disable(struct tegra_output *output)
+{
+	int err = 0;
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static const struct tegra_output_ops rgb_ops = {
+	.enable = tegra_output_rgb_enable,
+	.disable = tegra_output_rgb_disable,
+};
+
+static int __devinit tegra_rgb_probe(struct platform_device *pdev)
+{
+	struct tegra_output *output;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	output = devm_kzalloc(&pdev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	output->type = TEGRA_DRM_OUTPUT_RGB;
+	output->dev = &pdev->dev;
+	output->ops = &rgb_ops;
+
+	err = tegra_drm_output_add(output);
+	if (err < 0)
+		goto out;
+
+	platform_set_drvdata(pdev, output);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_rgb_remove(struct platform_device *pdev)
+{
+	struct tegra_output *output = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = tegra_drm_output_del(output);
+	if (err < 0)
+		goto out;
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_rgb_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-rgb", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_rgb_driver = {
+	.driver = {
+		.name = "tegra-rgb",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_rgb_of_match),
+	},
+	.probe = tegra_rgb_probe,
+	.remove = __devexit_p(tegra_rgb_remove),
+};
diff --git a/drivers/gpu/drm/tegra/tegra-tvo.c b/drivers/gpu/drm/tegra/tegra-tvo.c
new file mode 100644
index 0000000..7c5a159
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra-tvo.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "tegra-drv.h"
+
+struct tegra_tvo {
+	struct tegra_output base;
+
+	void __iomem *regs;
+	unsigned int irq;
+	struct clk *clk;
+};
+
+static inline struct tegra_tvo *to_tvo(struct tegra_output *output)
+{
+	return container_of(output, struct tegra_tvo, base);
+}
+
+static int tegra_output_tvo_enable(struct tegra_output *output)
+{
+	struct tegra_tvo *tvo = to_tvo(output);
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	err = clk_prepare_enable(tvo->clk);
+	if (err < 0)
+		goto out;
+
+out:
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int tegra_output_tvo_disable(struct tegra_output *output)
+{
+	struct tegra_tvo *tvo = to_tvo(output);
+	int err = 0;
+
+	dev_dbg(output->dev, "> %s(output=%p)\n", __func__, output);
+
+	clk_disable_unprepare(tvo->clk);
+
+	dev_dbg(output->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static const struct tegra_output_ops tvo_ops = {
+	.enable = tegra_output_tvo_enable,
+	.disable = tegra_output_tvo_disable,
+};
+
+static int __devinit tegra_tvo_probe(struct platform_device *pdev)
+{
+	struct tegra_tvo *tvo;
+	struct resource *regs;
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	tvo = devm_kzalloc(&pdev->dev, sizeof(*tvo), GFP_KERNEL);
+	if (!tvo) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	tvo->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR_OR_NULL(tvo->clk)) {
+		err = -EPROBE_DEFER;
+		goto out;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		err = -ENXIO;
+		goto put_clk;
+	}
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0)
+		goto put_clk;
+
+	tvo->irq = err;
+
+	tvo->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!tvo->regs) {
+		err = -EADDRNOTAVAIL;
+		goto put_clk;
+	}
+
+	tvo->base.type = TEGRA_DRM_OUTPUT_TVO;
+	tvo->base.dev = &pdev->dev;
+	tvo->base.ops = &tvo_ops;
+
+	err = tegra_drm_output_add(&tvo->base);
+	if (err < 0)
+		goto put_clk;
+
+	platform_set_drvdata(pdev, tvo);
+	goto out;
+
+put_clk:
+	clk_put(tvo->clk);
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_tvo_remove(struct platform_device *pdev)
+{
+	struct tegra_tvo *tvo = platform_get_drvdata(pdev);
+	int err = 0;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	err = tegra_drm_output_del(&tvo->base);
+	if (err < 0)
+		goto out;
+
+	clk_put(tvo->clk);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_tvo_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-tvo", },
+	{ },
+};
+#endif
+
+struct platform_driver tegra_tvo_driver = {
+	.driver = {
+		.name = "tegra-tvo",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra_tvo_of_match),
+	},
+	.probe = tegra_tvo_probe,
+	.remove = __devexit_p(tegra_tvo_remove),
+};
diff --git a/include/drm/tegra_drm.h b/include/drm/tegra_drm.h
new file mode 100644
index 0000000..272fccb
--- /dev/null
+++ b/include/drm/tegra_drm.h
@@ -0,0 +1,40 @@
+#ifndef _TEGRA_DRM_H_
+#define _TEGRA_DRM_H_
+
+enum tegra_drm_output_type {
+	TEGRA_DRM_OUTPUT_RGB,
+	TEGRA_DRM_OUTPUT_HDMI,
+	TEGRA_DRM_OUTPUT_TVO,
+	TEGRA_DRM_OUTPUT_DSI,
+};
+
+struct tegra_drm_mode {
+	unsigned int pixel_clock;
+	unsigned int vrefresh;
+
+	unsigned int width;
+	unsigned int height;
+	unsigned int bpp;
+
+	unsigned int href_to_sync;
+	unsigned int hsync_width;
+	unsigned int hback_porch;
+	unsigned int hfront_porch;
+
+	unsigned int vref_to_sync;
+	unsigned int vsync_width;
+	unsigned int vback_porch;
+	unsigned int vfront_porch;
+};
+
+struct tegra_encon_platform_data {
+	struct edid *edid;
+	int ddc;
+};
+
+struct tegra_drm_platform_data {
+	struct resource carveout;
+	struct resource aperture;
+};
+
+#endif
-- 
1.7.10
