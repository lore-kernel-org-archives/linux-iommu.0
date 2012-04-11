From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 14:10:30 +0200
Message-ID: <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334146230-1795-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
currently has rudimentary GEM support and can run a console on the
framebuffer as well as X using the xf86-video-modesetting driver.
Only the RGB output is supported. Quite a lot of things still need
to be worked out and there is a lot of room for cleanup.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 .../devicetree/bindings/gpu/drm/tegra.txt          |   24 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |    3 +
 arch/arm/mach-tegra/tegra2_clocks.c                |    8 +-
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/tegra/Kconfig                      |   10 +
 drivers/gpu/drm/tegra/Makefile                     |    5 +
 drivers/gpu/drm/tegra/tegra_drv.c                  | 2241 ++++++++++++++++++++
 drivers/gpu/drm/tegra/tegra_drv.h                  |  184 ++
 include/drm/tegra_drm.h                            |   44 +
 10 files changed, 2518 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/drm/tegra.txt
 create mode 100644 drivers/gpu/drm/tegra/Kconfig
 create mode 100644 drivers/gpu/drm/tegra/Makefile
 create mode 100644 drivers/gpu/drm/tegra/tegra_drv.c
 create mode 100644 drivers/gpu/drm/tegra/tegra_drv.h
 create mode 100644 include/drm/tegra_drm.h

diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
new file mode 100644
index 0000000..d39fe64
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
@@ -0,0 +1,24 @@
+Example:
+
+	drm@54200000 {
+		compatible = "nvidia,tegra20-drm";
+		reg = < 0x54200000 0x00040000    /* display A */
+		        0x54240000 0x00040000    /* display B */
+		        0x58000000 0x02000000 >; /* GART aperture */
+		interrupts = < 0 73 0x04    /* display A */
+		               0 74 0x04 >; /* display B */
+
+		lvds {
+			type = "rgb";
+			size = <345 194>;
+
+			default-mode {
+				pixel-clock = <61715000>;
+				vertical-refresh = <50>;
+				resolution = <1366 768>;
+				bits-per-pixel = <16>;
+				horizontal-timings = <4 136 2 36>;
+				vertical-timings = <2 4 21 10>;
+			};
+		};
+	};
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index bffba1b..6ce6162 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -67,6 +67,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 		       &tegra_ehci3_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-gart", TEGRA_MC_BASE, "tegra-gart", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-drm", TEGRA_DISPLAY_BASE, "tegra-drm", NULL),
 	{}
 };
 
@@ -81,6 +82,8 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ "cdev1",      NULL,           0,              true },
 	{ "i2s1",       "pll_a_out0",   11289600,       false},
 	{ "i2s2",       "pll_a_out0",   11289600,       false},
