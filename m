From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/3] drm/exynos: fimd: ensure proper hw state in
 fimd_clear_channel()
Date: Fri, 12 Jun 2015 11:07:16 +0200
Message-ID: <1434100037-12304-1-git-send-email-m.szyprowski@samsung.com>
References: <557AA0D3.8010808@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <557AA0D3.8010808@samsung.com>
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
v3:
- replaced forward declaration and calls to fimd_{enable,disable}_vblank
  functions by calls throught ctrt ops

v2:
- rebased onto latest exynos-drm-next branch with atomic mode setting
  patches applied.
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 96618534358e..c67bb6b97399 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -248,6 +248,12 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 
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
@@ -265,12 +271,22 @@ static void fimd_clear_channel(struct fimd_context *ctx)
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled) {
-		unsigned int state = ctx->suspended;
-
-		ctx->suspended = 0;
-		fimd_wait_for_vblank(ctx->crtc);
-		ctx->suspended = state;
+		const struct exynos_drm_crtc_ops *ops = ctx->crtc->ops;
+
+		ctx->suspended = false;
+		if (ops->enable_vblank)
+			ops->enable_vblank(ctx->crtc);
+		if (ops->wait_for_vblank)
+			ops->wait_for_vblank(ctx->crtc);
+		if (ops->disable_vblank)
+			ops->disable_vblank(ctx->crtc);
+		ctx->suspended = true;
 	}
+
+	clk_disable_unprepare(ctx->lcd_clk);
+	clk_disable_unprepare(ctx->bus_clk);
+
+	pm_runtime_put(ctx->dev);
 }
 
 static int fimd_iommu_attach_devices(struct fimd_context *ctx,
-- 
1.9.2
