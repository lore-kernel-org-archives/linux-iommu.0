From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 04/25] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Mon, 04 May 2015 10:15:59 +0200
Message-ID: <1430727380-10912-5-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

One should not do any assumptions on the stare of the fimd hardware
during driver initialization, so to properly reset fimd before enabling
IOMMU, one should ensure that all power domains and clocks are really
enabled. This patch adds calls to power on/off in the
fimd_clear_channel() function to ensure that any access to fimd
registers will be performed with clocks and power domains enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 9819fa6a9e2a..cf64550df59d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -242,12 +242,20 @@ static void fimd_enable_shadow_channel_path(struct fimd_context *ctx, int win,
 	writel(val, ctx->regs + SHADOWCON);
 }
 
-static void fimd_clear_channel(struct fimd_context *ctx)
+static int fimd_poweron(struct fimd_context *ctx);
+static int fimd_poweroff(struct fimd_context *ctx);
+
+static int fimd_clear_channel(struct fimd_context *ctx)
 {
-	int win, ch_enabled = 0;
+	int ret, win, ch_enabled = 0;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
+	/* Hardware is in unknown state, so ensure it get enabled properly */
+	ret = fimd_poweron(ctx);
+	if (ret)
+		return ret;
+
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
 		u32 val = readl(ctx->regs + WINCON(win));
@@ -258,19 +266,15 @@ static void fimd_clear_channel(struct fimd_context *ctx)
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
@@ -285,7 +289,10 @@ static int fimd_iommu_attach_devices(struct fimd_context *ctx,
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