+	{ "host1x",     "pll_c",        144000000,      true },
+	{ "disp1",      "pll_p",        600000000,      true },
 	{ NULL,		NULL,		0,		0},
 };
 
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index f29084d..c86eae6 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -2219,8 +2219,8 @@ static struct clk tegra_list_clks[] = {
 	PERIPH_CLK("tvo",	"tvo",			NULL,	49,	0x188,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
 	PERIPH_CLK("hdmi",	"hdmi",			NULL,	51,	0x18c,	600000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
 	PERIPH_CLK("tvdac",	"tvdac",		NULL,	53,	0x194,	250000000, mux_pllp_plld_pllc_clkm,	MUX | DIV_U71), /* requires min voltage */
-	PERIPH_CLK("disp1",	"tegradc.0",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
-	PERIPH_CLK("disp2",	"tegradc.1",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
+	PERIPH_CLK("disp1",	"tegra-drm",		NULL,	27,	0x138,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
+	PERIPH_CLK("disp2",	"tegra-drm",		NULL,	26,	0x13c,	600000000, mux_pllp_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
 	PERIPH_CLK("usbd",	"fsl-tegra-udc",	NULL,	22,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
 	PERIPH_CLK("usb2",	"tegra-ehci.1",		NULL,	58,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
 	PERIPH_CLK("usb3",	"tegra-ehci.2",		NULL,	59,	0,	480000000, mux_clk_m,			0), /* requires min voltage */
@@ -2235,8 +2235,8 @@ static struct clk tegra_list_clks[] = {
 	SHARED_CLK("avp.sclk",	"tegra-avp",		"sclk",	&tegra_clk_sclk),
 	SHARED_CLK("avp.emc",	"tegra-avp",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("cpu.emc",	"cpu",			"emc",	&tegra_clk_emc),
-	SHARED_CLK("disp1.emc",	"tegradc.0",		"emc",	&tegra_clk_emc),
-	SHARED_CLK("disp2.emc",	"tegradc.1",		"emc",	&tegra_clk_emc),
+	SHARED_CLK("disp1.emc",	"tegra-drm",		"emc",	&tegra_clk_emc),
+	SHARED_CLK("disp2.emc",	"tegra-drm",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("hdmi.emc",	"hdmi",			"emc",	&tegra_clk_emc),
 	SHARED_CLK("host.emc",	"tegra_grhost",		"emc",	&tegra_clk_emc),
 	SHARED_CLK("usbd.emc",	"fsl-tegra-udc",	"emc",	&tegra_clk_emc),
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
index 0000000..f3382c9
--- /dev/null
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -0,0 +1,10 @@
+config DRM_TEGRA
+	tristate "NVIDIA Tegra"
+	depends on DRM && ARCH_TEGRA
+	select DRM_KMS_ENCON
+	select DRM_KMS_HELPER
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Choose this option if you have an NVIDIA Tegra SoC.
diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makefile
new file mode 100644
index 0000000..62c7e56a
--- /dev/null
+++ b/drivers/gpu/drm/tegra/Makefile
@@ -0,0 +1,5 @@
+ccflags-y := -Iinclude/drm
+
+tegra-drm-y := tegra_drv.o
+
+obj-$(CONFIG_DRM_TEGRA) += tegra-drm.o
diff --git a/drivers/gpu/drm/tegra/tegra_drv.c b/drivers/gpu/drm/tegra/tegra_drv.c
new file mode 100644
index 0000000..2c691dc
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra_drv.c
@@ -0,0 +1,2241 @@
+/*
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/iommu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+
+#include <linux/shmem_fs.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fixed.h>
+#include <drm/tegra_drm.h>
+
+#include <mach/clk.h>
+#include <mach/iomap.h>
+
+#include "tegra_drv.h"
+
+#define DRIVER_NAME "tegra"
+#define DRIVER_DESC "NVIDIA Tegra graphics"
+#define DRIVER_DATE "20120330"
+#define DRIVER_MAJOR 0
+#define DRIVER_MINOR 0
+#define DRIVER_PATCHLEVEL 0
+
+static const unsigned int num_crtc = 1;
+
+struct tegra_gem_object;
+struct tegra_crtc_ops;
+
+struct tegra_crtc {
+	struct drm_crtc base;
+	int pipe;
+
+	struct clk *clk_emc;
+	struct clk *clk;
+
+	void __iomem *regs;
+	int irq;
+
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+
+	struct tegra_drm_panel *panel;
+
+	const struct tegra_crtc_ops *ops;
+};
+
+static inline struct tegra_crtc *to_tegra_crtc(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct tegra_crtc, base);
+}
+
+struct tegra_crtc_ops {
+	int (*enable)(struct tegra_crtc *crtc);
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
+	unsigned int num_crtcs;
+
+	struct iommu_domain *gart;
+	struct resource aperture;
+};
+
+static inline void tegra_crtc_writel(struct tegra_crtc *crtc, unsigned long value, unsigned long reg)
+{
+	writel(value, crtc->regs + (reg << 2));
+}
+
+static inline unsigned long tegra_crtc_readl(struct tegra_crtc *crtc, unsigned long reg)
+{
+	return readl(crtc->regs + (reg << 2));
+}
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
+static unsigned long pclk_round_rate(struct clk *clk, unsigned long pclk, unsigned long *div)
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
+static int tegra_drmfb_create_handle(struct drm_framebuffer *fb, struct drm_file *filp, unsigned int *handle)
+{
+	struct tegra_framebuffer *privfb = to_tegra_fb(fb);
+	struct drm_device *drm = fb->dev;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(fb=%p, filp=%p, handle=%p)\n", __func__, fb, filp, handle);
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
+	dev_dbg(drm->dev, "> %s(drm=%p, fb=%p, mode=%p)\n", __func__, drm, fb, mode);
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
+static struct drm_mode_config_funcs tegra_drm_mode_funcs = {
+	.fb_create = tegra_drm_fb_create,
+	.output_poll_changed = tegra_drm_fb_output_poll_changed,
+};
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
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, fb=%p, event=%p)\n", __func__, crtc, fb, event);
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
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%d)\n", __func__, crtc, mode);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static bool tegra_crtc_mode_fixup(struct drm_crtc *crtc,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted)
+{
+	bool ret = true;
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%p, adjusted=%p)\n", __func__, crtc, mode, adjusted);
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+struct crtc_mode {
+	unsigned int width;
+	unsigned int height;
+	unsigned int href_to_sync;
+	unsigned int vref_to_sync;
+	unsigned int hsync_width;
+	unsigned int vsync_width;
+	unsigned int hback_porch;
+	unsigned int vback_porch;
+	unsigned int hfront_porch;
+	unsigned int vfront_porch;
+};
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
+static int tegra_crtc_set_timings(struct tegra_crtc *crtc, struct drm_display_mode *mode)
+{
+	unsigned int front_porch[2];
+	unsigned int back_porch[2];
+	unsigned int sync_width[2];
+	unsigned int active[2];
+	unsigned int reftos[2];
+
+	active[0] = mode->hdisplay;
+	active[1] = mode->vdisplay;
+	reftos[0] = 0;
+	reftos[1] = 0;
+	sync_width[0] = mode->hsync_end - mode->hsync_start;
+	sync_width[1] = mode->vsync_end - mode->vsync_start;
+	back_porch[0] = mode->hsync_start - mode->hdisplay;
+	back_porch[1] = mode->vsync_start - mode->vdisplay;
+	front_porch[0] = mode->htotal - mode->hsync_end;
+	front_porch[1] = mode->vtotal - mode->vsync_end;
+
+	tegra_crtc_writel(crtc, 0x0, DISP_TIMING_OPT);
+	tegra_crtc_writel(crtc, (reftos[1] << 16) | reftos[0], DISP_REF_TO_SYNC);
+	tegra_crtc_writel(crtc, (sync_width[1] << 16) | sync_width[0], DISP_SYNC_WIDTH);
+	tegra_crtc_writel(crtc, (back_porch[1] << 16) | back_porch[0], DISP_BACK_PORCH);
+	tegra_crtc_writel(crtc, (front_porch[1] << 16) | front_porch[0], DISP_FRONT_PORCH);
+
+	tegra_crtc_writel(crtc, (active[1] << 16) | active[0], DISP_ACTIVE);
+
+	return 0;
+}
+
+static int tegra_crtc_mode_set(struct drm_crtc *crtc,
+			       struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted,
+			       int x, int y, struct drm_framebuffer *old_fb)
+{
+	struct tegra_crtc *priv = container_of(crtc, struct tegra_crtc, base);
+	unsigned long pclk = mode->clock * 1000;
+	struct tegra_framebuffer *fb;
+	unsigned long update_mask;
+	unsigned long rate, div;
+	struct crtc_win win;
+	unsigned int h_dda;
+	unsigned int v_dda;
+	unsigned long val;
+	unsigned int bpp;
+	int ret = 0;
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, mode=%p, adjusted=%p, x=%d, y=%d, old_fb=%p)\n",
+		__func__, crtc, mode, adjusted, x, y, old_fb);
+
+	fb = container_of(crtc->fb, struct tegra_framebuffer, base);
+	update_mask = CMD_STATE_CTRL_GENERAL_ACT_REQ;
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
+	val = DISP_DATA_ENABLE_OPT_SELECT_ACTIVE |
+	      DISP_DATA_ENABLE_OPT_CONTROL_NORMAL;
+	tegra_crtc_writel(priv, val, DISP_DATA_ENABLE_OPT);
+
+	val = tegra_crtc_readl(priv, COM_PIN_OUTPUT_POLARITY(1));
+	val &= ~COM_PIN_OUTPUT_POLARITY_PIN1_LVS_OUTPUT;
+	val &= ~COM_PIN_OUTPUT_POLARITY_PIN1_LHS_OUTPUT;
+	tegra_crtc_writel(priv, val, COM_PIN_OUTPUT_POLARITY(1));
+
+	val = DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P1C |
+	      DISP_INTERFACE_CTRL_ALIGN_MSB |
+	      DISP_INTERFACE_CTRL_ORDER_RED_BLUE;
+	tegra_crtc_writel(priv, val, DISP_INTERFACE_CTRL);
+
+	tegra_crtc_writel(priv, 0x00010001, DISP_SHIFT_CLK_OPT);
+
+	val = DISP_CLK_CTRL_CLK_DIV(div - 2) | DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD1;
+	tegra_crtc_writel(priv, val, DISP_CLK_CTRL);
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
+	val = tegra_crtc_readl(priv, CMD_WIN_HEADER);
+	val |= CMD_WIN_HEADER_WINDOW_A_SELECT;
+	tegra_crtc_writel(priv, val, CMD_WIN_HEADER);
+
+	tegra_crtc_writel(priv, win.fmt, WIN_COLOR_DEPTH);
+	tegra_crtc_writel(priv, 0, WIN_BYTE_SWAP);
+
+	val = WIN_POSITION_V(win.outy) | WIN_POSITION_H(win.outx);
+	tegra_crtc_writel(priv, val, WIN_POSITION);
+
+	val = WIN_SIZE_V(win.outh) | WIN_SIZE_H(win.outw);
+	tegra_crtc_writel(priv, val, WIN_SIZE);
+
+	val = WIN_PRESCALED_SIZE_V(dfixed_trunc(win.h)) |
+	      WIN_PRESCALED_SIZE_H(dfixed_trunc(win.w) * bpp);
+	tegra_crtc_writel(priv, val, WIN_PRESCALED_SIZE);
+
+	h_dda = compute_dda_inc(win.w, win.outw, false, bpp);
+	v_dda = compute_dda_inc(win.h, win.outh, true, bpp);
+
+	val = WIN_DDA_INC_V(v_dda) | WIN_DDA_INC_H(h_dda);
+	tegra_crtc_writel(priv, val, WIN_DDA_INC);
+
+	h_dda = compute_initial_dda(win.x);
+	v_dda = compute_initial_dda(win.y);
+
+	tegra_crtc_writel(priv, h_dda, WIN_H_INITIAL_DDA);
+	tegra_crtc_writel(priv, v_dda, WIN_V_INITIAL_DDA);
+
+	tegra_crtc_writel(priv, 0, WIN_UV_BUF_STRIDE);
+	tegra_crtc_writel(priv, 0, WIN_BUF_STRIDE);
+
+	dev_dbg(crtc->dev->dev, "%s(): displaying GEM %p @%x\n", __func__,
+		fb->obj, fb->obj->phys.start);
+
+	tegra_crtc_writel(priv, fb->obj->phys.start, WINBUF_START_ADDR);
+	tegra_crtc_writel(priv, win.stride, WIN_LINE_STRIDE);
+	tegra_crtc_writel(priv, dfixed_trunc(win.x) * bpp, WINBUF_ADDR_H_OFFSET);
+	tegra_crtc_writel(priv, dfixed_trunc(win.y), WINBUF_ADDR_V_OFFSET);
+
+	val = WIN_OPT_ENABLE;
+
+	if (bpp < 24)
+		val |= WIN_OPT_COLOR_EXPAND;
+
+	tegra_crtc_writel(priv, val, WIN_OPT);
+
+	tegra_crtc_writel(priv, 0xff00, WIN_BLEND_NOKEY);
+	tegra_crtc_writel(priv, 0xff00, WIN_BLEND_1WIN);
+
+	update_mask |= CMD_STATE_CTRL_WIN_A_ACT_REQ;
+
+	tegra_crtc_writel(priv, update_mask << 8, CMD_STATE_CTRL);
+
+	val = tegra_crtc_readl(priv, CMD_INT_ENABLE);
+	val |= INT_FRAME_END;
+	tegra_crtc_writel(priv, val, CMD_INT_ENABLE);
+
+	val = tegra_crtc_readl(priv, CMD_INT_MASK);
+	val |= INT_FRAME_END;
+	tegra_crtc_writel(priv, val, CMD_INT_MASK);
+
+	tegra_crtc_writel(priv, update_mask, CMD_STATE_CTRL);
+
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+#if 0
+static int tegra_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
+				    struct drm_framebuffer *fb)
+{
+	struct tegra_framebuffer *privfb = to_tegra_fb(fb);
+	struct tegra_crtc *priv = to_tegra_crtc(crtc);
+	int ret = 0;
+
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p, x=%d, y=%d, fb=%p)\n", __func__, crtc, x, y,
+		fb);
+
+	tegra_crtc_writel(priv, privfb->phys, WINBUF_START_ADDR);
+
+	dev_dbg(crtc->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+#else
+#define tegra_crtc_mode_set_base NULL
+#endif
+
+static void tegra_crtc_prepare(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static void tegra_crtc_commit(struct drm_crtc *crtc)
+{
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
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
+	dev_dbg(crtc->dev->dev, "> %s(crtc=%p)\n", __func__, crtc);
+	dev_dbg(crtc->dev->dev, "< %s()\n", __func__);
+}
+
+static const struct drm_crtc_helper_funcs tegra_crtc_helper_funcs = {
+	.dpms = tegra_crtc_dpms,
+	.mode_fixup = tegra_crtc_mode_fixup,
+	.mode_set = tegra_crtc_mode_set,
+	.mode_set_base = tegra_crtc_mode_set_base,
+	.prepare = tegra_crtc_prepare,
+	.commit = tegra_crtc_commit,
+	.load_lut = tegra_crtc_load_lut,
+	.disable = tegra_crtc_disable,
+};
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
+static int tegra_connector_get_modes(struct drm_connector *connector)
+{
+	struct tegra_crtc *crtc = container_of(connector, struct tegra_crtc, connector);
+	struct tegra_drm_panel *panel = crtc->panel;
+	unsigned int i;
+	int ret = 0;
+
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+
+	if (!panel) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	dev_dbg(&connector->kdev, "  panel: %d\n", panel->type);
+	dev_dbg(&connector->kdev, "    size: %ux%u\n", panel->width,
+		panel->height);
+	dev_dbg(&connector->kdev, "    modes: %u\n", panel->num_modes);
+
+	for (i = 0; i < panel->num_modes; i++) {
+		struct tegra_drm_mode *mode = &panel->modes[i];
+		struct drm_display_mode *display_mode;
+
+		display_mode = drm_mode_create(connector->dev);
+		if (!display_mode) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		display_mode->width_mm = panel->width;
+		display_mode->height_mm = panel->height;
+
+		display_mode->clock = mode->pixel_clock / 1000;
+		display_mode->vrefresh = mode->vrefresh;
+		display_mode->hdisplay = mode->width;
+		display_mode->vdisplay = mode->height;
+
+		display_mode->hsync_start = mode->width + mode->hback_porch;
+		display_mode->hsync_end = display_mode->hsync_start + mode->hsync_width;
+		display_mode->htotal = display_mode->hsync_end + mode->hfront_porch;
+
+		display_mode->vsync_start = mode->height + mode->vback_porch;
+		display_mode->vsync_end = display_mode->vsync_start + mode->vsync_width;
+		display_mode->vtotal = display_mode->vsync_end + mode->vfront_porch;
+
+		drm_mode_set_name(display_mode);
+		drm_mode_probed_add(connector, display_mode);
+	}
+
+	ret = panel->num_modes;
+
+out:
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_connector_mode_valid(struct drm_connector *connector,
+				      struct drm_display_mode *mode)
+{
+	int ret = MODE_OK;
+	dev_dbg(&connector->kdev, "> %s(connector=%p, mode=%p)\n", __func__, connector, mode);
+	dev_dbg(&connector->kdev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static struct drm_encoder *tegra_connector_best_encoder(struct drm_connector *connector)
+{
+	struct tegra_crtc *crtc = container_of(connector, struct tegra_crtc, connector);
+	struct drm_encoder *ret = &crtc->encoder;
+	dev_dbg(&connector->kdev, "> %s(connector=%p)\n", __func__, connector);
+	dev_dbg(&connector->kdev, "< %s() = %p\n", __func__, ret);
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
+	dev_dbg(&connector->kdev, "> %s(connector=%p, mode=%d)\n", __func__, connector, mode);
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
+static enum drm_connector_status tegra_connector_detect(struct drm_connector *connector, bool force)
+{
+	enum drm_connector_status status = connector_status_unknown;
+
+	dev_dbg(&connector->kdev, "> %s(connector=%p, force=%d)\n", __func__, connector, force);
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
+	dev_dbg(&connector->kdev, "> %s(connector=%p, max_width=%u, max_height=%u)\n", __func__,
+		connector, max_width, max_height);
+
+	ret = drm_helper_probe_single_connector_modes(connector, max_width, max_height);
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
+	dev_dbg(&connector->kdev, "> %s(connector=%p, property=%p, value=%llx)\n", __func__,
+		connector, property, value);
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
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%d)\n", __func__, encoder, mode);
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
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%p, adjusted=%p)\n", __func__, encoder, mode, adjusted);
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
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, mode=%p, adjusted=%p)\n", __func__, encoder,
+		mode, adjusted);
+	dev_dbg(encoder->dev->dev, "< %s()\n", __func__);
+}
+
+static struct drm_crtc *tegra_encoder_get_crtc(struct drm_encoder *encoder)
+{
+	struct tegra_crtc *crtc = container_of(encoder, struct tegra_crtc, encoder);
+	struct drm_crtc *ret = &crtc->base;
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p)\n", __func__, encoder);
+	dev_dbg(encoder->dev->dev, "< %s() = %p\n", __func__, ret);
+	return ret;
+}
+
+static enum drm_connector_status tegra_encoder_detect(struct drm_encoder *encoder,
+						      struct drm_connector *connector)
+{
+	enum drm_connector_status status = connector_status_unknown;
+	dev_dbg(encoder->dev->dev, "> %s(encoder=%p, connector=%p)\n", __func__, encoder, connector);
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
+static int tegra_crtc_rgb_enable(struct tegra_crtc *crtc)
+{
+	unsigned int i;
+
+	/* enable RGB output */
+	for (i = 0; i < PIN_REG_COUNT; i++) {
+		tegra_crtc_writel(crtc, rgb_enable_tab[i], COM_PIN_OUTPUT_ENABLE(i));
+		tegra_crtc_writel(crtc, rgb_polarity_tab[i], COM_PIN_OUTPUT_POLARITY(i));
+		tegra_crtc_writel(crtc, rgb_data_tab[i], COM_PIN_OUTPUT_DATA(i));
+	}
+
+	for (i = 0; i < PIN_OUTPUT_SEL_COUNT; i++)
+		tegra_crtc_writel(crtc, rgb_sel_tab[i], COM_PIN_OUTPUT_SEL(i));
+
+	return 0;
+}
+
+static const struct tegra_crtc_ops tegra_crtc_rgb_ops = {
+	.enable = tegra_crtc_rgb_enable,
+};
+
+static int tegra_crtc_init(struct drm_device *drm, unsigned int pipe)
+{
+	struct tegra_drm_platform_data *pdata = drm->dev->platform_data;
+	unsigned int syncpt = pipe ? SYNCPT_VBLANK1 : SYNCPT_VBLANK0;
+	struct tegra_drm_private *priv = drm->dev_private;
+	struct tegra_crtc *crtc = &priv->crtc[pipe];
+	struct tegra_drm_panel *panel;
+	unsigned long val;
+	int connector;
+	int encoder;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, pipe=%u)\n", __func__, drm, pipe);
+
+	if (pipe >= pdata->num_panels) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	panel = crtc->panel = &pdata->panels[pipe];
+
+	switch (panel->type) {
+	case TEGRA_DRM_PANEL_RGB:
+		connector = DRM_MODE_CONNECTOR_LVDS;
+		encoder = DRM_MODE_ENCODER_LVDS;
+		crtc->ops = &tegra_crtc_rgb_ops;
+		break;
+
+	default:
+		connector = DRM_MODE_CONNECTOR_Unknown;
+		encoder = DRM_MODE_ENCODER_NONE;
+		break;
+	}
+
+	drm_connector_helper_add(&crtc->connector, &connector_helper_funcs);
+	drm_connector_init(drm, &crtc->connector, &connector_funcs, connector);
+
+	drm_encoder_init(drm, &crtc->encoder, &encoder_funcs, encoder);
+	drm_encoder_helper_add(&crtc->encoder, &encoder_helper_funcs);
+
+	drm_mode_connector_attach_encoder(&crtc->connector,
+					  &crtc->encoder);
+	drm_sysfs_connector_add(&crtc->connector);
+
+	crtc->encoder.possible_crtcs = 1 << pipe;
+
+	/* hardware initialization */
+
+	clk_enable(crtc->clk);
+	clk_enable(crtc->clk_emc);
+	tegra_periph_reset_deassert(crtc->clk);
+	msleep(10);
+
+	/* initialize display controller */
+	tegra_crtc_writel(crtc, 0x00000100, CMD_GENERAL_INCR_SYNCPT_CTRL);
+	tegra_crtc_writel(crtc, 0x100 | syncpt, CMD_CONT_SYNCPT_VSYNC);
+
+	val = INT_WIN_A_UF | INT_WIN_B_UF | INT_WIN_C_UF | INT_WIN_A_OF;
+	tegra_crtc_writel(crtc, val, CMD_INT_TYPE);
+
+	val = INT_WIN_A_UF | INT_WIN_B_UF | INT_WIN_C_UF |
+	      INT_WIN_A_OF | INT_WIN_B_OF | INT_WIN_C_OF;
+	tegra_crtc_writel(crtc, val, CMD_INT_POLARITY);
+
+	val = CMD_DISP_POWER_CTRL_PW0_ENABLE | CMD_DISP_POWER_CTRL_PW1_ENABLE |
+	      CMD_DISP_POWER_CTRL_PW2_ENABLE | CMD_DISP_POWER_CTRL_PW3_ENABLE |
+	      CMD_DISP_POWER_CTRL_PW4_ENABLE | CMD_DISP_POWER_CTRL_PM0_ENABLE |
+	      CMD_DISP_POWER_CTRL_PM1_ENABLE;
+	tegra_crtc_writel(crtc, val, CMD_DISP_POWER_CTRL);
+
+	val = tegra_crtc_readl(crtc, CMD_DISP_CMD);
+	val |= CMD_DISP_CMD_CTRL_MODE_C_DISPLAY;
+	tegra_crtc_writel(crtc, val, CMD_DISP_CMD);
+
+	/* initialize timer */
+	tegra_crtc_writel(crtc, 0x00202020, DISP_MEM_HIGH_PRI);
+	tegra_crtc_writel(crtc, 0x00010101, DISP_MEM_HIGH_PRI_TIMER);
+
+	val = INT_VBLANK | INT_WIN_A_UF | INT_WIN_B_UF | INT_WIN_C_UF;
+	tegra_crtc_writel(crtc, val, CMD_INT_MASK);
+
+	val = INT_VBLANK | INT_WIN_A_UF | INT_WIN_B_UF | INT_WIN_C_UF;
+	tegra_crtc_writel(crtc, val, CMD_INT_ENABLE);
+
+	ret = tegra_crtc_enable(crtc);
+	if (ret < 0)
+		goto out;
+
+	drm_crtc_init(drm, &crtc->base, &tegra_crtc_funcs);
+	drm_mode_crtc_set_gamma_size(&crtc->base, 256);
+	drm_crtc_helper_add(&crtc->base, &tegra_crtc_helper_funcs);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
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
+static struct tegra_gem_object *tegra_gem_alloc(struct drm_device *drm,
+						size_t size)
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
+	dev_dbg(drm->dev, "> %s(helper=%p, sizes=%p)\n", __func__, helper, sizes);
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
+static int tegra_fb_probe(struct drm_fb_helper *helper, struct drm_fb_helper_surface_size *sizes)
+{
+	int ret = 0;
+
+	dev_dbg(helper->dev->dev, "> %s(helper=%p, sizes=%p)\n", __func__, helper, sizes);
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
+static int tegra_drm_fb_init(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	unsigned int i;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+
+	drm_mode_config_init(drm);
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
+	for (i = 0; i < num_crtc; i++) {
+		ret = tegra_crtc_init(drm, i);
+		if (ret < 0)
+			goto out;
+
+		priv->num_crtcs++;
+	}
+
+	priv->fb_helper.funcs = &tegra_fb_helper_funcs;
+
+	ret = drm_fb_helper_init(drm, &priv->fb_helper, priv->num_crtcs,
+				 priv->num_crtcs);
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
+static irqreturn_t tegra_drm_irq(int irq, void *data)
+{
+	struct tegra_crtc *crtc = data;
+	unsigned long underflow;
+	unsigned long status;
+
+	dev_dbg(&crtc->connector.kdev, "> %s(irq=%d, data=%p)\n", __func__, irq, data);
+
+	status = tegra_crtc_readl(crtc, CMD_INT_STATUS);
+	tegra_crtc_writel(crtc, status, CMD_INT_STATUS);
+
+	dev_dbg(&crtc->connector.kdev, "  status: %#lx\n", status);
+
+	if (status & INT_FRAME_END)
+		dev_dbg(&crtc->connector.kdev, "%s(): frame end\n", __func__);
+
+	if (status & INT_VBLANK) {
+		dev_dbg(&crtc->connector.kdev, "%s(): V-blank\n", __func__);
+		drm_handle_vblank(crtc->connector.dev, crtc->pipe);
+	}
+
+	underflow = INT_WIN_A_UF | INT_WIN_B_UF | INT_WIN_C_UF;
+
+	if (status & underflow)
+		dev_dbg(&crtc->connector.kdev, "%s(): underflow\n", __func__);
+
+	dev_dbg(&crtc->connector.kdev, "< %s()\n", __func__);
+	return IRQ_HANDLED;
+}
+
+static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
+{
+	struct platform_device *pdev = drm->platformdev;
+	struct tegra_drm_private *priv;
+	unsigned int i;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p, flags=%lx)\n", __func__, drm, flags);
+
+	priv = devm_kzalloc(drm->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (drm->dev->of_node) {
+		ret = of_address_to_resource(drm->dev->of_node, 2,
+					     &priv->aperture);
+		if (ret < 0) {
+			dev_err(drm->dev, "of_address_to_resource(): %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (iommu_present(drm->dev->bus)) {
+		priv->gart = iommu_domain_alloc(drm->dev->bus);
+		if (!priv->gart) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = iommu_attach_device(priv->gart, drm->dev);
+		if (ret < 0) {
+			dev_err(drm->dev, "iommu_domain_attach_device(): %d\n", ret);
+			goto out;
+		}
+	}
+
+	drm->dev_private = priv;
+
+	for (i = 0; i < num_crtc; i++) {
+		struct tegra_crtc *crtc = &priv->crtc[i];
+		struct resource *regs;
+
+		dev_dbg(drm->dev, "  initializing CRTC %u: %p\n", i, crtc);
+
+		crtc->clk = clk_get(drm->dev, NULL);
+		if (IS_ERR_OR_NULL(crtc->clk)) {
+			DRM_ERROR("failed to get clock\n");
+			ret = -ENXIO;
+			goto out;
+		}
+
+		crtc->clk_emc = clk_get(drm->dev, "emc");
+		if (IS_ERR_OR_NULL(crtc->clk_emc)) {
+			DRM_ERROR("failed to get EMC clock\n");
+			ret = -ENXIO;
+			goto out;
+		}
+
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!regs) {
+			DRM_ERROR("failed to get registers\n");
+			ret = -ENXIO;
+			goto out;
+		}
+
+		crtc->regs = devm_request_and_ioremap(drm->dev, regs);
+		if (!crtc->regs) {
+			DRM_ERROR("failed to remap registers\n");
+			ret = -ENXIO;
+			goto out;
+		}
+
+		crtc->irq = platform_get_irq(pdev, i);
+		if (crtc->irq < 0) {
+			DRM_ERROR("failed to get IRQ\n");
+			ret = -ENXIO;
+			goto out;
+		}
+
+		crtc->pipe = i;
+
+		ret = devm_request_irq(drm->dev, crtc->irq, tegra_drm_irq,
+				       0, "tegra-drm", crtc);
+		if (ret < 0) {
+			DRM_ERROR("devm_request_irq(): %d\n", ret);
+			goto out;
+		}
+	}
+
+	ret = tegra_drm_fb_init(drm);
+	if (ret < 0) {
+		dev_dbg(drm->dev, "  tegra_drm_fb_init(): %d\n", ret);
+		goto out;
+	}
+
+	drm_kms_helper_poll_init(drm);
+
+out:
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_drm_fbdev_fini(struct drm_device *drm)
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
+			dev_dbg(drm->dev, "unregister_framebuffer(): %d\n", err);
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
+
+static int tegra_drm_unload(struct drm_device *drm)
+{
+	struct tegra_drm_private *priv = drm->dev_private;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+
+	tegra_drm_fbdev_fini(drm);
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
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_drm_open(struct drm_device *drm, struct drm_file *filp)
+{
+	int ret = 0;
+	dev_dbg(drm->dev, "> %s(drm=%p, filp=%p)\n", __func__, drm, filp);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
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
+	int ret = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p, state=[%d])\n", __func__, drm, state.event);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_drm_resume(struct drm_device *drm)
+{
+	int ret = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p)\n", __func__, drm);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_drm_enable_vblank(struct drm_device *drm, int crtc)
+{
+	int ret = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(drm=%p, crtc=%d)\n", __func__, drm, crtc);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_drm_disable_vblank(struct drm_device *drm, int crtc)
+{
+	dev_dbg(drm->dev, "> %s(drm=%p, crtc=%d)\n", __func__, drm, crtc);
+	dev_dbg(drm->dev, "< %s()\n", __func__);
+}
+
+static int tegra_gem_handle_create(struct drm_device *drm,
+				   struct drm_file *file, size_t size,
+				   unsigned long flags, u32 *handle)
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
+static inline unsigned int align_pitch(unsigned int pitch, unsigned int width, unsigned int bpp)
+{
+	return max(pitch, width * DIV_ROUND_UP(bpp, 8));
+}
+
+static int tegra_gem_dumb_create(struct drm_file *file,
+				 struct drm_device *drm,
+				 struct drm_mode_create_dumb *args)
+{
+	int ret = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, args=%p)\n", __func__, file, drm, args);
+
+	args->pitch = align_pitch(args->pitch, args->width, args->bpp);
+	args->size = PAGE_ALIGN(args->pitch * args->height);
+
+	ret = tegra_gem_handle_create(drm, file, args->size, 0, &args->handle);
+
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static int tegra_gem_dumb_map_offset(struct drm_file *file,
+				     struct drm_device *drm,
+				     uint32_t handle, uint64_t *offset)
+{
+	struct tegra_gem_object *gem;
+	struct drm_gem_object *obj;
+	int ret = 0;
+
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, handle=%x, offset=%p)\n", __func__, file, drm, handle, offset);
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
+static int tegra_gem_dumb_destroy(struct drm_file *file,
+				  struct drm_device *drm,
+				  uint32_t handle)
+{
+	int ret = -ENOSYS;
+	dev_dbg(drm->dev, "> %s(file=%p, drm=%p, handle=%x)\n", __func__, file, drm, handle);
+	ret = drm_gem_handle_delete(file, handle);
+	dev_dbg(drm->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static struct drm_ioctl_desc tegra_drm_ioctls[] = {
+};
+
+static int tegra_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
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
+	int ret = 0;
+	dev_dbg(minor->dev->dev, "> %s(minor=%p)\n", __func__, minor);
+	dev_dbg(minor->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_debugfs_cleanup(struct drm_minor *minor)
+{
+	dev_dbg(minor->dev->dev, "> %s(minor=%p)\n", __func__, minor);
+	dev_dbg(minor->dev->dev, "< %s()\n", __func__);
+}
+
+static int tegra_gem_init_object(struct drm_gem_object *obj)
+{
+	int ret = -ENOSYS;
+	dev_dbg(obj->dev->dev, "> %s(obj=%p)\n", __func__, obj);
+	dev_dbg(obj->dev->dev, "< %s() = %d\n", __func__, ret);
+	return ret;
+}
+
+static void tegra_gem_free_object(struct drm_gem_object *obj)
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
+static struct vm_operations_struct tegra_gem_vm_ops = {
+	.fault = tegra_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
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
+static const struct {
+	enum tegra_drm_panel_type type;
+	const char *name;
+} tegra_drm_panel_types[] = {
+	{ TEGRA_DRM_PANEL_RGB, "rgb" },
+};
+
+static int tegra_drm_lookup_panel_type(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_drm_panel_types); i++) {
+		if (strcasecmp(name, tegra_drm_panel_types[i].name) == 0)
+			return tegra_drm_panel_types[i].type;
+	}
+
+	return -EINVAL;
+}
+
+static int tegra_drm_parse_dt_mode(struct device *dev,
+				   struct device_node *node,
+				   struct tegra_drm_mode *mode)
+{
+	u32 resolution[2];
+	u32 timings[4];
+	u32 value;
+	int err;
+
+	err = of_property_read_u32(node, "pixel-clock", &value);
+	if (err < 0)
+		return err;
+
+	mode->pixel_clock = value;
+
+	err = of_property_read_u32(node, "vertical-refresh", &value);
+	if (err < 0)
+		return err;
+
+	mode->vrefresh = value;
+
+	err = of_property_read_u32_array(node, "resolution", resolution,
+					 ARRAY_SIZE(resolution));
+	if (err < 0)
+		return err;
+
+	mode->width = resolution[0];
+	mode->height = resolution[1];
+
+	err = of_property_read_u32(node, "bits-per-pixel", &value);
+	if (err < 0)
+		return err;
+
+	mode->bpp = value;
+
+	err = of_property_read_u32_array(node, "horizontal-timings", timings,
+					 ARRAY_SIZE(timings));
+	if (err < 0)
+		return err;
+
+	mode->href_to_sync = timings[0];
+	mode->hsync_width = timings[1];
+	mode->hback_porch = timings[2];
+	mode->hfront_porch = timings[3];
+
+	err = of_property_read_u32_array(node, "vertical-timings", timings,
+					 ARRAY_SIZE(timings));
+	if (err < 0)
+		return err;
+
+	mode->vref_to_sync = timings[0];
+	mode->vsync_width = timings[1];
+	mode->vback_porch = timings[2];
+	mode->vfront_porch = timings[3];
+
+	return 0;
+}
+
+static int tegra_drm_parse_dt_panel(struct device *dev,
+				    struct device_node *node,
+				    struct tegra_drm_panel *panel)
+{
+	struct tegra_drm_mode *mode;
+	struct device_node *child;
+	unsigned int count = 0;
+	const char *type;
+	u32 sizes[2];
+	int err;
+
+	err = of_property_read_string(node, "type", &type);
+	if (err < 0) {
+		dev_err(dev, "failed to read \"type\" property: %d\n", err);
+		return err;
+	}
+
+	err = tegra_drm_lookup_panel_type(type);
+	if (err < 0) {
+		dev_err(dev, "failed to look up panel type: %d\n", err);
+		return err;
+	}
+
+	panel->type = err;
+
+	err = of_property_read_u32_array(node, "size", sizes,
+					 ARRAY_SIZE(sizes));
+	if (err < 0) {
+		dev_err(dev, "failed to parse \"size\" property: %d\n", err);
+		return err;
+	}
+
+	panel->width = sizes[0];
+	panel->height = sizes[1];
+
+	for_each_child_of_node(node, child)
+		count++;
+
+	if (count == 0) {
+		dev_err(dev, "no modes specified\n");
+		return -EINVAL;
+	}
+
+	panel->modes = devm_kzalloc(dev, count * sizeof(*mode), GFP_KERNEL);
+	if (!panel->modes) {
+		dev_err(dev, "failed to allocate modes\n");
+		return -ENOMEM;
+	}
+
+	for_each_child_of_node(node, child) {
+		mode = &panel->modes[panel->num_modes];
+
+		err = tegra_drm_parse_dt_mode(dev, child, mode);
+		if (err < 0) {
+			dev_err(dev, "tegra_drm_parse_dt_mode(): %d\n", err);
+			continue;
+		}
+
+		panel->num_modes++;
+	}
+
+	return 0;
+}
+
+static int tegra_drm_parse_dt(struct platform_device *pdev)
+{
+	struct tegra_drm_platform_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct tegra_drm_panel *panel;
+	struct device_node *child;
+	unsigned int count = 0;
+	unsigned int i, j;
+	int err;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	for_each_child_of_node(dev->of_node, child)
+		count++;
+
+	if (count == 0) {
+		dev_err(dev, "no panel definitions found\n");
+		return -EINVAL;
+	}
+
+	pdata->panels = devm_kzalloc(dev, count * sizeof(*panel), GFP_KERNEL);
+	if (!pdata->panels) {
+		dev_err(dev, "failed to allocate panels\n");
+		return -ENOMEM;
+	}
+
+	for_each_child_of_node(dev->of_node, child) {
+		panel = &pdata->panels[pdata->num_panels];
+
+		err = tegra_drm_parse_dt_panel(&pdev->dev, child, panel);
+		if (err < 0) {
+			dev_err(dev, "tegra_drm_parse_dt_panel(): %d\n", err);
+			continue;
+		}
+
+		pdata->num_panels++;
+	}
+
+	for (i = 0; i < pdata->num_panels; i++) {
+		struct tegra_drm_panel *panel = &pdata->panels[i];
+
+		dev_dbg(dev, "panel %u:\n", i);
+		dev_dbg(dev, "  type: %d\n", panel->type);
+		dev_dbg(dev, "  size: %ux%u\n", panel->width, panel->height);
+
+		for (j = 0; j < panel->num_modes; j++) {
+			struct tegra_drm_mode *mode = &panel->modes[j];
+
+			dev_dbg(dev, "  mode: %u\n", j);
+			dev_dbg(dev, "    pixel-clock: %u\n", mode->pixel_clock);
+			dev_dbg(dev, "    resolution: %ux%ux%u\n",
+				 mode->width, mode->height, mode->bpp);
+
+			dev_dbg(dev, "    horizontal timings:\n");
+			dev_dbg(dev, "      ref-to-sync: %u\n", mode->href_to_sync);
+			dev_dbg(dev, "      sync-width: %u\n", mode->hsync_width);
+			dev_dbg(dev, "      back porch: %u\n", mode->hback_porch);
+			dev_dbg(dev, "      front porch: %u\n", mode->hfront_porch);
+
+			dev_dbg(dev, "    vertical timings:\n");
+			dev_dbg(dev, "      ref-to-sync: %u\n", mode->vref_to_sync);
+			dev_dbg(dev, "      sync-width: %u\n", mode->vsync_width);
+			dev_dbg(dev, "      back porch: %u\n", mode->vback_porch);
+			dev_dbg(dev, "      front porch: %u\n", mode->vfront_porch);
+		}
+	}
+
+	dev->platform_data = pdata;
+	return 0;
+}
+
+static int __devinit tegra_drm_probe(struct platform_device *pdev)
+{
+	struct tegra_drm_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *node = pdev->dev.of_node;
+	int err;
+
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	if (!pdata && node) {
+		err = tegra_drm_parse_dt(pdev);
+		if (err < 0)
+			goto out;
+	}
+
+	err = drm_platform_init(&drm_driver, pdev);
+
+out:
+	dev_dbg(&pdev->dev, "< %s() = %d\n", __func__, err);
+	return err;
+}
+
+static int __devexit tegra_drm_remove(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "> %s(pdev=%p)\n", __func__, pdev);
+
+	drm_platform_exit(&drm_driver, pdev);
+	pdev->dev.platform_data = NULL;
+
+	dev_dbg(&pdev->dev, "< %s()\n", __func__);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id tegra_drm_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-drm", },
+	{ },
+};
+#endif
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
+module_platform_driver(tegra_drm_driver);
+
+MODULE_AUTHOR("Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tegra/tegra_drv.h b/drivers/gpu/drm/tegra/tegra_drv.h
new file mode 100644
index 0000000..c0ab341
--- /dev/null
+++ b/drivers/gpu/drm/tegra/tegra_drv.h
@@ -0,0 +1,184 @@
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
+#define CMD_GENERAL_INCR_SYNCPT_CTRL 0x001
+#define CMD_CONT_SYNCPT_VSYNC 0x028
+#define CMD_DISP_CMD 0x032
+#define CMD_DISP_CMD_CTRL_MODE_STOP (0 << 5)
+#define CMD_DISP_CMD_CTRL_MODE_C_DISPLAY (1 << 5)
+#define CMD_DISP_CMD_CTRL_MODE_NC_DISPLAY (2 << 5)
+#define CMD_DISP_POWER_CTRL 0x036
+#define CMD_DISP_POWER_CTRL_PW0_ENABLE (1 <<  0)
+#define CMD_DISP_POWER_CTRL_PW1_ENABLE (1 <<  2)
+#define CMD_DISP_POWER_CTRL_PW2_ENABLE (1 <<  4)
+#define CMD_DISP_POWER_CTRL_PW3_ENABLE (1 <<  6)
+#define CMD_DISP_POWER_CTRL_PW4_ENABLE (1 <<  8)
+#define CMD_DISP_POWER_CTRL_PM0_ENABLE (1 << 16)
+#define CMD_DISP_POWER_CTRL_PM1_ENABLE (1 << 18)
+
+#define CMD_INT_STATUS 0x037
+#define CMD_INT_MASK 0x038
+#define CMD_INT_ENABLE 0x039
+#define CMD_INT_TYPE 0x03a
+#define CMD_INT_POLARITY 0x03b
+#define INT_FRAME_END (1 << 1)
+#define INT_VBLANK (1 << 2)
+#define INT_WIN_A_UF (1 << 8)
+#define INT_WIN_B_UF (1 << 9)
+#define INT_WIN_C_UF (1 << 10)
+#define INT_WIN_A_OF (1 << 14)
+#define INT_WIN_B_OF (1 << 15)
+#define INT_WIN_C_OF (1 << 16)
+
+#define COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
+#define COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
+#define COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
+#define COM_PIN_OUTPUT_SEL(x) (0x314 + (x))
+
+#define COM_PIN_OUTPUT_POLARITY_PIN1_LVS_OUTPUT (1 << 28)
+#define COM_PIN_OUTPUT_POLARITY_PIN1_LHS_OUTPUT (1 << 30)
+
+#define DISP_MEM_HIGH_PRI 0x403
+#define DISP_MEM_HIGH_PRI_TIMER 0x404
+#define DISP_TIMING_OPT 0x405
+#define DISP_REF_TO_SYNC 0x406
+#define DISP_SYNC_WIDTH 0x407
+#define DISP_BACK_PORCH 0x408
+#define DISP_ACTIVE 0x409
+#define DISP_FRONT_PORCH 0x40a
+
+#define DISP_DATA_ENABLE_OPT 0x432
+#define DISP_DATA_ENABLE_OPT_SELECT_ACTIVE_BLANK (0 << 0)
+#define DISP_DATA_ENABLE_OPT_SELECT_ACTIVE (1 << 0)
+#define DISP_DATA_ENABLE_OPT_SELECT_ACTIVE_IS (2 << 0)
+#define DISP_DATA_ENABLE_OPT_CONTROL_ONECLK (0 << 2)
+#define DISP_DATA_ENABLE_OPT_CONTROL_NORMAL (1 << 2)
+#define DISP_DATA_ENABLE_OPT_CONTROL_EARLY_EXT (2 << 2)
+#define DISP_DATA_ENABLE_OPT_CONTROL_EARLY (3 << 2)
+#define DISP_DATA_ENABLE_OPT_CONTROL_ACTIVE_BLANK (4 << 2)
+
+#define DISP_INTERFACE_CTRL 0x42f
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P1C (0 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P2C24B (1 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P2C18B (2 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P2C16B (3 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF2S (4 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF3S (5 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DFSPI (6 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P3C24B (7 << 0)
+#define DISP_INTERFACE_CTRL_DATA_FORMAT_DF1P3C18B (8 << 0)
+#define DISP_INTERFACE_CTRL_ALIGN_MSB (0 << 8)
+#define DISP_INTERFACE_CTRL_ALIGN_LSB (1 << 8)
+#define DISP_INTERFACE_CTRL_ORDER_RED_BLUE (0 << 9)
+#define DISP_INTERFACE_CTRL_ORDER_BLUE_RED (1 << 9)
+
+#define DISP_SHIFT_CLK_OPT 0x431
+
+#define DISP_CLK_CTRL 0x42e
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD1 (0 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD1H (1 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD2 (2 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD3 (3 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD4 (4 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD6 (5 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD8 (6 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD9 (7 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD12 (8 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD16 (9 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD18 (10 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD24 (11 << 8)
+#define DISP_CLK_CTRL_PIXEL_CLK_DIV_PCD13 (12 << 8)
+#define DISP_CLK_CTRL_CLK_DIV(x) ((x) & 0xff)
+
+#define CMD_WIN_HEADER 0x042
+#define CMD_WIN_HEADER_WINDOW_A_SELECT (1 << 4)
+#define CMD_WIN_HEADER_WINDOW_B_SELECT (1 << 5)
+#define CMD_WIN_HEADER_WINDOW_C_SELECT (1 << 6)
+
+#define WIN_COLOR_DEPTH 0x703
+#define WIN_COLOR_DEPTH_P1 0
+#define WIN_COLOR_DEPTH_P2 1
+#define WIN_COLOR_DEPTH_P4 2
+#define WIN_COLOR_DEPTH_P8 3
+#define WIN_COLOR_DEPTH_B4G4R4A4 4
+#define WIN_COLOR_DEPTH_B5G5R5A 5
+#define WIN_COLOR_DEPTH_B5G6R5 6
+#define WIN_COLOR_DEPTH_AB5G5R5 7
+#define WIN_COLOR_DEPTH_B8G8R8A8 12
+#define WIN_COLOR_DEPTH_R8G8B8A8 13
+#define WIN_COLOR_DEPTH_B6x2G6x2R6x2A8 14
+#define WIN_COLOR_DEPTH_R6x2G6x2B6x2A8 15
+#define WIN_COLOR_DEPTH_YCbCr422 16
+#define WIN_COLOR_DEPTH_YUV422 17
+#define WIN_COLOR_DEPTH_YCbCr420P 18
+#define WIN_COLOR_DEPTH_YUV420P 19
+#define WIN_COLOR_DEPTH_YCbCr422P 20
+#define WIN_COLOR_DEPTH_YUV422P 21
+#define WIN_COLOR_DEPTH_YCbCr422R 22
+#define WIN_COLOR_DEPTH_YUV422R 23
+#define WIN_COLOR_DEPTH_YCbCr422RA 24
+#define WIN_COLOR_DEPTH_YUV422RA 25
+
+#define WIN_BYTE_SWAP 0x701
+#define WIN_BYTE_SWAP_NOSWAP (0 << 0)
+#define WIN_BYTE_SWAP_SWAP2 (1 << 0)
+#define WIN_BYTE_SWAP_SWAP4 (2 << 0)
+#define WIN_BYTE_SWAP_SWAP4HW (3 << 0)
+
+#define WIN_POSITION 0x704
+#define WIN_POSITION_H(x) (((x) & 0x1fff) <<  0)
+#define WIN_POSITION_V(x) (((x) & 0x1fff) << 16)
+
+#define WIN_SIZE 0x705
+#define WIN_SIZE_H(x) (((x) & 0x1fff) <<  0)
+#define WIN_SIZE_V(x) (((x) & 0x1fff) << 16)
+
+#define WIN_PRESCALED_SIZE 0x706
+#define WIN_PRESCALED_SIZE_H(x) (((x) & 0x7fff) <<  0)
+#define WIN_PRESCALED_SIZE_V(x) (((x) & 0x1fff) << 16)
+
+#define WIN_H_INITIAL_DDA 0x707
+#define WIN_V_INITIAL_DDA 0x708
+
+#define WIN_DDA_INC 0x709
+#define WIN_DDA_INC_H(x) (((x) & 0xffff) <<  0)
+#define WIN_DDA_INC_V(x) (((x) & 0xffff) << 16)
+
+#define WIN_LINE_STRIDE 0x70a
+#define WIN_BUF_STRIDE 0x70b
+#define WIN_UV_BUF_STRIDE 0x70c
+
+#define WIN_OPT 0x700
+#define WIN_OPT_COLOR_EXPAND (1 << 6)
+#define WIN_OPT_ENABLE (1 << 30)
+
+#define WINBUF_START_ADDR 0x800
+#define WINBUF_ADDR_H_OFFSET 0x806
+#define WINBUF_ADDR_V_OFFSET 0x808
+
+#define WIN_BLEND_NOKEY 0x70f
+#define WIN_BLEND_1WIN 0x710
+
+#define CMD_STATE_CTRL 0x041
+#define CMD_STATE_CTRL_GENERAL_ACT_REQ	(1 <<  0)
+#define CMD_STATE_CTRL_WIN_A_ACT_REQ	(1 <<  1)
+#define CMD_STATE_CTRL_WIN_B_ACT_REQ	(1 <<  2)
+#define CMD_STATE_CTRL_WIN_C_ACT_REQ	(1 <<  3)
+#define CMD_STATE_CTRL_GENERAL_UPDATE	(1 <<  8)
+#define CMD_STATE_CTRL_WIN_A_UPDATE	(1 <<  9)
+#define CMD_STATE_CTRL_WIN_B_UPDATE	(1 << 10)
+#define CMD_STATE_CTRL_WIN_C_UPDATE	(1 << 11)
+
+/* synchronization points */
+#define SYNCPT_VBLANK0 26
+#define SYNCPT_VBLANK1 27
+
+#endif /* TEGRA_DRV_H */
diff --git a/include/drm/tegra_drm.h b/include/drm/tegra_drm.h
new file mode 100644
index 0000000..b3dd44a
--- /dev/null
+++ b/include/drm/tegra_drm.h
@@ -0,0 +1,44 @@
+#ifndef _TEGRA_DRM_H_
+#define _TEGRA_DRM_H_
+
+enum tegra_drm_panel_type {
+	TEGRA_DRM_PANEL_RGB,
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
+struct tegra_drm_panel {
+	enum tegra_drm_panel_type type;
+
+	/* physical size */
+	unsigned int width;
+	unsigned int height;
+
+	/* display modes */
+	struct tegra_drm_mode *modes;
+	unsigned int num_modes;
+};
+
+struct tegra_drm_platform_data {
+	struct tegra_drm_panel *panels;
+	unsigned int num_panels;
+};
+
+#endif
-- 
1.7.10
