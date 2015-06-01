From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Mon, 01 Jun 2015 13:15:14 +0200
Message-ID: <1433157316-6341-2-git-send-email-m.szyprowski@samsung.com>
References: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

One should not do any assumptions on the stare of the fimd hardware
during driver initialization, so to properly reset fimd before enabling
IOMMU, one should ensure that all power domains and clocks are really
enabled. This patch adds calls to power on/off in the
fimd_clear_channel() function to ensure that any access to fimd
registers will be performed with clocks and power domains enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index a0edab833148..d10ad3920e78 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -242,12 +242,21 @@ static void fimd_enable_shadow_channel_path(struct fimd_context *ctx,
 	writel(val, ctx->regs + SHADOWCON);
 }
 
-static void fimd_clear_channel(struct fimd_context *ctx)
+static int fimd_poweron(struct fimd_context *ctx);
+static int fimd_poweroff(struct fimd_context *ctx);
+
+static int fimd_clear_channel(struct fimd_context *ctx)
 {
 	unsigned int win, ch_enabled = 0;
+	int ret;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
+	/* Hardware is in unknown state, so ensure it get enabled properly */
+	ret = fimd_poweron(ctx);
+	if (ret)
+		return ret;
+
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
 		u32 val = readl(ctx->regs + WINCON(win));
@@ -258,19 +267,15 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 			if (ctx->driver_data->has_shadowcon)
 				fimd_enable_shadow_channel_path(ctx, win,
 								false);
-
 			ch_enabled = 1;
 		}
 	}
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
-	if (ch_enabled) {
-		unsigned int state = ctx->suspended;
-
-		ctx->suspended = 0;
+	if (ch_enabled)
 		fimd_wait_for_vblank(ctx->crtc);
-		ctx->suspended = state;
-	}
+
+	return fimd_poweroff(ctx);
 }
 
 static int fimd_iommu_attach_devices(struct fimd_context *ctx,
@@ -285,7 +290,10 @@ static int fimd_iommu_attach_devices(struct fimd_context *ctx,
 		 * If any channel is already active, iommu will throw
 		 * a PAGE FAULT when enabled. So clear any channel if enabled.
 		 */
-		fimd_clear_channel(ctx);
+		ret = fimd_clear_channel(ctx);
+		if (ret)
+			return ret;
+
 		ret = drm_iommu_attach_device(ctx->drm_dev, ctx->dev);
 		if (ret) {
 			DRM_ERROR("drm_iommu_attach failed.\n");
-- 
1.9.2
