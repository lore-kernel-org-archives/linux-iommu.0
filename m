From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Mon, 15 Jun 2015 15:36:42 +0200
Message-ID: <1434375402-12849-1-git-send-email-m.szyprowski@samsung.com>
References: <557E7C5A.4020300@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <557E7C5A.4020300@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: iommu@lists.linux-foundation.org

One should not do any assumptions on the stare of the fimd hardware
during driver initialization, so to properly reset fimd before enabling
IOMMU, one should ensure that all power domains and clocks are really
enabled. This patch adds pm_runtime and clocks management in the
fimd_clear_channel() function to ensure that any access to fimd
registers will be performed with clocks and power domains enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
Changelog:
v4:
- added temporary changing of ctx->pipe to -1 to avoid propagating vblank
  to drm core

v3 (alternative):
- araranged code by moving fimd_{enable,disable}_vblank functions before
  fimd_clear_channel to avoid forward declaration usage

v2:
- rebased onto latest exynos-drm-next branch with atomic mode setting
  patches applied.
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 135 ++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 96618534358e..f35a6f197f58 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -196,6 +196,62 @@ static inline struct fimd_driver_data *drm_fimd_get_driver_data(
 	return (struct fimd_driver_data *)of_id->data;
 }
 
+static int fimd_enable_vblank(struct exynos_drm_crtc *crtc)
+{
+	struct fimd_context *ctx = crtc->ctx;
+	u32 val;
+
+	if (ctx->suspended)
+		return -EPERM;
+
+	if (!test_and_set_bit(0, &ctx->irq_flags)) {
+		val = readl(ctx->regs + VIDINTCON0);
+
+		val |= VIDINTCON0_INT_ENABLE;
+
+		if (ctx->i80_if) {
+			val |= VIDINTCON0_INT_I80IFDONE;
+			val |= VIDINTCON0_INT_SYSMAINCON;
+			val &= ~VIDINTCON0_INT_SYSSUBCON;
+		} else {
+			val |= VIDINTCON0_INT_FRAME;
+
+			val &= ~VIDINTCON0_FRAMESEL0_MASK;
+			val |= VIDINTCON0_FRAMESEL0_VSYNC;
+			val &= ~VIDINTCON0_FRAMESEL1_MASK;
+			val |= VIDINTCON0_FRAMESEL1_NONE;
+		}
+
+		writel(val, ctx->regs + VIDINTCON0);
+	}
+
+	return 0;
+}
+
+static void fimd_disable_vblank(struct exynos_drm_crtc *crtc)
+{
+	struct fimd_context *ctx = crtc->ctx;
+	u32 val;
+
+	if (ctx->suspended)
+		return;
+
+	if (test_and_clear_bit(0, &ctx->irq_flags)) {
+		val = readl(ctx->regs + VIDINTCON0);
+
+		val &= ~VIDINTCON0_INT_ENABLE;
+
+		if (ctx->i80_if) {
+			val &= ~VIDINTCON0_INT_I80IFDONE;
+			val &= ~VIDINTCON0_INT_SYSMAINCON;
+			val &= ~VIDINTCON0_INT_SYSSUBCON;
+		} else
+			val &= ~VIDINTCON0_INT_FRAME;
+
+		writel(val, ctx->regs + VIDINTCON0);
+	}
+}
+
 static void fimd_wait_for_vblank(struct exynos_drm_crtc *crtc)
 {
 	struct fimd_context *ctx = crtc->ctx;
@@ -248,6 +304,12 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
+	/* Hardware is in unknown state, so ensure it gets enabled properly */
+	pm_runtime_get_sync(ctx->dev);
+
+	clk_prepare_enable(ctx->bus_clk);
+	clk_prepare_enable(ctx->lcd_clk);
+
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
 		u32 val = readl(ctx->regs + WINCON(win));
@@ -265,12 +327,24 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled) {
-		unsigned int state = ctx->suspended;
+		int pipe = ctx->pipe;
+
+		/* ensure that vblank interrupt won't be reported to core */
+		ctx->suspended = false;
+		ctx->pipe = -1;
 
-		ctx->suspended = 0;
+		fimd_enable_vblank(ctx->crtc);
 		fimd_wait_for_vblank(ctx->crtc);
-		ctx->suspended = state;
+		fimd_disable_vblank(ctx->crtc);
+
+		ctx->suspended = true;
+		ctx->pipe = pipe;
 	}
+
+	clk_disable_unprepare(ctx->lcd_clk);
+	clk_disable_unprepare(ctx->bus_clk);
+
+	pm_runtime_put(ctx->dev);
 }
 
 static int fimd_iommu_attach_devices(struct fimd_context *ctx,
@@ -434,61 +508,6 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
-static int fimd_enable_vblank(struct exynos_drm_crtc *crtc)
-{
-	struct fimd_context *ctx = crtc->ctx;
-	u32 val;
-
-	if (ctx->suspended)
-		return -EPERM;
-
-	if (!test_and_set_bit(0, &ctx->irq_flags)) {
-		val = readl(ctx->regs + VIDINTCON0);
-
-		val |= VIDINTCON0_INT_ENABLE;
-
-		if (ctx->i80_if) {
-			val |= VIDINTCON0_INT_I80IFDONE;
-			val |= VIDINTCON0_INT_SYSMAINCON;
-			val &= ~VIDINTCON0_INT_SYSSUBCON;
-		} else {
-			val |= VIDINTCON0_INT_FRAME;
-
-			val &= ~VIDINTCON0_FRAMESEL0_MASK;
-			val |= VIDINTCON0_FRAMESEL0_VSYNC;
-			val &= ~VIDINTCON0_FRAMESEL1_MASK;
-			val |= VIDINTCON0_FRAMESEL1_NONE;
-		}
-
-		writel(val, ctx->regs + VIDINTCON0);
-	}
-
-	return 0;
-}
-
-static void fimd_disable_vblank(struct exynos_drm_crtc *crtc)
-{
-	struct fimd_context *ctx = crtc->ctx;
-	u32 val;
-
-	if (ctx->suspended)
-		return;
-
-	if (test_and_clear_bit(0, &ctx->irq_flags)) {
-		val = readl(ctx->regs + VIDINTCON0);
-
-		val &= ~VIDINTCON0_INT_ENABLE;
-
-		if (ctx->i80_if) {
-			val &= ~VIDINTCON0_INT_I80IFDONE;
-			val &= ~VIDINTCON0_INT_SYSMAINCON;
-			val &= ~VIDINTCON0_INT_SYSSUBCON;
-		} else
-			val &= ~VIDINTCON0_INT_FRAME;
-
-		writel(val, ctx->regs + VIDINTCON0);
-	}
-}
 
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win)
 {
-- 
1.9.2
