From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 12/29] DRM: Exynos: fix window clear code
Date: Tue, 05 Aug 2014 12:47:40 +0200
Message-ID: <1407235677-26324-13-git-send-email-m.szyprowski@samsung.com>
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

To correctly disable hardware window during driver init, both enable bits
(WINCONx_ENWIN in WINCON and SHADOWCON_CHx_ENABLE in SHADOWCON) must be
cleared, otherwise hardware fails to re-enable such window later.

While touching this function, also temporarily disable ctx->suspended flag
to let fimd_wait_for_vblank function really to do its job.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 41904df..7a363d2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -165,27 +165,38 @@ static void fimd_wait_for_vblank(struct exynos_drm_manager *mgr)
 		DRM_DEBUG_KMS("vblank wait timed out.\n");
 }
 
-
 static void fimd_clear_channel(struct exynos_drm_manager *mgr)
 {
 	struct fimd_context *ctx = mgr->ctx;
-	int win, ch_enabled = 0;
+	int state, win, ch_enabled = 0;
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
-		u32 val = readl(ctx->regs + SHADOWCON);
-		if (val & SHADOWCON_CHx_ENABLE(win)) {
-			val &= ~SHADOWCON_CHx_ENABLE(win);
-			writel(val, ctx->regs + SHADOWCON);
+		u32 val = readl(ctx->regs + WINCON(win));
+		if (val & WINCONx_ENWIN) {
+			/* wincon */
+			val &= ~WINCONx_ENWIN;
+			writel(val, ctx->regs + WINCON(win));
+
+			/* unprotect windows */
+			if (ctx->driver_data->has_shadowcon) {
+				val = readl(ctx->regs + SHADOWCON);
+				val &= ~SHADOWCON_CHx_ENABLE(win);
+				writel(val, ctx->regs + SHADOWCON);
+			}
 			ch_enabled = 1;
 		}
 	}
 
 	/* Wait for vsync, as disable channel takes effect at next vsync */
-	if (ch_enabled)
+	if (ch_enabled) {
+		state = ctx->suspended;
+		ctx->suspended = 0;
 		fimd_wait_for_vblank(mgr);
+		ctx->suspended = state;
+	}
 }
 
 static int fimd_mgr_initialize(struct exynos_drm_manager *mgr,
-- 
1.9.2
